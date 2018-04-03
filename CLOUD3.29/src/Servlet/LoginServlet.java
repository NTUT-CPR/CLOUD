package Servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by thefalling on 2018/3/15.
 */
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        System.out.println(username);
        System.out.println(password);
        if(username.equals("media")&&password.equals("media")){
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }else{
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
