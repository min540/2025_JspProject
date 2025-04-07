package jspproject;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/uploadMusic")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 50 * 1024 * 1024,
    maxRequestSize = 100 * 1024 * 1024
)
public class MusicUploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // 세션에서 user_id 가져오기 (또는 request.getParameter로 받기)
        HttpSession session = request.getSession();
        String user_id = (String) session.getAttribute("id");
        if (user_id == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "로그인 필요");
            return;
        }

        // 업로드 경로
        String musicPath = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/music";
        Part filePart = request.getPart("musicFile");

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        File uploadDir = new File(musicPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        File musicFile = new File(uploadDir, fileName);
        filePart.write(musicFile.getAbsolutePath());

        // BgmBean 생성
        BgmBean bgm = new BgmBean();
        bgm.setUser_id(user_id);
        bgm.setBgm_music(fileName);
        bgm.setBgm_name(fileName.replace(".mp3", "")); // 기본 이름
        bgm.setBgm_onoff(0);
        bgm.setBgm_cnt(""); // 설명 비워둠
        bgm.setBgm_image(null); // 이미지 없음
        bgm.setMplist_id(1); // 기본값

        // DB 저장
        BgmMgr mgr = new BgmMgr();
        boolean result = mgr.insertSimpleBgm(bgm); // 아래에서 새로 정의

        // 응답
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        if (result) {
        	out.print("{\"success\": true, \"musicTitle\": \"" + bgm.getBgm_name() + "\", \"bgmId\": " + bgm.getBgm_id() + "}");
        } else {
            out.print("{\"success\": false, \"message\": \"DB 저장 실패\"}");
        }
    }
}
