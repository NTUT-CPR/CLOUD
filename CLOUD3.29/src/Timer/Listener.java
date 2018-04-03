package Timer;

import ISMonitor.ISMonitor;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

/**
 * Created by thefalling on 2018/3/23.
 */
public class Listener implements ServletContextListener {
    private Timer timer=null;
    @Override
    public void contextDestroyed(ServletContextEvent event){
        timer.cancel();
    }
    @Override
    public void contextInitialized(ServletContextEvent event){
        timer=new Timer();
        timer.schedule(new Tasker(),0,1000*60);
    }
}
