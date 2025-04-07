<%@page import="java.util.Vector"%>
<%@page import="jspproject.UserBean" %>
<%@page import="java.beans.beancontext.BeanContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="lmgr" class="jspproject.LoginMgr"/>
<jsp:useBean id="bean" class ="jspproject.UserBean" scope = "session"/>

<jsp:setProperty property="*" name="bean"/>
<%
String user_id = (String) session.getAttribute("id");  // ✅ 이제 문자열로 바로 받아도 안전함
if (user_id == null) {
	//로그인안된 상태이기 때문에 현재의url가지고 login.jsp로 간다
	StringBuffer url = request.getRequestURL();
    response.sendRedirect("login.jsp");
}

//로그인된 사용자의 정보를 데이터베이스에서 가져오기
UserBean ubean = lmgr.getUser(user_id);
//사용자 정보가 없을 경우를 대비
if (ubean == null) {
	ubean = new UserBean();
}


    %>
    <!-- 파일 업로드를 위한 enctype 추가 -->
    <script>
  
    function previewImage(event) {
        // 파일 입력 요소의 disabled 상태 확인
        const fileInput = event.target;
        if (fileInput.disabled) {
            // disabled 상태라면 함수 실행 중단
            return;
        }

        if (event.target.files && event.target.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const profileImg = document.getElementById('profileImg');
                profileImg.src = e.target.result;
                profileImg.style.display = 'block'; // 이미지를 반드시 보이게 설정
            }
            reader.readAsDataURL(event.target.files[0]);
        }
    }
    
         function enableEdit() {
		document.getElementById('password').disabled = false;			
		document.getElementById('name').disabled = false;			
		document.getElementById('phone').disabled = false;			
		document.getElementById('email').disabled = false;		
		document.getElementById('success').disabled = false;	
		  const profileImage = document.getElementById('profileImage');
		    profileImage.disabled = false;
		
		}
         function update() {
         	alert("수정이 완료 되었습니다");
     		document.frm.submit();
         }
         window.onload = function() {
             // 모든 입력 필드 비활성화
             document.getElementById('password').disabled = true;
             document.getElementById('name').disabled = true;
             document.getElementById('phone').disabled = true;
             document.getElementById('email').disabled = true;
             document.getElementById('success').disabled = true;    
          // 프로필 이미지 입력 필드도 비활성화
             const profileImage = document.getElementById('profileImage');
             profileImage.disabled = true;
         }

         
    </script>
<style>        
	.form-container {
	    width: 420px; /* ✅ 너비 늘림 */
	    height: 100vh;
	    position: fixed;
	    left: 0;
	    top: 0;
	    background-color: rgba(29, 16, 45, 0.7);
	    border-top-right-radius: 24px;
	    border-bottom-right-radius: 24px;
	    padding: 20px 10px;
	    box-shadow: 5px 0 20px rgba(0, 0, 0, 0.5);
	    z-index: 10000;
	    overflow-y: auto;
	    display: flex;
	    flex-direction: column;
	    gap: 16px;
	}
	
	.profile-icons {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	}
	
	.icon-edit {
	    width: 60px;
	    height: 60px;
	    cursor: pointer;
	}
	
	.icon-profile {
	    width: 60px;
	    height: 60px;
	    cursor: pointer;
	}
	
.profile-circle {
        width: 250px;
        height: 250px;
        background-color: #5a4c64;
        border-radius: 50%;
        margin: 0 auto;
        cursor: pointer;
        position: relative;
        overflow: hidden;
        transition: transform 0.2s ease;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
	.profile-circle:hover {
	    transform: scale(1.05);
	}
.profile-circle:hover::before {
        content: "사진 업로드";
        position: absolute;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        font-size: 14px;
        z-index: 5;
    }
	
	#profileImg {
	    width: 100%;
	    height: 100%;
	    border-radius: 50%;
	    object-fit: cover; /* 이미지 비율 유지하면서 컨테이너에 맞춤 */
	    position: absolute; /* 절대 위치로 설정 */
	    top: 0;
	    left: 0;
	 
	}
	
	.form-group {
	    margin-bottom: 14px;
	}
	
	label {
	    display: block;
	    color: white;
	    margin-bottom: 6px;
	    font-size: 15px;
	    font-weight: 500;
	}
	
	input[type="text"] {
	    width: 100%;
	    padding: 10px;
	    border: 1px solid white;
	    border-radius: 6px;
	    background-color: #5a4c64;
	    color: white;
	    font-size: 14px;
	    box-sizing: border-box;
	}
	
	.submit-btn {
	    background-color: #6b5c87;
	    color: white;
	    border: none;
	    border-radius: 6px;
	    padding: 10px 20px;
	    cursor: pointer;
	    margin-top: 10px;
	    font-size: 15px;
	    width: 100%;
	    transition: background-color 0.3s ease;
	}
	.submit-btn:hover {
	    background-color: #836cb0;
	}
</style>


    <div class="form-container">
        <div class="profile-icons">
		    <img src="icon/아이콘_수정_1.png" alt="수정 아이콘" class="icon-edit" onclick = "enableEdit()">
		    <img src="icon/아이콘_프로필_1.png" alt="프로필 아이콘" class="icon-profile" onclick="toggleProfile()">
		</div>
		
      
        
        <!-- 같은 페이지로 폼 제출 -->
        <form action="profileUpdate"  name = "frm" method="post" enctype="multipart/form-data" class="post_form">
        <input type="file" name="profile" id="profileImage" onchange="previewImage(event)" style="display: none;">
        	
        	
			<label for="profileImage"  class="profile-label" >
			<div class="profile-circle">
    	<img id="profileImg" src="<%=ubean.getUser_icon() != null ? "img/" + ubean.getUser_icon() : "#" %>"
     	alt="프로필 이미지" style="<%=ubean.getUser_icon() != null ? "display: block" : "display: none" %>">
     	</div>
		</label>
		
       
            <div class="form-group">
                <label for="username">아이디
                <input type="text" id="username" name="user_id" value = "<%=ubean.getUser_id() %>" readonly >
                </label>
            </div>
            
            <div class="form-group">
                <label for="password">비밀번호
                <input type="text" id="password" name="user_pwd" value="<%=ubean.getUser_pwd() %>" disabled>
                </label>
            </div>
            
            <div class="form-group">
                <label for="name">이름
                <input type="text" id="name" name="user_name" value = "<%=ubean.getUser_name()%>" disabled>
                </label>
            </div>
            
            <div class="form-group">
                <label for="phone">전화번호
                <input type="text" id="phone" name="user_phone" value = "<%=ubean.getUser_phone()%>" disabled>
                </label>
            </div>
            
            <div class="form-group">
                <label for="email">이메일
                <input type="text" id="email" name="user_email" value = "<%=ubean.getUser_email()%>" disabled>
                </label>
            </div>
              <input type="button"  value="완료" id = "success"class="submit-btn" onclick="update()" disabled>
            
        </form>
    </div>