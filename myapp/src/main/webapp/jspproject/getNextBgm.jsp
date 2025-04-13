<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="jspproject.MplistMgrMgr, jspproject.MplistBgmView" %>
<%@ page import="org.json.JSONObject" %>

<%
String user_id = request.getParameter("user_id");
String mplistParam = request.getParameter("mplist_id");
String orderParam = request.getParameter("order");

if (user_id == null || mplistParam == null || orderParam == null || user_id.isEmpty() || mplistParam.isEmpty() || orderParam.isEmpty()) {
    response.setStatus(400);
    out.print("{\"error\": \"Missing parameters\"}");
    return;
}

int mplist_id = Integer.parseInt(mplistParam);
int current_order = Integer.parseInt(orderParam);

MplistMgrMgr mgr = new MplistMgrMgr();
MplistBgmView next = mgr.getNextBgm(user_id, mplist_id, current_order);

if (next != null) {
    JSONObject obj = new JSONObject();
    obj.put("bgm_id", next.getBgm().getBgm_id());
    obj.put("bgm_name", next.getBgm().getBgm_name());
    obj.put("bgm_cnt", next.getBgm().getBgm_cnt());
    obj.put("bgm_music", next.getBgm().getBgm_music());
    obj.put("bgm_image", next.getBgm().getBgm_image());
    obj.put("bgm_order", next.getBgm_order());
    obj.put("mplist_id", next.getMplist_id());

    out.print(obj.toString());
} else {
    out.print("{}");
}
%>
