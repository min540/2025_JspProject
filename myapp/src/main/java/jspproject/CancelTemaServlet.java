package jspproject;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CancelTemaServlet
 */
@WebServlet("/jspproject/cancelTemaServlet")
public class CancelTemaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String user_id = (String) session.getAttribute("user_id");

        PrintWriter out = response.getWriter();

        if (user_id != null && !user_id.isEmpty()) {
            TemaMgr temaMgr = new TemaMgr();
            temaMgr.resetAllTemaOnOff(user_id); // 모든 테마 off
            out.print("ok");
        } else {
            out.print("error: no session user_id");
        }

        out.close();
    }
}
