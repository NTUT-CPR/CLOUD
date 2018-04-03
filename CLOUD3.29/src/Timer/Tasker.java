package Timer;

import ISMonitor.ISMonitor;

import java.util.Date;
import java.util.TimerTask;

/**
 * Created by thefalling on 2018/3/23.
 */
public class Tasker extends TimerTask {
    private static boolean isRunning=false;
    ISMonitor isMonitor=new ISMonitor();
    @Override
    public void run(){
        if(!isRunning){
            System.out.println("——————————————————————————————————————————————————");
            System.out.println("ISMonitor run time: "+new Date().toString());
            System.out.println("——————————————————————————————————————————————————");
            isRunning=true;
            isMonitor.getAllVmIsState();
            System.out.println("——————————————————————————————————————————————————");
            System.out.println("ISMonitor stop time: "+new Date().toString());
            System.out.println("——————————————————————————————————————————————————");
            isRunning=false;
        }else{
            System.out.println("——————————————————————————————————————————————————");
            System.out.println("ISMonitor is running last task.");
            System.out.println("——————————————————————————————————————————————————");
        }
    }
}
