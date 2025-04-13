package jspproject;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/jspproject/bgmOnOff")
public class BgmOnOffServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        BufferedReader reader = request.getReader();
        JSONObject json = new JSONObject(reader.readLine());

        int bgmId = json.getInt("bgm_id");
        int onoff = json.getInt("bgm_onoff");

        BgmMgr mgr = new BgmMgr();
        boolean result = mgr.updateBgmOnOff(bgmId, onoff);

        JSONObject res = new JSONObject();
        res.put("success", result);
        response.getWriter().write(res.toString());
    }
}
