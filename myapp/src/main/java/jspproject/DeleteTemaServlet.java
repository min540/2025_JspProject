package jspproject;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteTemaServlet
 */
@WebServlet("/jspproject/deleteTemaServlet")
public class DeleteTemaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        String temaIdParam = request.getParameter("tema_id");

        try {
            if (temaIdParam != null) {
                int tema_id = Integer.parseInt(temaIdParam);

                TemaMgr mgr = new TemaMgr();
                mgr.deleteTema(tema_id);  // DB에서 삭제

                out.print("{\"status\":\"ok\"}");
            } else {
                out.print("{\"status\":\"fail\", \"message\":\"No tema_id provided\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"fail\", \"message\":\"Exception occurred\"}");
        } finally {
            out.close();
        }
    }
}