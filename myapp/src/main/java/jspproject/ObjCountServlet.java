package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

@WebServlet("/jspproject/objCountServlet")
public class ObjCountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ObjMgr mgr;
	  @Override
	    public void init() throws ServletException {
	        mgr = new ObjMgr(); // DAO 초기화
	    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("user_id");
		Integer objgroup_id = (Integer) session.getAttribute("currentObjGroup"); // 👈 여기 수정!

		JSONObject result = new JSONObject();

		try {
			if (userId == null || objgroup_id == null) {
				result.put("status", "error");
				result.put("message", "Missing session data: user_id or objgroup_id");
				response.getWriter().write(result.toString());
				return;
			}

			int total = mgr.getTotalCountByGroup(objgroup_id, userId);
			int completed = mgr.getCompletedCountByGroup(objgroup_id, userId);

			result.put("status", "success");
			result.put("total", total);
			result.put("completed", completed);

			System.out.println("📦 [ObjCountServlet]");
			System.out.println(" - user_id: " + userId);
			System.out.println(" - objgroup_id: " + objgroup_id);
			System.out.println(" - total: " + total);
			System.out.println(" - completed: " + completed);

		} catch (Exception e) {
			result.put("status", "error");
			result.put("message", "Internal server error");
			e.printStackTrace();
		}

		response.getWriter().write(result.toString());
	}

}
