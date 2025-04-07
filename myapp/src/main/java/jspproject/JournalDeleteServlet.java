// JournalDeleteServlet.java
package jspproject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jspproject/jourDelete")
public class JournalDeleteServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    int jour_id = Integer.parseInt(request.getParameter("rnum"));
    JourMgr jMgr = new JourMgr();
    jMgr.deleteJour(jour_id);
    response.sendRedirect("mainScreen.jsp");
  }
}
