// ✅ BgmImageUpdateServlet.java
package jspproject;

import java.io.*;
import java.nio.file.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import org.json.JSONObject;

@WebServlet("/jspproject/bgmImageUpdate")
@MultipartConfig
public class BgmImageUpdateServlet extends HttpServlet {
    private static final String IMAGE_PATH = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/img";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        JSONObject json = new JSONObject();

        try {
            int bgmId = Integer.parseInt(request.getParameter("bgm_id"));
            Part imagePart = request.getPart("bgm_image");

            // ✅ 디렉토리 확인 및 생성
            File directory = new File(IMAGE_PATH);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            // 파일 저장
            String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            File file = new File(IMAGE_PATH, fileName);

            try (InputStream input = imagePart.getInputStream()) {
                Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            // DB 업데이트
            BgmMgr bmgr = new BgmMgr();
            boolean updated = bmgr.updateBgmImage(bgmId, fileName);

            json.put("success", updated);
            json.put("filename", fileName);

        } catch (Exception e) {
            e.printStackTrace();
            json.put("success", false);
            json.put("message", e.getMessage());
        }

        response.getWriter().write(json.toString());
    }
}
