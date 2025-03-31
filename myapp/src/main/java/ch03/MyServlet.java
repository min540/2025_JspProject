package ch03;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ch03/myServlet")
public class MyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, 
            HttpServletResponse response) throws ServletException, IOException {
        // 🔹 올바른 인코딩 설정
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        PrintWriter out = response.getWriter(); // output(응답) 스트림
        out.println("<html>");
        out.println("<head>");
        out.println("<title>MyServlet1</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>코리아 파이팅!</h1>");
        out.println("</body>");
        out.println("</html>");
    }
}
