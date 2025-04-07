<!-- ancList.jsp -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="jspproject.AncBean" %>
<%@ page import="jspproject.AncMgr" %>

<%
    // 로그인 세션 확인
    String userId = (String) session.getAttribute("id");
    if (userId == null) {
        response.sendRedirect("login.jsp"); // 로그인 페이지로 리디렉트
        return;
    }

    // 공지사항 불러오기
    AncMgr mgr = new AncMgr();
    Vector<AncBean> vlist = mgr.listPageAnc(1, 10); // 최근 공지 10개 불러오기
%>

<style>
@font-face {
	font-family: 'PFStarDust';
	src: url('fonts/PFStarDust-Bold.ttf') format('truetype');
	font-weight: bold;
	font-style: normal;
}

.add-anclist-container {
	position: absolute !important;
	top: 0;
	left: 0;
	z-index: 9999;
	width: 300px;
	height: 500px;
	background-color: rgba(29, 16, 45, 0.85);
	border-radius: 8px;
	padding: 10px;
	font-family: 'PFStarDust', sans-serif;
	color: white;
	box-shadow: 0 0 10px rgba(255,255,255,0.4);
}

.add-anclist-title {
	font-size: 20px;
	padding-bottom: 6px;
	border-bottom: 1px solid #aaa;
	margin-bottom: 10px;
	font-weight: bold;
}

.add-anclist-list {
	max-height: 460px;
	overflow-y: auto;
	margin-bottom: 10px;
	display: flex;
	flex-direction: column;
	gap: 10px;
	padding-right: 3px;
}

.add-anclist-list::-webkit-scrollbar {
	width: 10px;
}
.add-anclist-list::-webkit-scrollbar-thumb {
	background-color: white;
	border-radius: 10px;
	border: 2px solid transparent;
	background-clip: content-box;
}

.add-anclist-card {
	background-color: rgba(255, 255, 255, 0.05);
	border: 1px solid white;
	border-radius: 12px;
	padding: 10px 12px;
	display: flex;
	flex-direction: column;
	gap: 4px;
}

.anclist-title {
	font-size: 13px;
	font-weight: bold;
}

.anclist-desc {
	font-size: 12px;
	color: rgba(255,255,255,0.7);
}
</style>

<div class="add-anclist-container">
	<div class="add-anclist-title">공지사항</div>
	<div class="add-anclist-list">
		<%
			for (AncBean bean : vlist) {
		%>
			<a href="userAncDetail.jsp?anc_id=<%=bean.getAnc_id()%>"><div class="add-anclist-card">
				<!-- 여기는 상세페이지로 이동하는 주소값  -->
				<div class="anclist-title"><%= bean.getAnc_title() %></div>
				<div class="anclist-desc"><%= bean.getAnc_cnt() %></div>
			</div></a>
		<%
			}
			if (vlist.size() == 0) {
		%>
			<div class="add-anclist-card">
				<div class="anclist-title">공지 없음</div>
				<div class="anclist-desc">등록된 공지사항이 없습니다.</div>
			</div>
		<% } %>
	</div>
</div>