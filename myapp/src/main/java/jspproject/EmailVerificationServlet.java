package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/jspproject/EmailVerificationServlet")
public class EmailVerificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // POST 방식 요청을 처리하여, 이메일과 인증 코드를 세션에 저장하고, 이메일 발송
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 요청 인코딩 설정 (필요한 경우)
        request.setCharacterEncoding("UTF-8");
        String userEmail = request.getParameter("user_email");
        
        if (userEmail != null && !userEmail.trim().isEmpty()) {
            // 6자리 인증 코드 생성
            String verificationCode = String.format("%06d", new java.util.Random().nextInt(1000000));
            
            // 세션에 코드와 이메일 저장
            HttpSession session = request.getSession();
            session.setAttribute("verificationCode", verificationCode);
            session.setAttribute("user_email", userEmail);
            
            // EmailSender를 이용해 이메일 발송
            EmailSender.sendVerificationEmail(userEmail, verificationCode);
        }
    }
    
    // GET 방식은 지원하지 않도록 할 수도 있습니다.
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported");
    }
}
