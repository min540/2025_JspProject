package jspproject;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

@WebServlet("/jspproject/bgmAssignPlaylist")
public class BgmAssignPlaylistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // JSON 바디로 받는 경우
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String requestBody = sb.toString().trim();
        if (requestBody.isEmpty() || !requestBody.startsWith("{")) {
            throw new ServletException("유효하지 않은 요청입니다: " + requestBody);
        }
        JSONObject json = new JSONObject(requestBody);

        int bgmId = json.getInt("bgm_id");
        int mplistId = json.getInt("mplist_id");

        boolean success = false;
        String message = "";
        try {
            BgmMgr mgr = new BgmMgr();
            mgr.updateBgmMplist(bgmId, mplistId);
            success = true;
        } catch (Exception e) {
            e.printStackTrace();
            message = "DB 업데이트 실패";
        }

        response.setContentType("application/json; charset=UTF-8");
        JSONObject result = new JSONObject();
        result.put("success", success);
        result.put("message", message);
        response.getWriter().print(result.toString());
    }
}