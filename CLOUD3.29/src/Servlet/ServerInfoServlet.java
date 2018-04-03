package Servlet;

import JClouds.JCloudsNova;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by thefalling on 2017/12/17.
 */
public class ServerInfoServlet extends HttpServlet {
    JCloudsNova jcloudsNova = new JCloudsNova();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList imageName=new ArrayList();
        ArrayList flavorName=new ArrayList();

        imageName=jcloudsNova.getImagesNameOfServers();
        flavorName=jcloudsNova.getFlavorsNameOfServers();

        request.setAttribute("imageName",imageName);
        request.setAttribute("flavorName",flavorName);

        request.getRequestDispatcher("serverInfo.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
