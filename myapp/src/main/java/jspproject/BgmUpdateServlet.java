package jspproject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/jspproject/bgmUpdate")
public class BgmUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        JSONObject json = new JSONObject();

        try {
            String body = new BufferedReader(new InputStreamReader(request.getInputStream()))
                    .lines().collect(Collectors.joining("\n"));
            JSONObject reqData = new JSONObject(body);

            int bgm_id = reqData.getInt("bgm_id");
            String bgm_name = reqData.getString("bgm_name");
            String bgm_cnt = reqData.getString("bgm_cnt");

            BgmMgr mgr = new BgmMgr();
            boolean result = mgr.updateBgmInfo(bgm_id, bgm_name, bgm_cnt);

            json.put("success", result);

        } catch (Exception e) {
            e.printStackTrace();
            json.put("success", false);
            json.put("message", e.getMessage());
        }

        response.getWriter().write(json.toString());
    }
}
