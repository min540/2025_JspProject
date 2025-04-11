<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Vector" %>
<%@ page import="jspproject.BgmBean" %>
<%@ page import="jspproject.BgmMgr" %>

<%
String param = request.getParameter("bgm_id");
if (param == null) {
    out.print("<div style='color:white;'>잘못된 요청입니다.</div>");
    return;
}

int bgm_id = Integer.parseInt(param);
BgmMgr mgr = new BgmMgr();
Vector<BgmBean> list = mgr.searchMplistBgm(bgm_id);

if (list != null && !list.isEmpty()) {
    BgmBean b = list.get(0);
%>
    <div class="preview-icons2">
	    <img class="iconMusicList2" src="icon/아이콘_삭제_1.png" alt="삭제">
	</div>
	
	<div class="music-preview3">
	    <img class="musicImg2" src="img/<%= b.getBgm_image() != null ? b.getBgm_image() : "default.png" %>" alt="음악 이미지">
	    <h2 class="editable-title"><%= b.getBgm_name() %></h2>
	</div>
	
	<div class="music-controls3">
	    <span><img class="iconMusic2" src="icon/아이콘_이전음악_1.png" alt="이전 음악"></span>
	    <span>
	        <img id="playToggleBtn2" class="iconMusic2" src="icon/아이콘_재생_1.png" data-state="paused">
	        <audio id="playListAudioPlayer" src="music/<%= b.getBgm_music() %>"></audio>
	    </span>
	    <span><img class="iconMusic2" src="icon/아이콘_다음음악_1.png" alt="다음 음악"></span>
	</div>
	
	<div class="music-description3">
	    <textarea readonly><%= b.getBgm_cnt() %></textarea>
	</div>
	
	<div class="music-cancel-button3">
	    <button class="btn-purple">음악 취소</button>
	</div>
<%
} else {
%>
    <div style="color:white;">음악 정보를 불러올 수 없습니다.</div>
<%
}
%>
