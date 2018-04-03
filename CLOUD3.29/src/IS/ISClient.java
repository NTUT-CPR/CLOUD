package IS;

import java.io.IOException;
import java.io.PrintStream;
import java.net.ConnectException;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;

/**
 * Created by thefalling on 2018/3/3.
 */
public class ISClient {
    public void startWork(){
        try{
            Socket socket=new Socket("127.0.0.1",3214);
            System.out.println("connected to:"+socket.getInetAddress()+":"+socket.getPort());

            PrintStream clientOut = new PrintStream(socket.getOutputStream());
            String states="working";
            String job="Transcode";
            clientOut.println(states);
            clientOut.println(job);
            clientOut.flush();

            System.out.println("connect finish to:"+socket.getInetAddress()+":"+socket.getPort());
            clientOut.close();
            socket.close();
        }catch(ConnectException e){
            e.printStackTrace();
        }catch(SocketTimeoutException e){
            e.printStackTrace();
        }catch (UnknownHostException e) {
            e.printStackTrace();
        }catch(IOException e){
            e.printStackTrace();
        }
    }
    public void stopWork(){
        try{
            Socket socket=new Socket("127.0.0.1",3214);
            System.out.println("connected to:"+socket.getInetAddress()+":"+socket.getPort());

            PrintStream clientOut = new PrintStream(socket.getOutputStream());
            String states="no_work";
            String job="no_job";
            clientOut.println(states);
            clientOut.println(job);
            clientOut.flush();

            System.out.println("connect finish to:"+socket.getInetAddress()+":"+socket.getPort());
            clientOut.close();
            socket.close();
        }catch(ConnectException e){
            e.printStackTrace();
        }catch(SocketTimeoutException e){
            e.printStackTrace();
        }catch (UnknownHostException e) {
            e.printStackTrace();
        }catch(IOException e){
            e.printStackTrace();
        }
    }
//    public static void main(String[] args){

//    }

}
