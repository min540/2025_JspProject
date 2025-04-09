package jspproject;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/jspproject/objListServlet")
public class ObjListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		HttpSession session = request.getSession(false);
		if (session == null) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.getWriter().write("{\"error\":\"세션이 만료되었습니다.\"}");
			return;
		}

		Integer objgroup_id = (Integer) session.getAttribute("currentObjGroup");

		if (objgroup_id == null) {
			System.err.println("⚠️ [objListServlet] 세션에서 objgroup_id를 찾을 수 없습니다.");
			response.getWriter().write("[]"); // 빈 배열 반환
			return;
		}

		try {
			ObjMgr mgr = new ObjMgr();
			Vector<ObjBean> list = mgr.getObjList(objgroup_id);

			JSONArray jsonArray = new JSONArray();
			for (ObjBean bean : list) {
				JSONObject obj = new JSONObject();
				obj.put("obj_id", bean.getObj_id());
				obj.put("obj_title", bean.getObj_title());
				obj.put("obj_check", bean.getObj_check());
				obj.put("obj_edate", bean.getObj_edate());
				jsonArray.put(obj);
			}

			response.getWriter().write(jsonArray.toString());

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("[]");
		}
	}
}
