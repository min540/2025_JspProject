package ch19;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 게시글 올리기 서블릿
@WebServlet("/ch19/pBlogPost")
public class PBlogPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		PBlogMgr pmgr = new PBlogMgr();
		pmgr.insertPBlog(request);
		response.sendRedirect("home.jsp");
	}

}
