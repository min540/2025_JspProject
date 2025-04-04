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
	padding-top: 70px;
	margin-bottom: 20px;/*세로*/
}
.login-box{
	background-color: #4A3C6E;
	border-radius: 10px;
	width: 458px;
	height: 668px;
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
.check-msg{
/*  margin-top: px; */ 
 color: #ffc107; 
 font-size: 10px;
 margin-left: 30px;
}
.login-btn:disabled {
	background-color: #999999;
	cursor: not-allowed;
	opacity: 0.6;
}
</style>
</head>
<script>
let isIdValid = false;
let isPhoneValid = false; 
let isPwdMatched = false;
let isEmailValid = false;

function checkId() {//중복확인
	  const userId = document.querySelector('[name="user_id"]').value;

	  if (!userId.trim()) {
	    alert("아이디를 입력해주세요.");
	    return;
	  }

	  fetch("/2025_JspProject/jspproject/idCheckServlet?user_id=" + encodeURIComponent(userId))
	    .then(res => res.text())
	    .then(result => {
	      if (result === "true") {
	        alert("사용 가능한 아이디입니다!");
	        isIdValid = true;
	      } else {
	        alert("이미 사용중인 아이디입니다.");
	        isIdValid = false;
	      }
	      updateSubmitButton();
	    });
	}
let phoneCheckTimer;
let phoneMsgTimer;
function checkPhoneRealtime(phone) {// 전화번호 실시간 중복확인
    clearTimeout(phoneCheckTimer); // 입력 중일 때 너무 많은 요청 방지
    clearTimeout(phoneMsgTimer);// 기존메세지 제거 타이머초기화

    // 딜레이 후 실행 (300ms 정도)
    phoneCheckTimer = setTimeout(() => {
        if (!phone.trim()) {
            document.getElementById("phone-check-msg").innerText = "";
            return;
        }

        fetch("/2025_JspProject/jspproject/phoneCheckServlet?user_phone=" + encodeURIComponent(phone))
            .then(res => res.text())
            .then(result => {
                const msgDiv = document.getElementById("phone-check-msg");

                if (result === "true") {
                    msgDiv.innerText = "이미 사용 중인 전화번호입니다.";
                    msgDiv.style.color = "#dc3545"; // 빨강색
                    isPhoneValid = false;
                } else {
                    msgDiv.innerText = "사용 가능한 전화번호입니다!";
                    msgDiv.style.color = "#28a745"; // 초록색
                    isPhoneValid = true;
                }
                updateSubmitButton();
                //4초 후 메세지 제거
                phoneMsgTimer = setTimeout(()=> {
                	msgDiv.innerText ="";
                }, 4000);
                
            });
    }, 300);
}
let emailCheckTimer;
let emailMsgTimer;
function checkEmail(){//이메일 중복체크 실시간
	clearTimeout(emailCheckTimer);
    clearTimeout(emailMsgTimer);
    
	const email = document.getElementById("user_email").value;
	const msgDiv = document.getElementById("email-msg");

	emailCheckTimer = setTimeout(() => {
        if (!email.trim()) {
            document.getElementById("email-msg").innerText = "";
            return;
        }
        
	  fetch("/2025_JspProject/jspproject/emailCheckServlet?user_email=" + encodeURIComponent(email))
	  .then(res => res.text())
	   .then(result => {
		   if(result.trim() === "true"){
			   msgDiv.innerText = "이미 사용 중인 이메일입니다.";
			   msgDiv.style.color = "#dc3545"; // 빨강색
			   isEmailValid = false;
		   }else{
			   msgDiv.innerText = "사용 가능한 이메일입니다!";
               msgDiv.style.color = "#28a745"; // 초록색
               isEmailValid = true;
		   }
		   updateSubmitButton();
		   emailMsgTimer = setTimeout(()=> {
           	msgDiv.innerText ="";
           }, 4000);
	   });
	}, 300);
}
let pwdMsgTimer;
function checkPwd() {
	clearTimeout(phoneMsgTimer);
	const pwd = document.getElementById("user_pwd").value;
	const confirmPwd = document.getElementById("user_pwd_confirm").value;
	const msgDiv = document.getElementById("pwd-check-msg");
	
	if(!confirmPwd){
		msgDiv.innerText = "";
		return;
	}
	
	if(pwd==confirmPwd){
		msgDiv.innerText = "비밀번호가 일치합니다.";
		msgDiv.style.color = "#28a745"; // 초록색
		 isPwdMatched = true;
	}else{
		msgDiv.innerText = "비밀번호가 일치하지 않습니다.";
		msgDiv.style.color = "#dc3545"; // 빨강색
		 isPwdMatched = false;
	}
	pwdmsgTimer = setTimeout(() => {
		msgDiv.innerText ="";
	}, 4000);
	   updateSubmitButton();
}

function  updateSubmitButton() {
	const submitBtn = document.querySelector('.login-btn');
	submitBtn.disabled = !(isIdValid && isPhoneValid && isPwdMatched && isEmailValid);
}

</script>
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
    <input type="password" name="user_pwd" id="user_pwd" oninput="checkPwd()" placeholder="비밀번호" class="input-field form-item" required>
    <input type="password" name="user_pwd_confirm" id="user_pwd_confirm" oninput="checkPwd()" placeholder="비밀번호 확인" class="input-field form-item" required>
    <div id="pwd-check-msg" class="check-msg"></div>
    <input type="text" name="user_name" placeholder="이름" class="input-field form-item" required>
    <input type="text" name="user_email" id="user_email" placeholder="이메일" class="input-field form-item" required  oninput="checkEmail(this.value)">
    <div id="email-msg" class="check-msg"></div>
    <input type="text" name="user_phone" placeholder="전화번호" class="input-field form-item" required  oninput="checkPhoneRealtime(this.value)">
    <div id="phone-check-msg" class="check-msg"></div>
    <button type="submit" class="login-btn" disabled>회원가입</button>
</form>

		</div><!-- 로그인 박스 -->
	</div><!-- 오른쪽 -->
</div>
</body>
</html>