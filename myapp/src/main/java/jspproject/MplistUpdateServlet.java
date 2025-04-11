package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/mplistUpdate")
public class MplistUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MplistMgr mgr;

    public void init() {
        mgr = new MplistMgr();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            mgr.updateMplist(request);
            response.sendRedirect("mainScreen.jsp"); // 혹은 리턴 경로
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "재생목록 수정 실패");
        }
    }
}
