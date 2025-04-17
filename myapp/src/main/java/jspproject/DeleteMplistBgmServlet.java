// 🔧 DeleteMplistBgmServlet.java
package jspproject;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;  // 꼭 import!

@WebServlet("/jspproject/deleteMplistBgm")
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

        int mplistmgr_id;
        try {
            JSONObject obj = new JSONObject(json.toString());
            mplistmgr_id = obj.getInt("mplistmgr_id");
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
