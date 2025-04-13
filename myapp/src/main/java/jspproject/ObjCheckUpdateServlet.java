package jspproject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

@WebServlet("/jspproject/objCheckUpdateServlet")
public class ObjCheckUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        PrintWriter out = response.getWriter();

        try {
            // JSON 요청 파싱
            StringBuffer sb = new StringBuffer();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            JSONObject json = new JSONObject(sb.toString());

            int obj_id = json.getInt("obj_id");
            int obj_check = json.getInt("obj_check");

            // 업데이트 처리
            ObjMgr mgr = new ObjMgr();
            mgr.updateCheckOnly(obj_id, obj_check);

            JSONObject result = new JSONObject();
            result.put("status", "success");
            out.print(result);

        } catch (Exception e) {
            e.printStackTrace();
            JSONObject error = new JSONObject();
            error.put("status", "error");
            out.print(error);
        }
	}
}
