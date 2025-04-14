package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/jspproject/userPost")
public class UserPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {

		LoginMgr lmgr = new LoginMgr();
		
		if (lmgr.insertUser(request)) {
			// ✅ 회원가입 성공 시 사용자 ID 가져오기
			String user_id = request.getParameter("user_id");

			// ✅ 기본 테마 자동 삽입
			TemaMgr temaMgr = new TemaMgr();
			TemaBean tema = new TemaBean();
			tema.setUser_id(user_id);
			tema.setTema_title("기본 배경");
			tema.setTema_bimg(null);
			tema.setTema_cnt("기본 배경 설명입니다.");
			tema.setTema_dark(0);
			tema.setTema_onoff(1); // 기본 테마 활성화
			tema.setTema_img("tema1.jpg"); // 기본 이미지 파일명

			temaMgr.insertDefaultTema(tema);

			response.sendRedirect("login.jsp");
		} else {
			response.sendRedirect("register.jsp");
		}
	}
}
