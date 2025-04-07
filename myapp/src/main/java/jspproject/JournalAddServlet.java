package jspproject;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

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
		response.setContentType("application/json;charset=UTF-8");

		String user_id = request.getParameter("user_id");
		String jour_title = request.getParameter("jour_title");
		String jour_cnt = request.getParameter("jour_cnt");

		JourBean bean = new JourBean();
		bean.setUser_id(user_id);
		bean.setJour_title(jour_title);
		bean.setJour_cnt(jour_cnt);

		JourMgr jMgr = new JourMgr();
		int newId = jMgr.insertJour(bean);  // ➜ int로 리턴받게 수정 필요

		// 오늘 날짜 포맷
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy'년' M'월' d'일' (E)");
		String today = sdf.format(new Date());

		PrintWriter out = response.getWriter();
		out.print("{");
		out.print("\"jour_id\": " + newId + ",");
		out.print("\"jour_regdate\": \"" + today + "\"");
		out.print("}");
	}
}
