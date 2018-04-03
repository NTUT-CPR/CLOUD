package ISMonitor;
import JClouds.JCloudsNova;
import org.jclouds.openstack.nova.v2_0.domain.Server;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintStream;
import java.net.*;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * Created by thefalling on 2018/3/15.
 */
public class ISMonitor {
    private static ArrayList<ISModel> ISList;
    private String ISState;
    private String ISJob;
    private String ISStateTime;
    JCloudsNova jcloudsNova = new JCloudsNova();
    SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");


    public ISMonitor(){
        ISList=new ArrayList<ISModel>();
        ISState="offline";
        ISStateTime=null;
    }
    public static ArrayList<ISModel> getISList(){
        return ISList;
    }

    public void restartISOfflineVM(ISModel isModel){
        jcloudsNova.softRebootServer(isModel.getVmID());
    }

    public ArrayList<ISModel> setISModel(ISModel isModel,String isState,ArrayList<ISModel> temp){
        if(isState.equals("offline")){
            isModel.setISState("offline");
            System.out.println("VM "+isModel.getVmName()+" working status is offline");

            //離線次數增加1
            isModel.setISOfflineTime(isModel.getISOfflineTime()+1);
            //離線次數超過5次重啓虛擬機
            if(isModel.getISOfflineTime()>=5&&isModel.getVmID().equals("9e2b52a2-4230-48ba-afec-1bf5734531d4")){
                restartISOfflineVM(isModel);
                //isModel.setISOfflineTime(0);
            }

        }else{
            //如果有上線，離線次數清零
            isModel.setISOfflineTime(0);

            isModel.setISState(ISState);
            System.out.println("VM "+isModel.getVmName()+" working status is "+ISState);
        }
        Date date = new Date();
        ISStateTime=dateFormat.format(date);
        isModel.setISStateTime(ISStateTime);
        System.out.println("VM "+isModel.getVmName()+" working status is "+ISStateTime);

        temp.add(isModel);
        return temp;
    }


    public void getAllVmIsState(){
        List<Server> servers=jcloudsNova.getServers();

        ArrayList<ISModel> temp=new ArrayList<ISModel>();

        for(int i=0;i<servers.size();i++){
            ISModel isModel=new ISModel();
            String VmName=servers.get(i).getName();
            String VmID=servers.get(i).getId();
            String VmIP=servers.get(i).getAddresses().get("media_net").iterator().next().getAddr();
            String VmState=servers.get(i).getStatus().value();
            isModel.setVmName(VmName);
            isModel.setVmID(VmID);
            isModel.setVmIP(VmIP);
            isModel.setVmState(VmState);

            //如果VM不是開機狀態則跳過以下設值操作
            if(!VmState.equals("ACTIVE")){
                isModel.setISState("off");
                temp.add(isModel);
                continue;
            }


            //從上一次的ISList中取出對應VM名字的VM中IS的離線次數更新，沒有對應名字的VM則不操作
            for(ISModel is:ISList){
                if(is.getVmName().equals(VmName)){
                    isModel.setISOfflineTime(is.getISOfflineTime());
                }
            }

            try{
                Socket socket=new Socket();
                SocketAddress socketAddress = new InetSocketAddress("127.0.0.1", 3214);
                //設置連接超時，ip不存在時，1秒後捕捉異常
                socket.connect(socketAddress,1000);
                //设置从Socket读取数据超时
                socket.setSoTimeout(1000);
                System.out.println("connected to:"+socket.getInetAddress()+":"+socket.getPort());

                PrintStream clientOut = new PrintStream(socket.getOutputStream());
                String str="status";
                clientOut.println(str);
                clientOut.flush();

                BufferedReader clientIn=new BufferedReader(new InputStreamReader(socket.getInputStream()));
                ISState=clientIn.readLine();
                ISJob=clientIn.readLine();
                System.out.println("VM working status is "+ISState);
                System.out.println("VM job is "+ISJob);
                isModel.setVmJob(ISJob);

                temp=setISModel(isModel,ISState,temp);

                System.out.println("connect finish to:"+socket.getInetAddress()+":"+socket.getPort());
                clientOut.close();
                clientIn.close();
                socket.close();

                ISState="offline";
            }catch(ConnectException e){
                temp=setISModel(isModel,ISState,temp);
            }catch(SocketTimeoutException e){
                temp=setISModel(isModel,ISState,temp);
            }catch(NoRouteToHostException e){
                temp=setISModel(isModel,ISState,temp);
            }catch (UnknownHostException e) {
                e.printStackTrace();
            }catch(IOException e){
                e.printStackTrace();
            }
        }
        ISList=temp;
    }

}
