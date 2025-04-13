package jspproject;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

@WebServlet("/jspproject/objInsertServlet")
public class ObjInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Json 수신요청
		BufferedReader reader = request.getReader();
		String jsonStr = reader.lines().collect(Collectors.joining());
			
		// org.json파싱
		JSONObject json = new JSONObject(jsonStr);
		
		//ObjBean 객체 생성, 값 설정
		ObjBean task = new ObjBean();
		task.setUser_id(json.getString("user_id"));
		task.setObj_title(json.getString("obj_title"));
		task.setObj_check(json.getInt("obj_check"));
		task.setObjgroup_id(json.getInt("objgroup_id"));
		task.setObj_sdate(json.optString("obj_sdate", null)); 
		
		//마감처리
		String edate = json.optString("obj_edate", null);
		if (edate != null && edate.trim().isEmpty()) {
			edate = null;
		}
		task.setObj_edate(edate);
		
		//DB 연동
		ObjMgr mgr = new ObjMgr();
		int obj_id = mgr.insertObjAndReturnId(task);
		
		//Json 응답
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().write("{\"obj_id\":" + obj_id + "}");
	}

}


