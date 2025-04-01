<!-- musicList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배경 선택</title>
 <style>
    .music-container {
	    position: absolute;
	    left: 10vw;
	    top: 10vh;
	    display: flex;
        width: 75%;
        height: 900px;
        background: #1d102d;
        color: white;
        border-radius: 15px;
    }

    .music-left {
        flex: 2;
        padding: 20px;
        overflow-y: auto;
        border-right: 2px solid #311e4f;
    }

    .music-right {
        flex: 1;
        padding: 20px;
        background-color: #2a1245;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .music-header, .music-list, .music-footer {
        margin-bottom: 15px;
    }

    .music-header {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .music-header input[type="text"] {
        flex: 1;
        padding: 8px;
        border-radius: 5px;
        border: none;
    }

    .music-list-item {
        background-color: #3c1e5c;
        margin-bottom: 8px;
        padding: 10px;
        border-radius: 8px;
        display: flex;
        align-items: center;
    }

    .music-list-item input[type="checkbox"] {
        margin-right: 10px;
    }

    .music-preview img {
        width: 100%;
        border-radius: 10px;
        margin-bottom: 10px;
    }

    .music-controls {
        display: flex;
        justify-content: center;
        gap: 20px;
        font-size: 24px;
        margin: 10px 0;
    }

    .music-description textarea {
        width: 100%;
        height: 100px;
        resize: none;
        border-radius: 10px;
        padding: 10px;
        border: none;
    }

    .music-right-buttons {
        display: flex;
        justify-content: space-between;
    }

    .music-right-buttons button {
        flex: 1;
        margin: 5px;
        padding: 10px;
        border-radius: 8px;
        border: none;
        font-weight: bold;
        cursor: pointer;
    }

    .btn-purple {
        background-color: #7b2cbf;
        color: white;
    }

    .btn-dark {
        background-color: #444;
        color: white;
    }

    .btn-red {
        background-color: #b00020;
        color: white;
    }
</style>
        
</head>

<body>
<div class="music-container">
    <!-- 왼쪽 영역 -->
    <div class="music-left">
        <div class="music-header">
            <input type="checkbox" id="selectAll"> 전체 선택
            <button>↓</button>
            <button>↑</button>
            <input type="text" placeholder="음악 제목 검색" />
            <button>🔍</button>
        </div>

        <div class="music-list">
            <div class="music-list-item">
                <input type="checkbox" />
                <span>음악 제목 1</span>
            </div>
            <div class="music-list-item">
                <input type="checkbox" />
                <span>음악 제목 2</span>
            </div>
            <!-- 반복 -->
        </div>

        <div class="music-footer">
            <button class="btn-dark">추가</button>
            <button class="btn-red">삭제</button>
        </div>
    </div>

    <!-- 오른쪽 영역 -->
    <div class="music-right">
        <div class="music-preview">
            <img src="musicImg/sample.gif" alt="음악 이미지">
            <h2 style="text-align:center;">음악 제목</h2>
        </div>

        <div class="music-controls">
            <span>⏮️</span>
            <span>▶️</span>
            <span>⏭️</span>
        </div>

        <div class="music-description">
            <textarea>음악 설명</textarea>
        </div>

        <div class="music-right-buttons">
            <button class="btn-purple">음악 취소</button>
            <button class="btn-dark">수정</button>
            <button class="btn-purple">적용</button>
        </div>
    </div>
</div>

</body>
</html>
