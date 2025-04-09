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

@WebServlet("/jspproject/objCurrentGroupSetServlet")
public class ObjCurrentGroupSetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		StringBuilder sb = new StringBuilder();
		BufferedReader reader = request.getReader();
		String line;

		while ((line = reader.readLine()) != null) {
			sb.append(line);
		}

		try {
			// 받은 JSON을 파싱
			JSONObject json = new JSONObject(sb.toString());

			if (!json.has("objgroup_id")) {
				System.err.println("⚠️ objgroup_id 없음");
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				response.getWriter().write("{\"status\":\"fail\",\"reason\":\"missing objgroup_id\"}");
				return;
			}

			int objgroup_id = json.getInt("objgroup_id");

			// 세션에 저장
			HttpSession session = request.getSession();
			session.setAttribute("currentObjGroup", objgroup_id);

			// 성공 응답
			response.getWriter().write("{\"status\":\"success\"}");

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("{\"status\":\"fail\",\"error\":\"" + e.getMessage() + "\"}");
		}
	}
}
