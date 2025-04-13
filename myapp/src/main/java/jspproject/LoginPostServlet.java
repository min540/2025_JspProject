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
					
					//중복 로그인 체크
					if(lmgr.userCheck(id)) {
						response.sendRedirect("login.jsp?error=duplicate_login");
						return;
					}
					
					UserBean user = lmgr.getUser(id);
					if (user != null) {
						//인증 성공 후 중복 로그인이 아닌 경우
						lmgr.userIn(id);
						
						//세션에 로그인 정보를 저장
					    request.getSession().setAttribute("user", user);                 // 기존 유지
					    request.getSession().setAttribute("user_id", user.getUser_id());     // ✅ user_id 따로 저장 (추가)
					    request.getSession().setAttribute("grade", user.getGrade()); 

					    //등급에 따라 리다이렉트 처리(2 = 관리자, 1 = 사용자)
					    if (user.getGrade() == 2) {
					        response.sendRedirect("anc.jsp");
					        return;
					    } else if (user.getGrade() == 1 || user.getGrade() == 0) {
					        response.sendRedirect("mainScreen.jsp");
					        return;
					    } else {
					        response.sendRedirect("login.jsp?error=login_failed");
					        return;
					    }
					} else {
					    response.sendRedirect("login.jsp?error=login_failed");
					    return;
				}
			}else {
				response.sendRedirect("login.jsp?error=login_failed");
			    return;
			}
		}
	}
