package ch15;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ch15/boardReply")
public class BoardReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		BoardMgr mgr = new BoardMgr();
		BoardBean reBean = new BoardBean();
		
		reBean.setName(request.getParameter("name"));
		reBean.setSubject(request.getParameter("subject"));
		reBean.setContent(request.getParameter("content"));
		reBean.setRef(MUtil.parseInt(request, "ref"));
		reBean.setPos(MUtil.parseInt(request, "pos"));
		reBean.setDepth(MUtil.parseInt(request, "depth"));
		reBean.setPass(request.getParameter("pass"));
		reBean.setIp(request.getParameter("ip"));
		
		// 답변을 위한 pos값 수정
		mgr.replyUpBoard(reBean.getRef(), reBean.getPos());
		// 답변 저장
		mgr.replyBoard(reBean);
		
		String nowPage = request.getParameter("nowPage");
		String numPerPage = request.getParameter("numPerPage");
		response.sendRedirect("list.jsp?nowPage="+nowPage+
				"&numPerPage="+numPerPage);
		
	}

}
