<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 정보 입력</title>
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
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
            font-family: Arial, sans-serif;
        }
        
        .form-container {
            width: 250px;
            background-color: #6b5b76;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
            position: relative;
        }
        
        .icons {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        
        .icon {
            width: 20px;
            height: 20px;
            color: white;
        }
        
        .profile-circle {
            width: 120px;
            height: 120px;
            background-color: #5a4c64;
            border-radius: 50%;
            margin: 0 auto 20px;
            cursor: pointer; /* 추가: 커서를 포인터로 변경 */
            position: relative; /* 위치 지정을 위해 추가 */
            overflow: hidden; /* 내부 이미지가 원 밖으로 나가지 않도록 */
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
        
        .form-group {
            margin-bottom: 10px;
        }
        
        label {
            display: block;
            color: white;
            margin-bottom: 5px;
            font-size: 14px;
        }
        
        input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid white;
            border-radius: 5px;
            background-color: #5a4c64;
            color: white;
            box-sizing: border-box;
        }
        
        .submit-btn {
            background-color: #5a4c64;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 15px;
            cursor: pointer;
            margin: 20px auto 0;
            display: block;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="icons">
            <div class="icon">
            <img src = "icon/아이콘_수정_1.png" alt = "수정 아이콘" style = "width : 40px; height: 40px; position: : relative; left:-70px; ">
            </div>
            <div class="icon">
                <img src="icon/아이콘_프로필_1.png" alt="프로필 아이콘" style="width: 50px; height: 50px; position: relative; left: -20px;">
            </div>
        </div>
        
        <!-- 원을 클릭하면 파일 선택 다이얼로그가 열리도록 label로 연결 -->
        <label for="profileImage" class="profile-circle">
            <img id="profileImg" src="#" alt="프로필 이미지" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover; display: none;">
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
</body>
</html>