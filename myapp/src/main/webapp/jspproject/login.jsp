<!-- login.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		
%>
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
	color: white;
	margin-bottom: 10px;/*세로*/
}
.login-box{
	background-color: #4A3C6E;
	border-radius: 10px;
	width: 458px;
	height: 548px;
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
    margin-top: 80px;
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
}
.g_id_signin {
	margin: 18px auto ;
	display: block;
	width: 400px;
}
</style>
</head>
<script>
  function handleCredential(response) {
    console.log("✅ 구글 로그인 성공:", response.credential);

    // 여기서 JWT 토큰을 서버로 보내거나 처리하면 됨
  }
  function parseJwt(token) {
	  const base64Url = token.split('.')[1];
	  const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
	  const jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
	    return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
	  }).join(''));

	  return JSON.parse(jsonPayload);
	}
	function handleCredential(response) {
	  const userInfo = parseJwt(response.credential);

	  fetch("googleLoginServlet", {
	    method: "POST",
	    headers: { "Content-Type": "application/json" },
	    body: JSON.stringify({
	      user_id: "google_" + userInfo.sub,
	      user_pwd: "google_login",
	      user_name: userInfo.name,
	      user_email: userInfo.email,
	      user_icon: userInfo.picture
	    })
	  })
	  .then(res => res.json())
	  .then(data => {
	    if (data.status === "ok") {
	      // 로그인 성공 → 메인 페이지로 이동
	      window.location.href = "mainScreen.jsp";
	    } else {
	      alert("구글 로그인에 실패했습니다.");
	    }
	  })
	  .catch(err => {
	    console.error("Google login error:", err);
	    alert("서버 오류가 발생했습니다.");
	  });
	}
</script>
<body>
<div class="container">
	<div class="left-half"></div>
	<div class="right-half">
		<!-- 로그인 폼 -->
		<h1 class="right-half_title">오늘, 내일</h1>
		<div class="login-box">
			<h2 class="login-box_title" >로그인</h2>
			<div class="line"></div>
			<h2 class= "login-box_text">어서와!</h2>
			<form action="loginPost" method="post">
			<input type="text"  name="user_id" placeholder="이메일" class="input-field">
			<input type="password" name="user_pwd" placeholder="비밀번호" class="input-field">
			<a href="register.jsp" class="signup-button">회원가입</a>
			<button type="submit" class="login-btn">로그인</button>
			</form>
			
			<!-- 구글로그인 버튼 -->
			
			<div id="g_id_onload"
     			 data-client_id="905257669393-cvm17lf3qkaov5bveekbdbb9ao5r1f63.apps.googleusercontent.com"
     			 data-callback="handleCredential"
     			 data-auto_prompt="false">
			</div>
			<div class="g_id_signin"
     			 data-type="standard"
    			 data-size="large"
    			 data-theme="outline"
    			 data-text="sign_in_with"
    			 data-shape="rectangular"
     			 data-logo_alignment="left"
     			 data-width="400" 
     			 ></div><!-- 구글로그인 버튼 -->
		</div><!-- 로그인 박스 -->
	</div><!-- 오른쪽 -->
</div>
</body>
</html>