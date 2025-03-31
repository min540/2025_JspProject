package ch19;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 좋아요 서블릿
@WebServlet("/ch19/pBlogUpHCnt")
public class PBlogHCntServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		PBlogMgr pmgr = new PBlogMgr();
		int num = MUtil.parseInt(request, "num");
		pmgr.upHCnt(num);
		String gid = request.getParameter("gid");
		// guest.jsp 호출 시 gid는 null이 아님
		if(gid==null)
			response.sendRedirect("home.jsp");
		else
			response.sendRedirect("guest.jsp.jsp?gid="+gid);
	}

}
