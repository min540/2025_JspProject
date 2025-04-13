package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 유저 삭제 서블릿
@WebServlet("/jspproject/deleteUser")
public class UserDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		LoginMgr lmgr = new LoginMgr();
		String user_id = request.getParameter("user_id");
		lmgr.deleteUser(user_id);
		response.sendRedirect("login.jsp");
	}

}
