<!-- findId.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		String path = request.getContextPath();

%>
<html>
<head>
<title>오늘, 내일</title>
<script src="https://accounts.google.com/gsi/client" async defer></script>

<style>

@font-face {
    font-family: 'PFStarDust';
    src: url('fonts/PFStarDust-Bold.ttf') format('truetype');
    font-weight: bold;
    font-style: normal;
}
a{
	text-decoration: none;
	color: white;
}
body, html {
  	margin: 0;
    padding: 0;
    height: 100%;
    background-color:#372358;
    font-family: 'PFStarDust', sans-serif;
}
.container {
	display: flex;
	height: 100vh;
}
.left-half{
 	flex: 1;
  	background-image: url('images/loginimg.jpg');
  	background-size: cover;
  	background-position: left;
}
.right-half{
	flex: 1;
	display: flex;
	flex-direction: column; 
	justify-content: center;/*가로*/
	align-items:center;
	height: 100%;
	align-text: center;
}
.right-half_title{
	margin-bottom: 10px;/*세로*/
	text-decoration: none;
}
.login-box{
	background-color: #4A3C6E;
	border-radius: 10px;
	width: 458px;
	height: 490px;
	margin-top: 20px;/*세로*/
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}
.find-box_title{
	display: flex;
	justify-content: center;
	color: white;
	margin: 50px;
}
.line{
	width: 100%;
    height: 1px;
    background-color: white;
    margin-bottom: 60px;
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
    margin: 18px auto;
    border-radius: 10px;
    border: none;
    margin-bottom: 40px;
}
.signup-button{
  	display: block;
    text-align: right;
    font-size: 16px;
    color: white;
    margin: 10px auto 0;
    width: 80%;
    text-decoration: none;
}
.find-btn{
	display: block;
	width: 400px;
	height: 50px;
    padding: 10px;
    margin: 18px auto;
    border-radius: 10px;
    border: none;
    background-color: #6D4CD4;
    color: white;
    font-family: 'PFStarDust', sans-serif;
    font-size: 20px;
}
.g_id_signin {
	margin: 18px auto ;
	display: block;
	width: 400px;
}
.findpw-button {
	display: block;
    text-align: right;
    font-size: 15px;
    color: white;
    margin: 10px auto 0;
    width: 10%;
    text-decoration: none;
    position: absolute;
    margin-left: -75;
    margin-top: revert-layer;
}
</style>
</head>
<script>
  
</script>

<body>

<div class="container">
	<div class="left-half"></div>
	<div class="right-half">
		<!-- 로그인 폼 -->
		<h1 class="right-half_title"><a href="login.jsp">오늘, 내일</a></h1>
		<div class="login-box">
			<h2 class="find-box_title" >아이디 찾기</h2>
			<div class="line"></div>
			<h2 class= "login-box_text"></h2>
			<form action="findPost" method="post">
			<%
				String error = request.getParameter("error");
				if("login_failed".equals(error)) { %>
					 <div style="width: 400px; margin: 0 auto; color: #ffcccc; text-align: center; background-color: #7c3f58; padding: 10px; border-radius: 8px;">
			            입력하신 정보가 존재하지않습니다.
			        </div>
				<%} %>
			<input type="text"  name="user_name" placeholder="이름" class="input-field">
			<input type="text" name="user_phone" placeholder="전화번호" class="input-field">
			<a href="#" class="findpw-button">비밀번호 찾기</a>
			<a href="register.jsp" class="signup-button">회원가입</a>
			<button type="submit" class="find-btn">아이디 찾기</button>
			</form>
		</div><!-- 로그인 박스 -->
	</div><!-- 오른쪽 -->
</div>
</body>
</html>