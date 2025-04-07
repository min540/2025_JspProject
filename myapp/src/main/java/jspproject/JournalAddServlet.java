// JournalAddServlet.java
package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/jourAdd")
public class JournalAddServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response) 
      throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");
    String user_id = request.getParameter("user_id");
    String jour_title = request.getParameter("jour_title");
    String jour_cnt = request.getParameter("jour_cnt");

    JourBean bean = new JourBean();
    bean.setUser_id(user_id);
    bean.setJour_title(jour_title);
    bean.setJour_cnt(jour_cnt);

    JourMgr jMgr = new JourMgr();
    jMgr.insertJour(bean);

    response.setStatus(200); // 성공 시
  }
}
