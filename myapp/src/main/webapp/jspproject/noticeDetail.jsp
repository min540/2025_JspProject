<!-- noticeDetail.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
	
%>
<html>
<head>
<title>오늘, 내일</title>
<style>
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
header h3, header h4 {
	color: white;
	margin: 0 12px; /* 좌우 여백만 */
	margin-top: 25px;
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
  top: 0; left: 0;
  width: 100%;
  height: 100%;
  z-index: 2;
  pointer-events: none;
}
.box{
	width: 600px;
	height: 1000px;
	background-color: #4A3C6E;
	margin: 0 auto;
	top: -140px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
	position: relative;
	z-index: 10;
	/* padding: 20px; */
}
.ntitle{
	margin-left: 20px;
	color: white;
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
}
.ntitle{
	margin-left: 20px;
	color: white;
}
.left-section, .right-section {
 	width: 50%;
 	box-sizing: border-box;
}
.divider {
  position: absolute;
  top:70px;
  bottom:0px;
  left:400px;
  width: 1px;
  height: auto;
  background-color: #888;
  margin: 0 16px;
}
.box1 {
  	width: 130px;
  	height: 130px;
  	background-color: #372358;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 선택: 그림자 효과 */
  	margin-left: auto;
	margin-right: 45px;
	margin-top: 70px;
	color: white;
}
.rtext{
	color: white;
	margin-top: 5px;
	margin-left: 125;
	font-size: 10px; 
	font-weight: bold;
}
.rdtext{
	color: white;
	margin-top: 5px;
	margin-left: 130px;
	font-size: 12px;
}
</style>
<script>
</script>
</head> 
<body>
	<header>
	<h3>오늘, 내일</h3>
	<h4>공지사항</h4>
	<h4>글쓰기</h4>
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
				<h2 class="ntitle" style="font-size:30px;">공지 제목</h2>
			<!-- 공지사항 내용 -->
			<div class="ntitle">공지내용 받아오는 부분 입니다.</div>
			</div>
			
			<div class="divider"></div>	
			
			<div class="right-section">
			<!-- 다음업데이트 박스, 게시일시랑 유형-->
			<div class="box1">다음업데이트 미리보기</div>
			<div style="margin-bottom: 70px;">
			<div class="rtext"">게시일시</div>
			<div class="rdtext">2025.04.03</div>
			</div>
			<div class="rtext">작성자</div>
			<div class="rdtext">오진우르스</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>