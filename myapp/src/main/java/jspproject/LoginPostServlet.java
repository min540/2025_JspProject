package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/loginPost")
public class LoginPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		LoginMgr lmgr = new LoginMgr();
		if(lmgr.loginJoin(request)) {
			response.sendRedirect("mainScreen.jsp");
		}else {
			response.sendRedirect("login.jsp");
		}
	}

}
