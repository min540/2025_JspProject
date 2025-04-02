package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/mplistPost")
public class MplistPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		BgmMgr bmgr = new BgmMgr();
		if(bmgr.insertMplist(request)) {
			response.sendRedirect("playlist.jsp");
		}else {
			System.out.println("재생목록 등록 실패");
			response.sendRedirect("playlist.jsp?error=insertfail");
		}
	}

}
