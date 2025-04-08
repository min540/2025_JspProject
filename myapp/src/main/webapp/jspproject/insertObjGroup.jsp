<%@ page contentType="text/plain; charset=UTF-8" %>
<%@ page import="jspproject.ObjMgr, jspproject.ObjGroupBean" %>

<%
    request.setCharacterEncoding("UTF-8");

    String objgroup_name = request.getParameter("objgroup_name");
    String user_id = (String) session.getAttribute("user_id"); // 로그인 상태에서 세션에 저장된 user_id

   /*  System.out.println("📥 [insertObjGroup.jsp] 호출됨");
    System.out.println("받은 objgroup_name: " + objgroup_name);
    System.out.println("현재 user_id: " + user_id); */

    if (objgroup_name != null && user_id != null) {
        ObjGroupBean bean = new ObjGroupBean();
        bean.setObjgroup_name(objgroup_name);
        bean.setUser_id(user_id);

        ObjMgr mgr = new ObjMgr();
        int objgroup_id = mgr.insertObjGroupAndReturnId(bean); 
		
        out.print(objgroup_id);
    } else {
    	 out.print("-1"); // 실패
    }
%>
