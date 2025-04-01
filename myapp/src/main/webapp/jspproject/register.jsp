<!-- register.jsp -->
<%@page import="jspproject.LoginMgr"%>
<%@ page  contentType="text/html; charset=UTF-8"%>

<html>
<head>
<title>오늘, 내일</title>
<script src="https://accounts.google.com/gsi/client" async defer></script>
<style>
body, html {
  	margin: 0;
    padding: 0;
    height: 100%;
    background-color:#372358;
}
.container {
	display: flex;
	height: 100vh;
}
.left-half{
 	flex: 1;
  	background-image: url('http://localhost/2025_JspProject/jspproject/images/loginimg.jpg');
  	background-size: cover;
  	background-position: left;
}
.right-half{
	flex: 1;
	display:flex;
	flex-direction: column; 
	justify-content:flex-start;;/*가로*/
	align-items:center;
	height: 100%;
	align-text: center;
	/* padding-top: 20px; */
	transform: translateY(-10px);
}
.right-half_title{
	color: white;
	margin-bottom: 10px;/*세로*/
}
.login-box{
	background-color: #4A3C6E;
	border-radius: 10px;
	width: 458px;
	height: 628px;
	margin-top: 20px;/*세로*/
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}
.login-box_title{
	display: flex;
	justify-content: center;
	color: white;
}
.line{
	width: 100%;
    height: 1px;
    background-color: white;
    margin-top: 20px;
}
.login-box_text{
  color: white;
  margin-left: 30px;
}
.input-field{
	display: block;
	width: 400px;
	height: 50px;
   	padding: 10px;
    margin: 0 auto;
    border-radius: 10px;
    border: none;
}
.signup-button{
  display: block;
    text-align: right;
    font-size: 13px;
    color: white;
    margin: 10px auto 0;
    width: 80%; /* input 필드랑 폭 맞춰주기 */
    text-decoration: none;
}
.login-btn{
	display: block;
	width: 400px;
	height: 50px;
    padding: 10px;
    margin: 18px auto;
    border-radius: 10px;
    border: none;
    background-color: #6D4CD4;
    cursor: pointer;
}
.check-btn {
  width: 100px;
  height: 50px;
  background-color: #6D4CD4;
  color: white;
  border: none;
  border-radius: 10px;
  cursor: pointer;
}
.input-row {
  display: flex;
  justify-content: center;
  align-items: center; 
  gap: 10px;
  margin: 18px auto;
  width: 400px;
}
.form-item {
  margin: 18px auto;
  width: 400px;
}
</style>
</head>
<script>
function checkId() {
	  const userId = document.querySelector('[name="user_id"]').value;

	  if (!userId.trim()) {
	    alert("아이디를 입력해주세요.");
	    return;
	  }

	  fetch("/2025_JspProject/jspproject/IdCheckServlet?user_id=" + encodeURIComponent(userId))
	    .then(res => res.text())
	    .then(result => {
	      if (result === "true") {
	        alert("사용 가능한 아이디입니다!");
	      } else {
	        alert("이미 사용중인 아이디입니다.");
	      }
	    });
	}</script>
<body>
<div class="container">
	<div class="left-half"></div>
	<div class="right-half">
		<!-- 로그인 폼 -->
		<h1 class="right-half_title">오늘, 내일</h1>
		<div class="login-box">
			<h2 class="login-box_title" >회원가입</h2>
			<h3 class= "login-box_text">당신의 공간을 만들어보세요</h3>
			<div class="line"></div>
			
<form action="/2025_JspProject/jspproject/userPost" method="post" enctype="multipart/form-data">
    <div class="input-row form-item">
    <input type="text" name="user_id" placeholder="아이디" class="input-field " required  style="width: 290px;" value="<%= request.getParameter("user_id") != null ? request.getParameter("user_id") : "" %>">
    <button type="button" onclick="checkId()" class="check-btn" style="width: 100px; height: 50px; font-size: 14px;">중복확인</button>
    </div>
    <input type="password" name="user_pwd" placeholder="비밀번호" class="input-field form-item" required>
    <input type="password" name="user_pwd_confirm" placeholder="비밀번호 확인" class="input-field form-item" required>
    <input type="text" name="user_name" placeholder="이름" class="input-field form-item" required>
    <input type="text" name="user_email" placeholder="이메일" class="input-field form-item" required>
    <input type="text" name="user_phone" placeholder="전화번호" class="input-field form-item" required>
    <button type="submit" class="login-btn">회원가입</button>
</form>

		</div><!-- 로그인 박스 -->
	</div><!-- 오른쪽 -->
</div>
</body>
</html>