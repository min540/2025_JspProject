package jspproject;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/jspproject/profileIconUpdate")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 10,  // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ProfileIconUpdateServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // 세션에서 사용자 ID 가져오기
            HttpSession session = request.getSession();
            String userId = (String) session.getAttribute("id");
            
            if (userId == null) {
                out.print("{\"status\":\"error\",\"message\":\"로그인이 필요합니다.\"}");
                return;
            }
            
            // 파일 업로드 경로 설정
            String realFolder = request.getServletContext().getRealPath("/jspproject/img");
            File dir = new File(realFolder);
            if (!dir.exists()) dir.mkdirs();
            
            // 파일 업로드 처리 (기존 LoginMgr의 상수 사용)
            MultipartRequest multi = new MultipartRequest(
                request, 
                realFolder, 
                LoginMgr.MAXSIZE, 
                LoginMgr.ENCTYPE, 
                new DefaultFileRenamePolicy()
            );
            
            // 업로드된 파일명 가져오기
            String userIcon = multi.getFilesystemName("profile");
            
            if (userIcon == null || userIcon.trim().isEmpty()) {
                out.print("{\"status\":\"error\",\"message\":\"업로드할 이미지가 없습니다.\"}");
                return;
            }
            
            // 데이터베이스 업데이트를 위한 쿼리 실행
            Connection con = null;
            PreparedStatement pstmt = null;
            boolean success = false;
            
            try {
                DBConnectionMgr pool = DBConnectionMgr.getInstance();
                con = pool.getConnection();
                String sql = "UPDATE user SET user_icon = ? WHERE user_id = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, userIcon);
                pstmt.setString(2, userId);
                
                int rowsUpdated = pstmt.executeUpdate();
                success = (rowsUpdated > 0);
                
                // 연결 자원 해제
                pool.freeConnection(con, pstmt);
            } catch (Exception e) {
                e.printStackTrace();
                out.print("{\"status\":\"error\",\"message\":\"데이터베이스 업데이트 오류: " + e.getMessage().replace("\"", "\\\"") + "\"}");
                return;
            }
            
            if (success) {
                // 세션의 사용자 정보 업데이트
                LoginMgr lMgr = new LoginMgr();
                UserBean ubean = lMgr.getUser(userId);
                session.setAttribute("ubean", ubean);
                
                // 성공 응답
                out.print("{\"status\":\"success\",\"message\":\"프로필 이미지가 업데이트되었습니다.\",\"filename\":\"" + userIcon + "\"}");
            } else {
                out.print("{\"status\":\"error\",\"message\":\"프로필 이미지 업데이트에 실패했습니다.\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }
}