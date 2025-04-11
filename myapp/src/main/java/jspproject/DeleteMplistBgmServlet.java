// 🔧 DeleteMplistBgmServlet.java
package jspproject;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class DeleteMplistBgmServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        BufferedReader reader = request.getReader();
        StringBuilder json = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            json.append(line);
        }

        int mplistmgr_id = -1;
        try {
            // 🔎 JSON 파싱
            String body = json.toString();
            body = body.replaceAll("[^0-9]", ""); // 숫자만 추출
            mplistmgr_id = Integer.parseInt(body);
        } catch (Exception e) {
            response.getWriter().write("{\"success\":false, \"message\":\"ID 파싱 오류\"}");
            return;
        }

        try {
            MplistMgrMgr mgr = new MplistMgrMgr();
            mgr.deleteMplistMgr(mplistmgr_id);
            response.getWriter().write("{\"success\":true}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\":false, \"message\":\"삭제 실패\"}");
        }
    }
}
