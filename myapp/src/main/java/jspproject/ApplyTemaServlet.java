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
 * Servlet implementation class ApplyTemaServlet
 */
@WebServlet("/jspproject/applyTemaServlet")
public class ApplyTemaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String user_id = (String) session.getAttribute("user_id");

        String temaIdParam = request.getParameter("tema_id");
        PrintWriter out = response.getWriter();

        if (user_id == null || temaIdParam == null) {
            out.print("fail");
            return;
        }

        int tema_id;
        try {
            tema_id = Integer.parseInt(temaIdParam);
        } catch (NumberFormatException e) {
            out.print("fail");
            return;
        }

        TemaMgr mgr = new TemaMgr();

        // 1. 모든 테마 off
        mgr.setAllTemaOff(user_id);

        // 2. 선택한 테마 on
        boolean success = mgr.setTemaOn(tema_id);

        out.print(success ? "ok" : "fail");
        out.close();
    }
}