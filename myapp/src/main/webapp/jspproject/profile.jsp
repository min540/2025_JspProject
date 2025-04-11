<%@page import="java.util.Vector"%>
<%@page import="jspproject.UserBean" %>
<%@page import="java.beans.beancontext.BeanContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="lmgr" class="jspproject.LoginMgr"/>
<jsp:useBean id="bean" class ="jspproject.UserBean" scope = "session"/>

<jsp:setProperty property="*" name="bean"/>
<%
String user_id = (String) session.getAttribute("user_id");  // ✅ 이제 문자열로 바로 받아도 안전함
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
    const fileInput = event.target;
    if (fileInput.disabled) return;

    if (event.target.files && event.target.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const profileImg = document.getElementById('profileImg');
            profileImg.src = e.target.result;
            profileImg.style.display = 'block';
        }
        reader.readAsDataURL(event.target.files[0]);
    }
}

function uploadProfileImage(event) {
    const fileInput = document.getElementById('profileImage');
    if (!fileInput.files || fileInput.files.length === 0) return;

    const formData = new FormData();
    formData.append('profile', fileInput.files[0]);

    fetch('profileIconUpdate', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            const profileImg = document.getElementById('profileImg');
            if (profileImg) {
                profileImg.src = "img/" + data.filename;
                profileImg.style.display = 'block';
            }
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert("이미지 업로드 중 오류가 발생했습니다");
    });
}

function enableEdit() {
    document.getElementById('password').disabled = false;
    document.getElementById('name').disabled = false;
    document.getElementById('phone').disabled = false;
    document.getElementById('email').disabled = false;
    document.getElementById('success').disabled = false;
    document.getElementById('delete').disabled = false;

    const fileInput = document.getElementById('profileImage');
    fileInput.removeAttribute('disabled');

    const profileCircle = document.getElementById('profile-circle');
    profileCircle.onclick = () => {
        if (!fileInput.disabled) fileInput.click();
    };
}

function update() {
    const form = document.forms['frm'];
    const fileInput = document.getElementById('profileImage');

    if (fileInput.files && fileInput.files.length > 0) {
        const formData = new FormData();
        formData.append('profile', fileInput.files[0]);

        fetch('profileIconUpdate', {
            method: 'POST',
            body: formData
        })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'success') {
                alert("수정이 완료되었습니다.");
                form.submit();
            } else {
                alert("이미지 업로드 실패");
            }
        })
        .catch(err => {
            console.error(err);
            alert("이미지 업로드 중 오류가 발생했습니다.");
        });
    } else {
        alert("수정이 완료되었습니다.");
        form.submit();
    }
}

//유저 삭제 함수
function deleteUser() {
    // 삭제 전 사용자 확인
    if (confirm("정말로 계정을 삭제하시겠습니까?")) {
        // 폼 생성 및 제출
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = 'deleteUser'; // 서블릿 URL 매핑
        
        // 사용자 ID를 히든 필드로 추가
        const userIdField = document.createElement('input');
        userIdField.type = 'hidden';
        userIdField.name = 'user_id';
        userIdField.value = document.getElementById('username').value;
        form.appendChild(userIdField);
        
        // body에 폼 추가 후 제출
        document.body.appendChild(form);
        form.submit();
    }
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
        display: none;
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
		margin-top:25px;
	    margin-bottom: 20px;
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
	    	.delete-btn {
	    background-color: #ff0000;
	    color: white;
	    border: none;
	    border-radius: 6px;
	    padding: 10px 20px;
	    cursor: pointer;
	    margin-top: 95px;
	    margin-left:290;
	    font-size: 15px;
	    width: 30%;
	    transition: background-color 0.3s ease;
	}
	.delete-btn:hover {
	    background-color: #FA5858;
	 
	}
</style>

<div class="form-container">
    <div class="profile-icons">
        <img src="icon/아이콘_수정_1.png" alt="수정 아이콘" class="icon-edit" onclick="enableEdit()">
        <img src="icon/아이콘_프로필_1.png" alt="프로필 아이콘" class="icon-profile" onclick="toggleProfile()">
    </div>

    <form action="profileUpdate" name="frm" method="post" enctype="multipart/form-data" class="post_form">
        <input type="file" name="profile" id="profileImage" onchange="previewImage(event); uploadProfileImage(event);" style="display: none;" disabled>

        <div class="profile-circle" id="profile-circle">
            <label for="profileImage" class="profile-label">
                <img id="profileImg" src="<%=ubean.getUser_icon() != null ? "img/" + ubean.getUser_icon() : "" %>"
                    alt="프로필 이미지" style="<%=ubean.getUser_icon() != null ? "display: block" : "display: none" %>">
            </label>
        </div>

        <div class="form-group">
            <label for="username">아이디
                <input type="text" id="username" name="user_id" value="<%=ubean.getUser_id() %>" readonly>
            </label>
        </div>

        <div class="form-group">
            <label for="password">비밀번호
                <input type="text" id="password" name="user_pwd" value="<%=ubean.getUser_pwd() %>" disabled>
            </label>
        </div>

        <div class="form-group">
            <label for="name">이름
                <input type="text" id="name" name="user_name" value="<%=ubean.getUser_name()%>" disabled>
            </label>
        </div>

        <div class="form-group">
            <label for="phone">전화번호
                <input type="text" id="phone" name="user_phone" value="<%=ubean.getUser_phone()%>" disabled>
            </label>
        </div>

        <div class="form-group">
            <label for="email">이메일
                <input type="text" id="email" name="user_email" value="<%=ubean.getUser_email()%>" disabled>
            </label>
        </div>
        <input type="button" value="완료" id="success" class="submit-btn" onclick="update()" disabled>
        
        <input type="button" value="유저 삭제" id="delete" class="delete-btn" onclick="deleteUser()" disabled>
    </form>
</div>
