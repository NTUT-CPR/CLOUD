package Servlet;

import JClouds.JCloudsNova;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by thefalling on 2018/1/12.
 */
public class ServerOverviewInfoServlet extends HttpServlet {
    JCloudsNova jcloudsNova = new JCloudsNova();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String flavorId=request.getParameter("flavorId");
        String imageId=request.getParameter("imageId");
        String serverId=request.getParameter("serverId");


        String serverName=jcloudsNova.getServerNameById(serverId);
        String serverStatus=jcloudsNova.getServerStatusById(serverId);
        String serverAddress=jcloudsNova.getServerAddressById(serverId);
        String serverCreatedTime=jcloudsNova.getServerCreatedDateById(serverId);
        String serverUpdateTime=jcloudsNova.getServerUpdateDateById(serverId);

        String flavorName=jcloudsNova.getFlavorNameById(flavorId);
        int flavorRam=jcloudsNova.getFlavorRamById(flavorId);
        int flavorVcpu=jcloudsNova.getFlavorVCpuById(flavorId);
        int flavorDisk=jcloudsNova.getFlavorDiskById(flavorId);

        String imageName=jcloudsNova.getImageNameById(imageId);
        String imageStatus=jcloudsNova.getImageStatusById(imageId);
        String imageCreatedTime=jcloudsNova.getImageCreatedTimeById(imageId);
        String imageUpdatedTime=jcloudsNova.getImageUpdatedTimeById(imageId);
        int imageMinRam=jcloudsNova.getImageMinRamById(imageId);
        int imageMinDisk=jcloudsNova.getImageMinDiskById(imageId);

        request.setAttribute("flavorName",flavorName);
        request.setAttribute("flavorId",flavorId);
        request.setAttribute("flavorRam",flavorRam);
        request.setAttribute("flavorVcpu",flavorVcpu);
        request.setAttribute("flavorDisk",flavorDisk);

        request.setAttribute("imageName",imageName);
        request.setAttribute("imageId",imageId);
        request.setAttribute("imageStatus",imageStatus);
        request.setAttribute("imageCreatedTime",imageCreatedTime);
        request.setAttribute("imageUpdatedTime",imageUpdatedTime);
        request.setAttribute("imageMinRam",imageMinRam);
        request.setAttribute("imageMinDisk",imageMinDisk);

        request.setAttribute("serverName",serverName);
        request.setAttribute("serverId",serverId);
        request.setAttribute("serverStatus",serverStatus);
        request.setAttribute("serverAddress",serverAddress);
        request.setAttribute("serverCreatedTime",serverCreatedTime);
        request.setAttribute("serverUpdateTime",serverUpdateTime);

        request.getRequestDispatcher("serverOverviewInfo.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
