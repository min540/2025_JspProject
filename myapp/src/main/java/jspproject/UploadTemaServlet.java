package jspproject;

import java.io.File;
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

    private static final long serialVersionUID = 1L;

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

        // ✅ 이미지 저장 경로 (서버 기준 실제 경로로 변환)
        String saveFolder = getServletContext().getRealPath("/jspproject/backgroundImg/");
        File imageFile = new File(saveFolder, tema_img);

        // ✅ 이미지 파일이 실제로 생성될 때까지 최대 2초(20회) 대기
        int retry = 0;
        while (!imageFile.exists() && retry < 20) {
            try {
                Thread.sleep(100); // 100ms 대기
                retry++;
            } catch (InterruptedException e) {
                e.printStackTrace();
                break;
            }
        }

        // ✅ 파일이 존재하면 정상 응답
        if (tema_img != null && imageFile.exists()) {
            out.print("{");
            out.print("\"status\":\"ok\",");
            out.print("\"tema_img\":\"" + tema_img + "\",");
            out.print("\"tema_title\":\"" + tema_title + "\",");
            out.print("\"tema_cnt\":\"" + tema_cnt + "\"");
            out.print("}");
        } else {
            out.print("{\"status\":\"fail\", \"message\":\"이미지 파일이 존재하지 않습니다.\"}");
        }

        out.close();
    }
}