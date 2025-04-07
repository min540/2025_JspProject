package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/bgmUpPost")
public class BgmUpPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		BgmMgr bmgr = new BgmMgr();
		if(bmgr.updateBgm(request)) {
			response.sendRedirect("mainScreen.jsp");
		}else {
			System.out.println("배경음악 수정 실패");
			response.sendRedirect("musicList.jsp?error=insertfail");
		}
	}

}
