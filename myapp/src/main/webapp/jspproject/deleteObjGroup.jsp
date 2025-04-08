<!-- deleteObjGroup.jsp -->
<%@ page contentType="text/plain; charset=UTF-8" %>
<%@ page import="jspproject.ObjMgr" %>

<%
    request.setCharacterEncoding("UTF-8");

     String objgroupIdParam = request.getParameter("objgroup_id");
     /* System.out.println("🗑️ [deleteObjGroup.jsp] 호출됨 - objgroup_id: " + objgroupIdParam); */

    if (objgroupIdParam != null) {
        try {
            int objgroup_id = Integer.parseInt(objgroupIdParam);
            ObjMgr mgr = new ObjMgr();
            mgr.deleteObjGroup(objgroup_id);
            out.print("SUCCESS");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("FAIL: 예외 발생");
        }
    } else {
        out.print("FAIL: objgroup_id 없음");
    }
%>
