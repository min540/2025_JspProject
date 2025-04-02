package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/jspproject/emailCheckServlet")
public class EmailCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        String userEmail = request.getParameter("user_email");

        boolean exists = false;
        try {
            LoginMgr mgr = new LoginMgr();
            exists = mgr.emailChk(userEmail); // ← 기존 메서드 호출
        } catch (Exception e) {
            e.printStackTrace();
        }

        // true: 중복 O, false: 사용 가능
        response.getWriter().write(String.valueOf(exists));
    }
	
}
