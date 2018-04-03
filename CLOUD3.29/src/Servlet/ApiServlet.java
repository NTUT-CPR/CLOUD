package Servlet;

import JClouds.JCloudsNova;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by thefalling on 2017/12/14.
 */
public class ApiServlet extends HttpServlet {
    JCloudsNova jcloudsNova = new JCloudsNova();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("serversId");
        String action = request.getParameter("action");
        if( action.equals("shutoff") )
            jcloudsNova.stopServer(id);
        else if( action.equals("active") )
            jcloudsNova.startServer(id);
        response.sendRedirect("serverInfoServlet");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
