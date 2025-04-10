<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="java.util.*, jspproject.JourMgr, jspproject.JourBean" %>

<%
	String userId = (String) session.getAttribute("user_id");
	JourMgr jmgr = new JourMgr();
	Vector<JourBean> list = jmgr.listJour(userId);
	
	StringBuilder json = new StringBuilder();
	json.append("[");
	for (int i = 0; i < list.size(); i++) {
	    JourBean bean = list.get(i);
	    json.append("{")
	        .append("\"jour_id\":").append(bean.getJour_id()).append(",")
	        .append("\"title\":\"").append(bean.getJour_title().replace("\"", "\\\"")).append("\",")
	        .append("\"content\":\"").append(bean.getJour_cnt().replace("\"", "\\\"")).append("\",")
	        .append("\"regdate\":\"").append(bean.getJour_regdate()).append("\"")
	        .append("}");
	    if (i < list.size() - 1) json.append(",");
	}
	json.append("]");
	out.print(json.toString());
%>
