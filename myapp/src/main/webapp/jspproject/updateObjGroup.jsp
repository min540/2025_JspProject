<!-- updateObjGroup.jsp -->
<%@ page contentType="text/plain; charset=UTF-8" %>
<%@ page import="jspproject.ObjMgr, jspproject.ObjGroupBean" %>

<%
    request.setCharacterEncoding("UTF-8");

    String idParam = request.getParameter("objgroup_id");
    String name = request.getParameter("objgroup_name");

    if (idParam != null && name != null) {
        try {
            int objgroup_id = Integer.parseInt(idParam);
            ObjGroupBean bean = new ObjGroupBean();
            bean.setObjgroup_id(objgroup_id);
            bean.setObjgroup_name(name);

            ObjMgr mgr = new ObjMgr();
            mgr.updateObjGroup(bean);

            out.print("SUCCESS");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("FAIL");
        }
    } else {
        out.print("FAIL: 파라미터 누락");
    }
%>
