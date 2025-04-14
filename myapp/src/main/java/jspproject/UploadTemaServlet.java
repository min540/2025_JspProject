package jspproject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UploadTemaServlet
 */
@WebServlet("/jspproject/uploadTemaServlet")
@MultipartConfig
public class UploadTemaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String user_id = (String) session.getAttribute("user_id");

        PrintWriter out = response.getWriter();

        if (user_id == null) {
            out.print("{\"status\":\"fail\", \"message\":\"로그인이 필요합니다.\"}");
            return;
        }

        TemaMgr mgr = new TemaMgr();
        Map<String, String> resultMap = mgr.uploadFile(request, user_id);

        String tema_img = resultMap.get("tema_img");
        String tema_title = resultMap.get("tema_title");
        String tema_cnt = resultMap.get("tema_cnt");

        if (tema_img != null) {
            out.print("{");
            out.print("\"status\":\"ok\",");
            out.print("\"tema_img\":\"" + tema_img + "\",");
            out.print("\"tema_title\":\"" + tema_title + "\",");
            out.print("\"tema_cnt\":\"" + tema_cnt + "\"");
            out.print("}");
        } else {
            out.print("{\"status\":\"fail\", \"message\":\"DB 저장 실패\"}");
        }

        out.close();
    }
}
