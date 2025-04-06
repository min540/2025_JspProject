package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/bgmPost") // ✅ 경로 확인: form action="${pageContext.request.contextPath}/bgmPost"
public class BgmPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		BgmMgr bmgr = new BgmMgr();

		if (bmgr.insertBgm(request)) {
			System.out.println("✅ insertBgm 성공!");
			response.sendRedirect("jspproject/bgmTest.jsp");
		} else {
			System.out.println("❌ insertBgm 실패!");
			response.sendRedirect("jspproject/bgmTest.jsp?error=insertfail");
		}
	}
}
