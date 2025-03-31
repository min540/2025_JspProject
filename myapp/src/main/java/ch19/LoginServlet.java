package ch19;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// 회원가입 서블릭
@WebServlet("/ch19/pmemberLogin")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		PMemberMgr pMgr = new PMemberMgr();
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String url = "login.jsp";
		HttpSession session = request.getSession();
		if(pMgr.loginPMember(id, pwd)) {
			session.setAttribute("idKey", id);
			PMemberBean bean = pMgr.getPMember(id);
			session.setAttribute("bean", bean); // 세션에 로그인 전체 정보를 저장
		} else {
			session.setAttribute("msg", "아이디와 비밀번호가 일치하지 않습니다.");
		}
		response.sendRedirect(url);
	}

}
