package jspproject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/bgmDelete") // ✅ 경로 확인: form action="${pageContext.request.contextPath}/bgmPost"
public class BgmDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		 request.setCharacterEncoding("UTF-8");

	        // JSON 데이터 읽기
	        StringBuilder sb = new StringBuilder();
	        BufferedReader reader = request.getReader();
	        String line;
	        while ((line = reader.readLine()) != null) {
	            sb.append(line);
	        }

	        JSONObject json = new JSONObject(sb.toString());
	        JSONArray bgmIds = json.getJSONArray("bgmIds");

	        BgmMgr bmgr = new BgmMgr();
	        boolean allDeleted = true;

	        for (int i = 0; i < bgmIds.length(); i++) {
	            int bgm_id = bgmIds.getInt(i);
	            try {
	                bmgr.deleteBgm(bgm_id);  // 👉 너가 만든 메서드 그대로 호출
	            } catch (Exception e) {
	                allDeleted = false;
	                e.printStackTrace();
	            }
	        }

	        // 응답 반환
	        response.setContentType("application/json;charset=UTF-8");
	        JSONObject result = new JSONObject();
	        result.put("success", allDeleted);
	        PrintWriter out = response.getWriter();
	        out.print(result.toString());
	    }
	}
