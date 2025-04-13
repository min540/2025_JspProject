package jspproject;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/jspproject/bgmOnOff")
public class BgmOnOffServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JSONObject body = new JSONObject(request.getReader().lines().collect(Collectors.joining()));
        int bgm_id = body.getInt("bgm_id");
        int bgm_onoff = body.getInt("bgm_onoff");

        BgmMgr mgr = new BgmMgr();
        mgr.updateBgmOnOff(bgm_id, bgm_onoff);

        response.setContentType("application/json");
        response.getWriter().write("{\"success\": true}");
    }
}
