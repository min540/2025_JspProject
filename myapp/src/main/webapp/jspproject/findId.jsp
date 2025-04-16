<!-- findId.jsp -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String foundUserId = (String) request.getAttribute("foundUserId");
String error = request.getParameter("error");
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

a {
	text-decoration: none;
	color: white;
}

body, html {
	margin: 0;
	padding: 0;
	height: 100%;
	background-color: #372358;
	font-family: 'PFStarDust', sans-serif;
}

.container {
	display: flex;
	height: 100vh;
}

.left-half {
	flex: 1;
	background-image: url('images/loginimg.jpg');
	background-size: cover;
	background-position: left;
}

.right-half {
	flex: 1;
	display: flex;
	flex-direction: column;
	justify-content: center; /*가로*/
	align-items: center;
	height: 100%;
	text-align: center;
}

.right-half_title {
	margin-bottom: 10px; /*세로*/
	text-decoration: none;
}

.find-box {
	background-color: #4A3C6E;
	border-radius: 10px;
	width: 458px;
	height: 460px;
	margin-top: 20px; /*세로*/
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.find-box_title {
	display: flex;
	justify-content: center;
	color: white;
	margin: 50px;
}

.line {
	width: 100%;
	height: 1px;
	background-color: white;
	margin-bottom: 60px;
}

.login-box_text {
	color: white;
	margin-left: 30px;
}

.input-field1 {
	display: block;
	width: 400px;
	height: 50px;
	padding: 10px;
	margin: 18px auto;
	border-radius: 10px;
	border: none;
	margin-bottom: 10px;
}

.input-field2 {
	display: block;
	width: 400px;
	height: 50px;
	padding: 10px;
	margin: 18px auto;
	border-radius: 10px;
	border: none;
	margin-bottom: 40px;
}

.signup-button {
	display: block;
	text-align: right;
	font-size: 16px;
	color: white;
	margin: 10px auto 0;
	width: 80%;
	text-decoration: none;
}

.find-btn {
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
	margin: 18px auto;
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
/* 모달 기본 스타일 */
.modal {
  display: none; /* 초기에는 숨김 */
  position: fixed;
  z-index: 100; /* 다른 컨텐츠보다 위에 표시 */
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0,0,0,0.4); /* 반투명 검정 배경 */
}
/* 모달 내용 스타일 */
.modal-content {
  background-color: #fff;
  margin: 15% auto; /* 화면 중앙에 표시 */
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
  max-width: 400px;
  text-align: center;
  border-radius: 10px;
  margin-top: 20%
}
/* 닫기 버튼 스타일 */
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}
.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}
</style>
</head>
<script>
window.onload = function() {
	  <% if(foundUserId != null) { %>
	    // 모달 요소 가져오기
	    var modal = document.getElementById('idModal');
	    var span = document.getElementsByClassName('close')[0];
	    
	    // 아이디 값을 모달 내에 표시
	    document.getElementById('userIdDisplay').textContent = "<%= foundUserId %>";
	    
	    // 모달 보이도록 설정
	    modal.style.display = "block";
	    
	    // 닫기 버튼 클릭 시 모달 닫기
	    span.onclick = function() {
	      modal.style.display = "none";
	    }
	    
	    // 모달 영역 외부 클릭 시 닫기
	    window.onclick = function(event) {
	      if (event.target == modal) {
	          modal.style.display = "none";
	      }
	    }
	  <% } %>
	};
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
</script>

<body>
	<!-- 모달 팝업 -->
	<div id="idModal" class="modal">
	  <div class="modal-content">
	    <span class="close">&times;</span>
	    <p>찾으시는 아이디는 : <span id="userIdDisplay"></span></p>
	  </div>
	</div>
	<div class="container">
		<div class="left-half"></div>
		<div class="right-half">
			<!-- 아이디 찾기 폼 -->
			<h1 class="right-half_title">
				<a href="login.jsp">오늘, 내일</a>
			</h1>
			<div class="find-box">
				<h2 class="find-box_title">아이디 찾기</h2>
				<div class="line"></div>
				<h2 class="login-box_text"></h2>
				<form action="findPost" method="post">
					<input type="text" name="user_name" placeholder="이름"
						class="input-field1"> <input type="text" name="user_phone"
						placeholder="전화번호" class="input-field2">
					<%
					if ("find_failed".equals(error)) {
					%>
					<div
						style="width: 400px; margin: 0 auto; color: red; text-align: center; padding: 5px; border-radius: 10px; position: absolute; margin-top: -35px; margin-left: -70px;">
						등록되지 않은 회원 정보입니다.</div>
					<%
					}
					%>
					<a href="findPwd.jsp" class="findpw-button">비밀번호 찾기</a> <a
						href="register.jsp" class="signup-button">회원가입</a>
					<button type="submit" class="find-btn">아이디 찾기</button>
				</form>
			</div>
			<!-- 로그인 박스 -->
		</div>
		<!-- 오른쪽 -->
	</div>
</body>
</html>