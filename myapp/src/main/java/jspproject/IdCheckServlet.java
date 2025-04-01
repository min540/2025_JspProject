package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/jspproject/idCheckServlet")
public class IdCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String user_id = request.getParameter("user_id");
		    boolean result = false;
		    if (user_id != null && !user_id.trim().isEmpty()) {
		      LoginMgr mgr = new LoginMgr();
		      result = mgr.idChk(user_id); // 사용 가능하면 true
		    }
		    response.setContentType("text/plain;charset=UTF-8");
		    response.getWriter().write(String.valueOf(result));
	}

}
