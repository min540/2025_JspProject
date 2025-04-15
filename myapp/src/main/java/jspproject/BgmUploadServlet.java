package jspproject;

import java.io.File;
import java.io.InputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONObject;

@WebServlet("/jspproject/bgmUpload")
@MultipartConfig
public class BgmUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    private static final String IMAGE_PATH = "C:/Users/dita_806/git/2025_JspProject_dtada11/myapp/src/main/webapp/jspproject/musicImg";
    private static final String MUSIC_PATH = "C:/Users/dita_806/git/2025_JspProject_dtada11/myapp/src/main/webapp/jspproject/music";


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        JSONObject json = new JSONObject();
        BgmMgr bmgr = new BgmMgr();

        try {
            String user_id = request.getParameter("user_id");
            String bgm_name = request.getParameter("bgm_name");
            String bgm_cnt = request.getParameter("bgm_cnt");
            int bgm_onoff = 0;

            // 이미지 업로드 처리 (Optional)
            Part imagePart = null;
            String imageFileName = null;
            try {
                imagePart = request.getPart("image");
                if (imagePart != null && imagePart.getSize() > 0) {
                    imageFileName = getFileName(imagePart);
                    File imageFile = new File(IMAGE_PATH, imageFileName);
                    try (InputStream input = imagePart.getInputStream()) {
                        Files.copy(input, imageFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }
                }
            } catch (Exception e) {
                System.out.println("이미지 업로드 생략 또는 실패: " + e.getMessage());
            }

            // 기본 이미지 처리
            if (imageFileName == null || imageFileName.isEmpty()) {
                imageFileName = "default.png";
            }

            // 음악 업로드 처리 (Required)
            Part musicPart = request.getPart("music");
            String musicFileName = getFileName(musicPart);
            if (musicFileName == null || musicFileName.isEmpty()) {
                json.put("success", false);
                json.put("message", "음악 파일이 없습니다.");
                response.getWriter().write(json.toString());
                return;
            }
            File musicFile = new File(MUSIC_PATH, musicFileName);
            try (InputStream input = musicPart.getInputStream()) {
                Files.copy(input, musicFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            // 기본값 설정
            if (bgm_name == null || bgm_name.isEmpty()) {
                bgm_name = musicFileName;
            }
            if (bgm_cnt == null) {
            	bgm_cnt = "음악에 대한 설명을 추가해주세요";
            }

            // DB에 저장
            BgmBean bean = new BgmBean();
            bean.setUser_id(user_id);
            bean.setBgm_name(bgm_name);
            bean.setBgm_cnt(bgm_cnt);
            bean.setBgm_music(musicFileName);
            bean.setBgm_onoff(bgm_onoff);
            bean.setBgm_image(imageFileName);

            int newId = bmgr.insertSimpleBgm(bean);

            if (newId > 0) {
                json.put("success", true);
                json.put("message", "업로드 성공");
                json.put("bgmId", newId);
                json.put("musicTitle", bgm_name);
                json.put("cnt", bgm_cnt);
                json.put("image", imageFileName);
            } else {
                json.put("success", false);
                json.put("message", "DB 저장 실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
            json.put("success", false);
            json.put("message", "서버 오류 발생: " + e.getMessage());
        }

        response.getWriter().write(json.toString());
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) return null;
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
