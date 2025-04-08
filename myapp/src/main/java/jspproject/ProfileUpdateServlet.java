package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/jspproject/profileUpdate")
public class ProfileUpdateServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		LoginMgr lMgr = new LoginMgr();
		lMgr.updateUser(request);
		HttpSession session = request.getSession();
		UserBean ubean = lMgr.getUser((String)session.getAttribute("id"));
		session.setAttribute("ubean", ubean);
		response.sendRedirect("mainScreen.jsp");
	}
}