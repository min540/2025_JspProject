package ch15;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class BoardDeleteServlet
 */
@WebServlet("/ch15/boardDelete")
public class BoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		//세션에 저장한 게시물 리턴
		BoardBean bean = (BoardBean)session.getAttribute("bean");
		String dbPass = bean.getPass(); // table에 저장 비번
		String inPass = request.getParameter("pass"); // 사용자가 입력한 비번
		if(dbPass.equals(inPass)) {
			BoardMgr mgr = new BoardMgr();
			BCommentMgr cmgr = new BCommentMgr();
			
			//게시물 삭제
			mgr.deleteBoard(bean.getNum());
			
			// 댓글 모두 삭제
			cmgr.deleteAllBComment(bean.getNum());
			
			String nowPage = request.getParameter("nowPage");
			String numPerPage = request.getParameter("numPerPage");
			String keyField = request.getParameter("keyField");
			String keyWord = request.getParameter("keyWord");
			String url = "list.jsp?nowPage="+nowPage;
			url+="&numPerPage="+numPerPage;
			if(!(keyWord==null||keyWord.equals(""))) {
				url+="&keyField="+keyField;
				url+="&keyWord="+URLEncoder.encode(keyWord, "UTF-8");
			}
			response.sendRedirect(url);	
		}else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('입력하신 비밀번호가 아닙니다')");
			out.println("history.back()");
			out.println("</script>");
		}
	}

}
