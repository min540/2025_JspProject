// JournalUpdateServlet.java
package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/jourUpdate")
public class JournalUpdateServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
    JourBean bean = new JourBean();
    bean.setJour_id(Integer.parseInt(request.getParameter("jour_id")));
    bean.setJour_title(request.getParameter("jour_title"));
    bean.setJour_cnt(request.getParameter("jour_cnt"));

    JourMgr jMgr = new JourMgr();
    jMgr.updateJour(bean);
    response.sendRedirect("mainScreen.jsp");
  }
}