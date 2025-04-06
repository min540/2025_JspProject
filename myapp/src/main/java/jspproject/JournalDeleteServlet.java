package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/jourDelete")
public class JournalDeleteServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		JourMgr jMgr = new JourMgr();
		int rnum = Integer.parseInt(request.getParameter("rnum"));
		jMgr.deleteJour(rnum);
		String gid = request.getParameter("gid");
		if(gid==null)
			response.sendRedirect("journal.jsp");
		else 
			response.sendRedirect("journal.jsp");
	}
}