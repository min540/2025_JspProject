package jspproject;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/findPwPost")
public class FindPwPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
				LoginMgr lmgr = new LoginMgr();
				
		String userId = request.getParameter("user_id");
		String userName = request.getParameter("user_name");
		String userPhone = request.getParameter("user_phone");
		
		UserBean bean = new UserBean();
		bean.setUser_id(userId);
		bean.setUser_name(userName);
		bean.setUser_phone(userPhone);
		
		lmgr.findpwUser(bean);
		
		if(bean.getUser_pwd() != null && !bean.getUser_pwd().isEmpty()) {
			request.setAttribute("foundUserPwd", bean.getUser_pwd());
			RequestDispatcher dispatcher = request.getRequestDispatcher("findPwd.jsp");
			dispatcher.forward(request, response);
		} else {
			response.sendRedirect("findPwd.jsp?error=find_failed");
		}
	}
}
