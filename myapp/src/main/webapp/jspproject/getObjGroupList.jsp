<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="java.util.*, jspproject.ObjMgr, jspproject.ObjGroupBean" %>

<%
    String user_id = (String) session.getAttribute("user_id");
    ObjMgr mgr = new ObjMgr();
    Vector<ObjGroupBean> groupList = mgr.getObjGroupList(user_id);

    StringBuilder json = new StringBuilder();
    json.append("[");

    for (int i = 0; i < groupList.size(); i++) {
        ObjGroupBean group = groupList.get(i);
        json.append("{");
        json.append("\"objgroup_id\":").append(group.getObjgroup_id()).append(",");
        json.append("\"objgroup_name\":\"").append(group.getObjgroup_name().replace("\"", "\\\"")).append("\",");
        json.append("\"user_id\":\"").append(group.getUser_id().replace("\"", "\\\"")).append("\"");
        json.append("}");

        if (i < groupList.size() - 1) {
            json.append(",");
        }
    }

    json.append("]");
    out.print(json.toString());
%>
