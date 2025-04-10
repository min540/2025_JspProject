<!-- ancDetail.jsp -->
<%@page import="jspproject.AncBean"%>
<%@page import="jspproject.AncMgr"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%	
	int anc_id = Integer.parseInt(request.getParameter("anc_id"));
	AncMgr amgr = new AncMgr();
	AncBean bean = amgr.getAnc(anc_id);
	AncBean pbean = amgr.beforeImg(anc_id);
%>
<html>
<head>
<title>오늘, 내일</title>
<style>

@font-face {
    font-family: 'PFStarDust';
    src: url('fonts/PFStarDust-Bold.ttf') format('truetype');
    font-weight: bold;
    font-style: normal;
}
body, html {
  	margin: 0;
    padding: 0;
    height: 100%;
    background-color:#372358;
}
header{
	display: flex;
	justify-content: center;
    align-items: center; 
  	margin-bottom: 20px;
  	padding-right: 370px; 
  	
}
header h3 {
	color: white;
	margin: 0 12px; /* 좌우 여백만 */
	margin-top: 25px;
	font-family: 'PFStarDust', sans-serif;
	font-size: 25px;
}
header h4 {
	color: white;
	margin: 0 12px; /* 좌우 여백만 */
	margin-top: 25px;
	font-family: 'PFStarDust', sans-serif;
	font-size: 18px;
}
.image-wrapper {
  position: relative;
  width: auto;
  margin: 0 auto;
}
.main-image {
  width: 100%;
  height: 400px;
  object-fit: cover;
  display: block;
}
.blur-left, .blur-right {
  position: absolute;
  top: 0;
  width: 80px;
  height: 100%;
  z-index: 2;
  pointer-events: none;
}
.blur-left {
  left: 0;
  background: linear-gradient(to right, rgba(55, 35, 88, 1), transparent);
}
.blur-right {
  right: 0;
  background: linear-gradient(to left, rgba(55, 35, 88, 1), transparent);
}
.inner-effect {
  	box-shadow: inset 0 0 80px rgba(0, 0, 0, 0.5);
  	position: absolute;
  	top: 0;
  	left: 0;
  	width: 100%;
    height: 100%;
    pointer-events: none;
}
.box{
	margin-left: auto;
    margin-right: 30px;
}
.ncontent{
	margin-left: 20px;
    color: white;
    margin-top: 15px;
    white-space: pre-wrap;
}
.container {
  display: flex;
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  align-items: stretch;
}
.container-box {
  	display: flex;
    align-items: stretch;
    min-height: 500px;
    margin-left: -870px;
    margin-top: -140;
    position: absolute;
}
.ntitle{
	margin-left: 20px;
	color: white;
}
.left-section {
 	width: 415px;
    height: 1000px;
    box-sizing: border-box;
    background-color: #5C4B85;
    padding: 15px;
}

.right-section {
	height: 1000px;
    width: 186px;
    background-color: #3f235a;
}

.box1 {
  	width: 130px;
    height: 130px;
    background-color: #372358;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    margin-left: auto;
    margin-right: 26px;
    margin-top: 80px;
    color: white;
}
.rtext{
	color: white;
    margin-top: 10px;
    margin-left: 32px;
    font-size: 15px;
    font-weight: bold;
}
.rdtext{
	color: white;
    margin-top: 5px;
    margin-left: 34px;
    font-size: 15px;
}
.image-overlay-text {
  position: absolute;
  top: 0px;
  width: 130px;
  height: 130px;
  display: flex;
  color: black;
  font-weight: bold;
  font-size: 13px;
  text-align: center;
  padding: 10px;
  box-sizing: border-box;
  margin-left: auto;
  margin-right: 45px;
  margin-top: 90px;
  pointer-events: none;
}
.sbtn{
	margin-left: 200px;
	margin-top: 10px;
	background: none;

}
.text-button1{
	background: none;
    border: none;
    font: inherit;
    cursor: pointer;
    text-decoration: none;
    color: white;
    position: absolute;
    width: 50px;
    margin-left: -115;
}

.text-button2{
	background: none;
    border: none;
    font: inherit;
    cursor: pointer;
    text-decoration: none;
    color: white;
    position: absolute;
    width: 50px;
    margin-left: -65;
}

</style>
<script>
</script>
</head> 
<body>
	<header>
	<h3>오늘, 내일</h3>
	<a href="anc.jsp"><h4>공지사항</h4></a>
	<a href="ancPost.jsp"><h4>글쓰기</h4></a>
	</header>
<div class="image-wrapper">
  <img src="http://localhost/2025_JspProject/jspproject/images/loginimg.jpg" class="main-image" />
  <div class="blur-left"></div>
  <div class="blur-right"></div>
  <div class="inner-effect"></div>
</div>
<div class="container">
	<div class="box">	
		<div class="container-box">
			<div class="left-section">	
				<h2 class="ntitle" style="font-size:30px;"><%=bean.getAnc_title() %></h2>
			<!-- 공지사항 내용 -->
			<% if (bean.getAnc_img() != null) { %>
				<img src="<%= request.getContextPath() %>/jspproject/upload/<%= bean.getAnc_img() %>" width="385" height="200">
			<% } %>
			<div class="ncontent"><%=bean.getAnc_cnt() %></div>
			</div>
			
			<div class="divider"></div>	
			
			<div class="right-section">
			<!-- 수정 | 삭제 -->
			<div class="sbtn">
			<a href="ancUpdate.jsp?anc_id=<%=bean.getAnc_id()%>"><button  class="text-button1">수정</button></a>
			<a href="ancDeleteProc.jsp?ancIds=<%=bean.getAnc_id()%>" onclick="return confirm('정말 삭제하시겠습니까?')">
			<button  class="text-button2">삭제</button>
			</a>
			</div>
			<!-- 이전공지 업데이트-->
			<div class="box1">
			
			<% if (pbean.getAnc_id()!= 0) { %>
		
			<div class="image-overlay-text">
    		</div>
			<a href="ancDetail.jsp?anc_id=<%= pbean.getAnc_id() %>">
			<img src="<%= request.getContextPath() %>/jspproject/upload/<%= pbean.getAnc_img() %>" width="130" height="130"></img>
			</a>
			
				<% }else{ %>
					<p>이전 공지가 없습니다.<p>
				<% } %>
			</div>
			<div style="margin-bottom: 70px;">
			<div class="rtext"">게시일시</div>
			<div class="rdtext"><%=bean.getAnc_regdate()%></div>
			</div>
			<div class="rtext">작성자</div>
			<div class="rdtext"><%=bean.getUser_id()%></div>
			</div>
		</div>
	</div>
</div>
</body>
</html>