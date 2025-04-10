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

@WebServlet("/jspproject/objDeleteServlet")
public class ObjDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		 // JSON 데이터 수신
	    BufferedReader reader = request.getReader();
	    String jsonStr = reader.lines().collect(Collectors.joining());

	    // org.json으로 파싱
	    JSONObject json = new JSONObject(jsonStr);
	    int objId = json.getInt("obj_id");

	    // 삭제 처리
	    ObjMgr mgr = new ObjMgr();
	    mgr.deleteObj(objId);

	    // 응답 반환
	    response.setContentType("application/json;charset=UTF-8");
	    response.getWriter().write("{\"status\":\"success\"}");
	}
}
