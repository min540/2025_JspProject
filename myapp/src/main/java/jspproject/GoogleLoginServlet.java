package jspproject;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;


@WebServlet("/jspproject/googleLoginServlet")
public class GoogleLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 	request.setCharacterEncoding("UTF-8");
		 
		    BufferedReader reader = request.getReader();
		    StringBuilder sb = new StringBuilder();
		    String line;
		    while ((line = reader.readLine()) != null) {
		      sb.append(line);
		    }

		    JSONObject json = new JSONObject(sb.toString());
		    String user_id = json.getString("user_id");
		    String user_email = json.getString("user_email");
		    String user_name = json.getString("user_name");
		    String user_icon = json.optString("user_icon", null);
		    String user_pwd = json.getString("user_pwd");

		    LoginMgr mgr = new LoginMgr();
		    UserBean existingUser = mgr.getUser(user_id);

		    boolean insertSuccess = true;

		    if (existingUser == null) {
		        String defaultPhone = "01000000000";
		        int defaultGrade = 0;
		        insertSuccess = mgr.insertGoogleUser(user_id, user_pwd, user_name, user_email, defaultPhone, defaultGrade, user_icon);
		    }
		    
		 // 삽입 실패 시
			if (!insertSuccess) {
				System.err.println("❌ 사용자 삽입 실패: " + user_id);
				response.setContentType("application/json");
				response.getWriter().write("{\"status\":\"fail\"}");
				return;
			}

		    // 세션 처리
		    HttpSession session = request.getSession();
		    session.setAttribute("user_id", user_id);
		    session.setAttribute("user_name", user_name);
		    session.setAttribute("user_email", user_email);

		    response.setContentType("application/json");
		    response.getWriter().write("{\"status\":\"ok\"}");
		  }
		
	}
