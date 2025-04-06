<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <!-- 파일 업로드를 위한 enctype 추가 -->
    <script>
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function() {
                const profileImg = document.getElementById('profileImg');
                profileImg.src = reader.result;
                profileImg.style.display = 'block';
            }
            reader.readAsDataURL(event.target.files[0]);
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
	}
	
	#profileImg {
	    width: 100%;
	    height: 100%;
	    border-radius: 50%;
	    object-fit: cover;
	    display: none;
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
		    <img src="icon/아이콘_수정_1.png" alt="수정 아이콘" class="icon-edit">
		    <img src="icon/아이콘_프로필_1.png" alt="프로필 아이콘" class="icon-profile" onclick="toggleProfile()">
		</div>
		
		<label for="profileImage" class="profile-circle">
		    <img id="profileImg" src="#" alt="프로필 이미지">
		</label>
        
        <input type="file" name="profileImage" id="profileImage" onchange="previewImage(event)" style="display: none;">
        
        <form action="processForm.jsp" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="username">아이디:</label>
                <input type="text" id="username" name="username">
            </div>
            
            <div class="form-group">
                <label for="password">비밀번호:</label>
                <input type="text" id="password" name="password">
            </div>
            
            <div class="form-group">
                <label for="name">이름:</label>
                <input type="text" id="name" name="name">
            </div>
            
            <div class="form-group">
                <label for="phone">전화번호:</label>
                <input type="text" id="phone" name="phone">
            </div>
            
            <div class="form-group">
                <label for="address">주소:</label>
                <input type="text" id="address" name="address">
            </div>
            
            <button type="submit" class="submit-btn">완료</button>
        </form>
    </div>
