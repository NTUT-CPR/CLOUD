package ISMonitor;

/**
 * Created by thefalling on 2018/3/25.
 */
public class ISModel {
    private String VmName;
    private String VmID;
    private String VmIP;
    private String VmJob;
    private String ISState;
    private String ISStateTime;
    private String VmState;
    private int ISOfflineTime;

    public ISModel(){
        VmName=null;
        VmID=null;
        VmIP=null;
        VmJob="offline";
        ISState=null;
        ISStateTime="offline";
        VmState=null;
        ISOfflineTime=0;
    }

    public String getVmName() {
        return VmName;
    }

    public void setVmName(String vmName) {
        VmName = vmName;
    }

    public String getVmID(){
        return VmID;
    }

    public void setVmID(String vmID){
        VmID=vmID;
    }

    public String getVmState(){return VmState;}

    public void setVmState(String vmState){VmState = vmState;}

    public String getVmIP() {
        return VmIP;
    }

    public void setVmIP(String vmIP) {
        VmIP = vmIP;
    }

    public String getVmJob() {
        return VmJob;
    }

    public void setVmJob(String vmJob) {
        VmJob = vmJob;
    }

    public String getISState() {
        return ISState;
    }

    public void setISState(String ISState) {
        this.ISState = ISState;
    }

    public String getISStateTime() {
        return ISStateTime;
    }

    public void setISStateTime(String ISStateTime) {
        this.ISStateTime = ISStateTime;
    }

    public int getISOfflineTime() {
        return ISOfflineTime;
    }

    public void setISOfflineTime(int ISOfflineTime) {
        this.ISOfflineTime = ISOfflineTime;
    }
}
