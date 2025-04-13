package jspproject;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/jspproject/mplistOnOff")
public class MplistOnOffServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JSONObject body = new JSONObject(request.getReader().lines().collect(Collectors.joining()));
        int mplist_id = body.getInt("mplist_id");
        int mplist_onoff = body.getInt("mplist_onoff");

        MplistMgr mgr = new MplistMgr();
        mgr.updateMplistOnOff(mplist_id, mplist_onoff);

        response.setContentType("application/json");
        response.getWriter().write("{\"success\": true}");
    }
}

