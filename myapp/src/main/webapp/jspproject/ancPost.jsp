<!-- anc.jsp -->
<%@page import="jspproject.AncBean"%>
<%@page import="java.util.Vector"%>
<%@page import="jspproject.AncMgr"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
	AncMgr amgr = new AncMgr();
	Vector<AncBean> vlist = amgr.listAnc();
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
	height: 950px;
	background-color: #4A3C6E;
	margin: 0 auto;
	top: -200px;
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

.divider {
  position: absolute;
  top:70px;
  bottom:0px;
  left:400px;
  width: 1px;
  height: calc(100% - 70px);
  background-color: #888;
  margin: 0 16px;
} 

.box2{
 width:415px;
 height:30px;
 background-color: white;
 margin-left: 90px;
 border-radius: 10px; 
}

.box3{
 width:415px;
 height:400px;
 background-color: white;
 margin-left: 90px;
 border-radius: 10px; 
}

.box4{
 	width: 415px;
    min-height: 100px;
    height: auto;
    background-color: white;
    margin-left: 90px;
    border-radius: 10px;
}

.container-box {
  	display: flex;
  	position: relative;
}
.Ititle1 {
color: white;
	color: white;
    margin-left: 90px;
    padding-top: 30px;
    margin-bottom: 10px;
}

.Ititle2 {
	 color: white;
    margin-left: 90px;
    padding-top: 30px;
    margin-bottom: 10px;
    margin-top: 2px;
}

.Ititle3 {
	color: white;
	 margin-left: 90px;
	 padding-top: 30px;
	 margin-top: -1px;
}

.custom-upload-button {
  display: inline-block;
  padding: 10px 18px;
  background-color: #6D4CD4;
  color: white;
  border-radius: 6px;
  cursor: pointer;
  font-weight: bold;
  margin-right: 100px;
  margin-top: 15px;
}

.upload-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.complete-btn {
  background-color: #19092D;        
  color: white;
  padding: 12px 40px;              
  border: 1.5px solid white;
  border-radius: 10px;             
  font-size: 16px;
  font-weight: bold;
  text-align: center;
  cursor: pointer;
  transition: background-color 0.3s ease;
  margin-left: 100px;
   margin-top: 30px;
  width: 400px;
}

/* 호버 효과(optional) */
.complete-btn:hover {
  background-color: #301C4A;
}

</style>
<script>
function showFileName(input) {
	  const name = input.files[0]?.name || "선택된 파일 없음";
	  document.getElementById("selected-file-name").textContent = name;
	}
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
		<div>
	<form action="ancUploadProc.jsp" method="post" enctype="multipart/form-data">
		<h2 class="Ititle1" >제목</h2>
			 <input type="text" name="title" placeholder="제목을 입력하세요" class="box2">
		<div>
		<h2 class="Ititle2" >내용</h2>
  			<textarea name="content" placeholder="공지 내용을 입력하세요" class="box3"></textarea>
		</div>
  				<input type="file" id="uploadFile" name="uploadFile" style="display: none;" onchange="showFileName(this)">
 				<div class= "upload-header">
 				<h2 class="Ititle3">첨부파일</h2>
 				<label for="uploadFile" class="custom-upload-button">파일 선택</label>
 				</div>
  				<div class="box4">
    			<p id="selected-file-name" style="color:black;">선택된 파일 없음</p>
  				</div>
			<input type="submit" class="complete-btn" value="작성 완료">
		</form>
	</div>
</div>
</div>
</body>
</html>