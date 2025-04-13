package jspproject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/jspproject/mplistInsert")
public class MplistInsertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MplistMgr mgr;

    public void init() {
        mgr = new MplistMgr();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean result = mgr.insertMplist(request);
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(result ? "success" : "fail");
    }
}
