package jspproject;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/temaUpdateServlet")
public class TemaUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // 업로드 디렉토리 확인 및 생성
            String uploadDir = request.getServletContext().getRealPath("/jspproject/img");
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs(); // 디렉토리가 없으면 생성
            }
            
            TemaMgr tmgr = new TemaMgr();
            tmgr.updateTema(request);
            
            // 성공 시 테마 목록 페이지로 리다이렉트   
            response.sendRedirect(request.getContextPath() + "나중에 값넣기");
        } catch (Exception e) {
            e.printStackTrace();
            // 오류 발생 시 에러 메시지와 함께 테마 목록 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "나중에 값넣기");
        }
    }
}