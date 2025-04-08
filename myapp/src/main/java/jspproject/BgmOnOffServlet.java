package jspproject;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

@WebServlet("/jspproject/bgmOnOff")
public class BgmOnOffServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) sb.append(line);

        JSONObject json = new JSONObject(sb.toString());
        int bgm_id = json.getInt("bgm_id");
        int bgm_onoff = json.getInt("bgm_onoff");

        boolean success = true; // 기본값 true로 설정

        try {
            BgmMgr bmgr = new BgmMgr();
            bmgr.updateBgmOnoff(bgm_id, bgm_onoff);
        } catch (Exception e) {
            e.printStackTrace();
            success = false; // 예외 발생 시 실패 처리
        }

        response.setContentType("application/json;charset=UTF-8");
        JSONObject res = new JSONObject();
        res.put("success", success);
        response.getWriter().print(res.toString());
    }
}
