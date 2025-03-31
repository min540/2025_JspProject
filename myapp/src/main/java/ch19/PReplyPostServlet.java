package ch19;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 좋아요 서블릿
@WebServlet("/ch19/pReplyPost")
public class PReplyPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		PReplyMgr rmgr = new PReplyMgr();
		PReplyBean rbean = new PReplyBean();
		rbean.setNum(MUtil.parseInt(request, "num"));
		rbean.setId(request.getParameter("id"));
		rbean.setComment(request.getParameter("comment"));
		rmgr.insertPReply(rbean);

		String gid = request.getParameter("gid");
		if(gid==null)
			response.sendRedirect("home.jsp");
		else
			response.sendRedirect("guest.jsp.jsp?gid="+gid);
	}

}
