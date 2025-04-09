package jspproject;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/jspproject/bgmAssignPlaylist")  // ✅ 이 부분 추가!
public class BgmAssignPlaylistServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        res.setContentType("application/json;charset=UTF-8");

        PrintWriter out = res.getWriter();
        JSONObject responseJson = new JSONObject();

        try {
            // 세션에서 user_id 가져오기
            HttpSession session = req.getSession();
            String user_id = (String) session.getAttribute("user_id");
            if (user_id == null) {
                responseJson.put("success", false);
                responseJson.put("message", "로그인이 필요합니다.");
                out.print(responseJson.toString());
                return;
            }

            // 요청 데이터 읽기
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = req.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            JSONObject json = new JSONObject(sb.toString());

            int bgm_id = json.getInt("bgm_id");
            JSONArray mplistIds = json.getJSONArray("mplist_ids");

            MplistMgrMgr mgr = new MplistMgrMgr();
            boolean success = true;

            // 선택한 모든 재생목록에 음악 추가
            for (int i = 0; i < mplistIds.length(); i++) {
                int mplist_id = mplistIds.getInt(i);
                boolean added = mgr.addBgmToMplist(mplist_id, bgm_id, user_id);
                if (!added) {
                    success = false;
                    break;
                }
            }

            responseJson.put("success", success);
            if (!success) {
                responseJson.put("message", "추가 중 일부 실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
            responseJson.put("success", false);
            responseJson.put("message", "서버 오류: " + e.getMessage());
        }

        out.print(responseJson.toString());
    }
}
