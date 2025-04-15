package jspproject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/jspproject/objArchivedListServlet")
public class ObjArchivedListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json; charset=UTF-8");

	    PrintWriter out = response.getWriter();
	    JSONObject result = new JSONObject();

	    try {
	        HttpSession session = request.getSession();
	        String userId = (String) session.getAttribute("user_id");

	        if (userId == null || userId.trim().isEmpty()) {
	            result.put("status", "fail");
	            result.put("message", "user_id가 필요합니다.");
	            out.print(result);
	            return;
	        }

	        ObjMgr mgr = new ObjMgr();
	        Vector<ObjBean> archivedTasks = mgr.getTotalObjList(userId);  // obj_check = 1인 것만 반환해야 함

	        JSONArray jsonArr = new JSONArray();
	        for (ObjBean task : archivedTasks) {
	            if (task.getObj_check() != 1) continue; // ✅ obj_check == 1만 포함
	            
	            JSONObject obj = new JSONObject();
	            obj.put("obj_id", task.getObj_id());
	            obj.put("obj_title", task.getObj_title());
	            obj.put("obj_check", task.getObj_check());
	            obj.put("obj_sdate", task.getObj_sdate() != null ? task.getObj_sdate() : "");
	            obj.put("obj_edate", task.getObj_edate() != null ? task.getObj_edate() : "");
	            obj.put("objgroup_id", task.getObjgroup_id());

	            jsonArr.put(obj);
	        }

	        result.put("status", "success");
	        result.put("data", jsonArr);
	        out.print(result);

	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("status", "error");
	        result.put("message", "서버 오류 발생");
	        out.print(result);
	    }
	}

}
