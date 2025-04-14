package jspproject;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateTemaServlet
 */
@WebServlet("/jspproject/updateTemaServlet")
@MultipartConfig
public class UpdateTemaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        response.setContentType("text/plain; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        TemaMgr mgr = new TemaMgr();

        try {
            mgr.updateTema(request);
            out.print("ok");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("error");
        } finally {
            out.close();
        }
    }
}