<!-- register.jsp -->
<%@page import="jspproject.LoginMgr"%>
<%@ page  contentType="text/html; charset=UTF-8"%>

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
	height: 700px;
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
    margin-top: 60px;
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
  margin-bottom: 35px;
}
.check-msg{
  font-size: 12px;
  margin-left: 35px;
  margin-top: -24px;
  position: absolute;
}
.login-btn:disabled {
	background-color: #999999;
	cursor: not-allowed;
	opacity: 0.6;
}
/* ----- 모달 스타일 추가 ----- */
    .modal {
      display: none;
      position: fixed;
      z-index: 100;
      left: 0; top: 0;
      width: 100%; height: 100%;
      background-color: rgba(0,0,0,0.4);
    }
    .modal-content {
      background-color: #fff;
      margin: 15% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 80%;
      max-width: 400px;
      border-radius: 10px;
      text-align: center;
    }
    .close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }
    .close:hover,
    .close:focus {
      color: black;
      cursor: pointer;
    }
</style>
</head>
<script>
let isIdValid = false;
let isPhoneValid = false; 
let isPwdMatched = false;
let isEmailValid = false;

function checkId() {	//중복확인
	  const userId = document.querySelector('[name="user_id"]').value;

	  if (!userId.trim()) {
	    alert("아이디를 입력해주세요.");
	    return;
	  }

	  fetch("idCheckServlet?user_id=" + encodeURIComponent(userId))
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
function checkPhoneRealtime(phone){ // 전화번호 실시간 중복확인
    clearTimeout(phoneCheckTimer);
    clearTimeout(phoneMsgTimer);

    phoneCheckTimer = setTimeout(() => {
        if (!phone.trim()) {
            document.getElementById("phone-check-msg").innerText = "";
            return;
        }

        fetch("phoneCheckServlet?user_phone=" + encodeURIComponent(phone))
            .then(res => res.text())
            .then(result => {
                const msgDiv = document.getElementById("phone-check-msg");

                if (result === "true") {
                    msgDiv.innerText = "이미 사용 중인 전화번호입니다.";
                    msgDiv.style.color = "#dc3545"; // 빨강색
                    isPhoneValid = false;
                    // 오류 메시지: 타이머 없이 그대로 표시
                } else {
                    msgDiv.innerText = "사용 가능한 전화번호입니다!";
                    msgDiv.style.color = "#28a745"; // 초록색
                    isPhoneValid = true;
                    // 성공 메시지: 4초 후 자동 제거
                    phoneMsgTimer = setTimeout(() => {
                        msgDiv.innerText = "";
                    }, 4000);
                }
                updateSubmitButton();
            });
    }, 300);
}
let emailCheckTimer;
let emailMsgTimer;
function checkEmail(){ // 이메일 중복체크 실시간
    clearTimeout(emailCheckTimer);
    clearTimeout(emailMsgTimer);
    
    const email = document.getElementById("user_email").value;
    const msgDiv = document.getElementById("email-msg");

    emailCheckTimer = setTimeout(() => {
        if (!email.trim()) {
            msgDiv.innerText = "";
            return;
        }
        
        fetch("emailCheckServlet?user_email=" + encodeURIComponent(email))
        .then(res => res.text())
        .then(result => {
            if(result.trim() === "true"){
                msgDiv.innerText = "이미 사용 중인 이메일입니다.";
                msgDiv.style.color = "#dc3545"; // 빨강색
                // 이메일 중복이면 인증 진행 불가
            } else {
                msgDiv.innerText = "사용 가능한 이메일입니다!";
                msgDiv.style.color = "#28a745"; // 초록색
                // 여기서 isEmailValid를 true로 설정하지 않음.
                // 실제 인증 여부는 모달에서 인증 코드 검증 후 처리.
                emailMsgTimer = setTimeout(() => {
                    msgDiv.innerText = "";
                }, 4000);
            }
            updateSubmitButton();
        });
    }, 300);
}

let pwdMsgTimer;
function checkPwd() {
    clearTimeout(pwdMsgTimer);
    const pwd = document.getElementById("user_pwd").value;
    const confirmPwd = document.getElementById("user_pwd_confirm").value;
    const msgDiv = document.getElementById("pwd-check-msg");
    
    if (!confirmPwd) {
        msgDiv.innerText = "";
        updateSubmitButton();
        return;
    }
    
    if (pwd === confirmPwd) {
        msgDiv.innerText = "비밀번호가 일치합니다.";
        msgDiv.style.color = "#28a745"; // 초록색
        isPwdMatched = true;
        // 성공 메시지는 4초 후 자동 제거
        pwdMsgTimer = setTimeout(() => {
            msgDiv.innerText = "";
        }, 4000);
    } else {
        msgDiv.innerText = "비밀번호가 일치하지 않습니다.";
        msgDiv.style.color = "#dc3545"; // 빨강색
        isPwdMatched = false;
        // 오류 메시지는 타이머 없이 표시
    }
    updateSubmitButton();
}


function updateSubmitButton() {
    const submitBtn = document.querySelector('.login-btn');
    submitBtn.disabled = !(isIdValid && isPhoneValid && isPwdMatched && isEmailValid);
}

//전화번호 입력란 자동 (-) 생성
document.addEventListener("DOMContentLoaded", function() {
	// 'user_phone' 이름을 가진 input 요소를 선택
	const phoneField = document.querySelector('input[name="user_phone"]');
	phoneField.addEventListener("input", function() {
	  // 숫자 이외의 문자를 모두 제거합니다.
	  let input = this.value.replace(/\D/g, "");
	    
	  // 입력 값이 "010"으로 시작할 경우에만 포맷 적용
	  if (input.startsWith("010")) {
	    if (input.length <= 3) {
	      // '010'까지 입력된 경우 그대로 표시
	      this.value = input;
	    } else if (input.length <= 7) {
	      // 010 입력 후 4자리 미만이면 "010-" 후 나머지 숫자 추가
	      this.value = input.substring(0, 3) + "-" + input.substring(3);
	    } else if (input.length <= 11) {
	      // 010 입력 후 4자리 이상이면 "010-XXXX-XXXX" 형태
	      this.value = input.substring(0, 3) + "-" + input.substring(3, 7) + "-" + input.substring(7);
	    } else {
	      // 최대 11자리까지만 허용 (010-XXXX-XXXX)
	      this.value = input.substring(0, 3) + "-" + input.substring(3, 7) + "-" + input.substring(7, 11);
	    }
	  } else {
	    // 010이 아닐 경우엔 그냥 숫자만 출력하거나, 추가 포맷팅을 적용할 수 있습니다.
	    this.value = input;
	  }
 	});
});

<!-- 자바스크립트: 이메일 인증/모달 처리 -->
//이메일 인증 버튼 클릭 시: 숨겨진 폼의 user_email 값 설정 후, EmailVerificationServlet 호출 후 모달 띄우기
function sendEmailVerification() {
  var email = document.getElementById("user_email").value;
  if (!email.trim()){
    alert("이메일 주소를 입력해주세요.");
    return;
  }
  // 숨겨진 인풋에 이메일 값 설정
  document.getElementById("hiddenUserEmail").value = email;
  // 숨겨진 폼을 제출: 이 때 페이지 이동 없이 hiddenFrame에 결과가 로드됩니다.
  document.getElementById("emailVerificationForm").submit();
  // 모달 창을 표시하여, 사용자가 이메일로 받은 인증 코드를 입력하도록 합니다.
  document.getElementById("verificationModal").style.display = "block";
}

// 모달 닫기 버튼 처리
document.addEventListener("DOMContentLoaded", function() {
  var closeBtn = document.getElementsByClassName("modal-close")[0];
  if(closeBtn) {
    closeBtn.onclick = function() {
      document.getElementById("verificationModal").style.display = "none";
    }
  }
});

// 이 함수는 VerifyCodeServlet에서 호출되어, 인증 결과에 따라 부모 창의 상태를 업데이트합니다.
function verifyCallback(success) {
  var msgElem = document.getElementById("verificationResultMsg");
  if(success){
      msgElem.textContent = "이메일 인증이 완료되었습니다!";
      msgElem.style.color = "#28a745";
      isEmailValid = true;
      updateSubmitButton();
      setTimeout(function(){
          document.getElementById("verificationModal").style.display = "none";
          document.getElementById("user_email").readOnly = true;
      },2000);
  } else {
      msgElem.textContent = "인증 코드가 올바르지 않습니다. 다시 시도하세요.";
      msgElem.style.color = "#dc3545";
  }
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
			<h3 class= "login-box_text"></h3>
			<div class="line"></div>
			
<form action="userPost" method="post" enctype="multipart/form-data">
    <div class="input-row form-item">
    <input type="text" name="user_id" placeholder="아이디" class="input-field " required  style="width: 290px;" autocomplete="username" value="<%= request.getParameter("user_id") != null ? request.getParameter("user_id") : "" %>">
    <button type="button" onclick="checkId()" class="check-btn" style="width: 100px; height: 50px; font-size: 14px;">중복확인</button>
    </div>
    <input type="password" name="user_pwd" id="user_pwd" oninput="checkPwd()" placeholder="비밀번호" class="input-field form-item" required autocomplete="new-password">
    <input type="password" name="user_pwd_confirm" id="user_pwd_confirm" oninput="checkPwd()" placeholder="비밀번호 확인" class="input-field form-item" required autocomplete="new-password">
    <div id="pwd-check-msg" class="check-msg"></div>
    <input type="text" name="user_name" placeholder="이름" class="input-field form-item" required>
    <div class="input-row form-item">
    <input type="email" name="user_email" id="user_email" placeholder="이메일" class="input-field" required style="width: 290px;" autocomplete="email" oninput="checkEmail(this.value)">
    <button type="button" onclick="sendEmailVerification()" class="check-btn" style="width: 100px; height: 50px; font-size: 14px;">이메일 인증</button>
    </div>
    <div id="email-msg" class="check-msg"></div>
    <input type="text" name="user_phone" placeholder="전화번호" class="input-field form-item" required  oninput="checkPhoneRealtime(this.value)">
    <div id="phone-check-msg" class="check-msg"></div>
    <button type="submit" class="login-btn" disabled>회원가입</button>
</form>
		</div><!-- 로그인 박스 -->
	</div><!-- 오른쪽 -->
</div>
	<!-- 이메일 인증용 숨겨진 폼 및 iframe -->
	<form id="emailVerificationForm" action="<%=request.getContextPath()%>/jspproject/EmailVerificationServlet" method="post" target="hiddenFrame" style="display:none;">
	  <input type="hidden" name="user_email" id="hiddenUserEmail">
	</form>
	<iframe name="hiddenFrame" style="display:none;"></iframe>
	<!-- 인증 코드 입력 모달 -->
	  <div id="verificationModal" class="modal">
	    <div class="modal-content">
	      <span class="close modal-close">&times;</span>
	      <h3>이메일로 발송된 인증 코드를 입력하세요</h3>
	      <form id="verifyForm" action="<%=request.getContextPath()%>/jspproject/VerifyCodeServlet" method="post" target="hiddenFrame">
	        <input type="text" name="code" id="emailVerificationCode" placeholder="인증 코드 입력" style="width:80%; padding:10px; margin-top:10px;">
	        <button type="submit" style="margin-top:15px; padding:10px 20px;">코드 확인</button>
	      </form>
	      <p id="verificationResultMsg" style="margin-top:10px;"></p>
	    </div>
	  </div>
</body>
</html>