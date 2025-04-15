package jspproject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

//ResetBgmOnOffServlet.java
@WebServlet("/jspproject/resetBgmOnOff")
public class ResetBgmOnOffServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        BgmMgr mgr = new BgmMgr();
        mgr.resetAllBgmOnOff(); // 모든 bgm_onoff를 0으로
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
