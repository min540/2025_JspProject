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

@WebServlet("/jspproject/objUpdateServlet")
public class ObjUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 요청 JSON 읽기
	    BufferedReader reader = request.getReader();
	    String jsonStr = reader.lines().collect(Collectors.joining());
	    JSONObject json = new JSONObject(jsonStr);

	    // 값 추출
	    int obj_id = json.getInt("obj_id");
	    String obj_title = json.optString("obj_title", "");
	    String obj_sdate = json.optString("obj_sdate", null);
	    String obj_edate = json.optString("obj_edate", null);

	    // edate가 빈 문자열이면 null 처리
	    if (obj_edate != null && obj_edate.trim().isEmpty()) {
	        obj_edate = null;
	    }

	    // Bean 객체에 값 설정
	    ObjBean bean = new ObjBean();
	    bean.setObj_id(obj_id);
	    bean.setObj_title(obj_title);
	    bean.setObj_sdate(obj_sdate);
	    bean.setObj_edate(obj_edate);
	   

	    // DB 업데이트
	    ObjMgr mgr = new ObjMgr();
	    mgr.updateObj(bean);

	    // 응답
	    response.setContentType("application/json;charset=UTF-8");
	    response.getWriter().write("{\"result\": true}");
	}

}
