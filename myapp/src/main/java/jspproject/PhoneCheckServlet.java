package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PhoneCheckServlet
 */
@WebServlet("/jspproject/phoneCheckServlet")
public class PhoneCheckServlet extends HttpServlet {
	private LoginMgr loginMgr = new LoginMgr();
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String user_phone = request.getParameter("user_phone");
	        boolean isDuplicate = loginMgr.phoneChk(user_phone);

	        response.setContentType("text/plain; charset=UTF-8");
	        response.getWriter().write(String.valueOf(isDuplicate));
	        
	    }
	}


