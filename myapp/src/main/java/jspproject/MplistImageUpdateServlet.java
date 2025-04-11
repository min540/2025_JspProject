package jspproject;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import org.json.JSONObject;

@WebServlet("/jspproject/mplistImageUpdate")
public class MplistImageUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final String SAVEFOLDER = "C:/Users/dita_810/git/2025_JspProject/myapp/src/main/webapp/jspproject/mplistImg";  // ✅ 이미지 저장 경로
    private final int MAXSIZE = 10 * 1024 * 1024; // 최대 10MB
    private final String ENCTYPE = "UTF-8";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JSONObject json = new JSONObject();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            MultipartRequest multi = new MultipartRequest(request, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());

            int mplist_id = Integer.parseInt(multi.getParameter("mplist_id"));
            String mplist_img = multi.getFilesystemName("mplist_img");

            if (mplist_img == null || mplist_img.trim().isEmpty()) {
                json.put("success", false);
                json.put("message", "이미지 파일이 없습니다.");
                response.getWriter().write(json.toString());
                return;
            }

            MplistMgr mgr = new MplistMgr();
            boolean result = mgr.updatePListImage(mplist_id, mplist_img);

            if (result) {
                json.put("success", true);
                json.put("filename", mplist_img);
            } else {
                json.put("success", false);
                json.put("message", "DB 업데이트 실패");
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.put("success", false);
            json.put("message", "서버 오류 발생: " + e.getMessage());
        }

        PrintWriter out = response.getWriter();
        out.write(json.toString());
    }
}
