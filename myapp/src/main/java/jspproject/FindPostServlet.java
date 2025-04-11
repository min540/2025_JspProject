package jspproject;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/findPost")
public class FindPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
				LoginMgr lmgr = new LoginMgr();
				
		String userName = request.getParameter("user_name");
		String userPhone = request.getParameter("user_phone");
		
		UserBean bean = new UserBean();
		bean.setUser_name(userName);
		bean.setUser_phone(userPhone);
		
		lmgr.findUser(bean);
		
		if(bean.getUser_id() != null && !bean.getUser_id().isEmpty()) {
			request.setAttribute("foundUserId", bean.getUser_id());
			RequestDispatcher dispatcher = request.getRequestDispatcher("findId.jsp");
			dispatcher.forward(request, response);
		} else {
			response.sendRedirect("findId.jsp?error=find_failed");
		}
	}
}
