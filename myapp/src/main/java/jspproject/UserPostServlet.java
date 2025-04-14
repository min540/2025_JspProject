package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/jspproject/userPost")
public class UserPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {

		LoginMgr lmgr = new LoginMgr();
		
		if (lmgr.insertUser(request)) {

			response.sendRedirect("login.jsp");
		} else {
			response.sendRedirect("register.jsp");
		}
	}
}
