package ch19;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 회원가입 서블릭
@WebServlet("/ch19/pmemberPost")
public class PMemberPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		PMemberMgr pMgr = new PMemberMgr();
		if(pMgr.insertPMember(request)) {
			response.sendRedirect("login.jsp");
		} else {
			response.sendRedirect("register.jsp");
		}
	}

}
