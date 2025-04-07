// JournalDeleteServlet.java
package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/jourDelete")
public class JournalDeleteServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String[] rnums = request.getParameterValues("rnum");

	    if (rnums != null) {
	        JourMgr jmgr = new JourMgr();
	        for (String rnum : rnums) {
	            try {
	                int jourId = Integer.parseInt(rnum);
	                jmgr.deleteJour(jourId);
	            } catch (NumberFormatException e) {
	                e.printStackTrace(); // 잘못된 ID 무시
	            }
	        }
	    }

	    response.sendRedirect("mainScreen.jsp"); // 삭제 후 리다이렉트
	}
}
