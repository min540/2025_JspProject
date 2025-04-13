package jspproject;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/jspproject/VerifyCodeServlet")
public class VerifyCodeServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
        String code = request.getParameter("code");
        HttpSession session = request.getSession();
        String expectedCode = (String) session.getAttribute("verificationCode");
        boolean success = (code != null && code.equals(expectedCode));
      
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
      
        // 부모 창의 verifyCallback() 함수를 호출하는 스크립트를 출력합니다.
        out.println("<script type='text/javascript'>");
        if(success) {
            out.println("parent.verifyCallback(true);");
            // 인증 성공 시, 세션에서 인증 코드 제거
            session.removeAttribute("verificationCode");
        } else {
            out.println("parent.verifyCallback(false);");
        }
        out.println("</script>");
    }
}
