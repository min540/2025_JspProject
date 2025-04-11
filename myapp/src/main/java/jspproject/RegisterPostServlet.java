package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/jspproject/registerPost")  // ★ 여기서 URL 매핑을 registerPost로 설정
public class RegisterPostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // POST 요청이 오면 실행
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. 폼 데이터 가져오기
        request.setCharacterEncoding("UTF-8");
        String userId   = request.getParameter("user_id");
        String userPwd  = request.getParameter("user_pwd");
        String userName = request.getParameter("user_name");
        String userEmail= request.getParameter("user_email");
        // ... etc

        // 2. (필요 시) DB 연동하여 회원가입 로직 처리
        //  예: UserDAO를 이용해 insertUser(userId, userPwd, ...)

        // 3. 회원가입 완료 후 결과 페이지로 이동 (혹은 메인 페이지, 로그인 페이지)
        //    - forward 또는 redirect 방식
        response.sendRedirect("login.jsp"); // 예시: registerComplete.jsp로 이동
    }
}
