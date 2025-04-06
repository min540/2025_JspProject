<!-- ancList.jsp -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%-- musicListAdd.jsp --%>

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
	padding-right: 3px; /* 💡 스크롤바와 콘텐츠 간 여유 */
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
		<% for (int i = 1; i <= 10; i++) { %>
			<div class="add-anclist-card">
				<div class="anclist-title">공지사항 제목<%= i %></div>
				<div class="anclist-desc">공지사항 내용</div>
			</div>
		<% } %>
	</div>
</div>

