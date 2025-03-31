package ch08;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ch08/exServlet2")
public class ExServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// 서블릿 라이플 사이클 : init -> service -> destory
	@Override // 서브릿 처음 요청 시 한 번만 실행
	public void init() throws ServletException {
		System.out.println("init 호출");
	}
	
	@Override // Client가 요청이 있을 때마다 실행이 됨
	protected void service(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		// Tomcat Console 출력
		System.out.println("services 호출");
	}
	
	@Override // 서비스 종류 및 서블릿 코드가 수정될 때
	public void destroy() {
		System.out.println("destory 호출");
	}

}
