package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/logout")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	LoginMgr lmgr = new LoginMgr();
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 세션에서 user_id를 가져오고, DB 등에 기록된 접속 정보를 제거합니다.
        String id = (String) request.getSession().getAttribute("user_id");
        if (id != null) {
            // userOut() 호출로 접속 기록에서 해당 아이디 삭제
            lmgr.userOut(id);
        }
        // 세션 무효화(로그아웃 처리)
        request.getSession().invalidate();
        response.sendRedirect("login.jsp");
    }
}
