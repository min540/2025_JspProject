package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/loginPost")
public class LoginPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
				LoginMgr lmgr = new LoginMgr();

				//HttpServletRequest 전체를 넘깁니다
				if (lmgr.loginJoin(request)) {
					String id = request.getParameter("user_id");
					UserBean user = lmgr.getUser(id);

					if (user != null) {
						request.getSession().setAttribute("user", user);

						// 권한에 따라 페이지 이동
						if (user.getGrade() == 2) {
							response.sendRedirect("/2025_JspProject/jspproject/anc.jsp");
						} else if (user.getGrade() == 1 || user.getGrade() == 0) {
							response.sendRedirect("/2025_JspProject/jspproject/mainScreen.jsp");
						} else {
							response.sendRedirect("login.jsp?error=login_failed");
						}
					} else {
						response.sendRedirect("login.jsp?error=login_failed");
					}
				} else {//여기가 0 1 2외의 값일 때 다시 로그인 화면으로 돌아가게함
					response.sendRedirect("login.jsp?error=login_failed");
			}
		}
	}
