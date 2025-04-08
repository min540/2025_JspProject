<!-- Background.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

 <style>
    .background-container {
    position: absolute;
    left: 18vw;
    top: 9.5vh;
    display: flex;
    width: 70%;
    height: 74.5vh;
    background-color: rgba(29, 16, 45, 0.7); /* 기존 #1d102d = rgb(29,16,45) */
    color: white;
    border-radius: 15px;
    box-shadow: 0 0 20px rgba(255,255,255,0.4);
	}

	.background-tab {
    display: flex;
    gap: 10px;
    padding: 5px 10px;
    background-color: transparent;
    margin-bottom: 10px;
	}
	
	.tab-btn {
	    background: none;
	    border: none;
	    color: #fff;
	    padding: 5px 12px;
	    cursor: pointer;
	    margin-bottom: 10px;
	    transition: 0.2s;
	    font-family: 'PFStarDust', sans-serif;
    	font-weight: bold;
   	 	font-size: 1vw;
	}
	
	.tab-btn.active {
	    font-weight: bold;
	    border-bottom: 2px solid white;
	}

    .background-header, .background-list{
        margin-bottom: 15px;
    }

    .background-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #555;
    padding-bottom: 8px;
    font-family: 'PFStarDust', sans-serif;
    font-weight: bold;
   	font-size: 1vw;
	}
	
	.background-search {
    padding: 10px 14px;
    font-size: 15px;
    width: 300px;
    height: 37px; /* 👈 높이를 명시적으로 지정 */
    border: none;
    border-radius: 6px;
    background-color: #000;
    color: white;
    box-shadow: 0 0 8px rgba(123, 44, 191, 0.6);
    outline: none;
    transition: 0.2s ease;
    box-sizing: border-box; /* padding 포함한 크기 계산 */
    margin-top: 2px;
	}

	.background-search::placeholder {
    color: rgba(255, 255, 255, 0.5);
	}

    
    /* 왼쪽 영역 고정 */
	.background-left {
    flex: 8;
    padding: 20px;
    display: flex; /* 이거 꼭 추가 */
    flex-direction: column;
    border-right: 2px solid #311e4f;
    overflow: hidden; /* ← 중요: 전체 스크롤 막기 */
	}
	
	/* 오른쪽 요소 오른쪽 끝으로 밀기 */
	.header-right {
	    display: flex;
	    align-items: center;
	    gap: 10px;
	    margin-left: auto
	    }
	
	.background-list {
	    display: grid;
	    grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); /* ← 이미지 크기 맞게 칸 자동 계산 */
	    gap: 1px 2px;               /* 이미지 간 간격 */
	    max-height: none;        /* 🔥 높이 제한 해제 */
	    overflow-y: auto;        /* 스크롤 가능 (필요 시) */
	    padding-right: 10px;     /* 스크롤바 공간 여유 */
	}
	
	/* 하단 버튼 박스 */
	.background-footer {
	    display: flex;
	    margin-top: 10px;
	    justify-content: space-between; /* 양쪽 끝으로 배치 */
	}
	
	@font-face {
	    font-family: 'PFStarDust';
	    src: url('fonts/PFStarDust-Bold.ttf') format('truetype');
	    font-weight: bold;
	    font-style: normal;
	}
	
	.background-footer button {
	 	width: 15%;
        margin: 5px;
        padding: 10px;
        border-radius: 8px;
        border: none;
        cursor: pointer;
        font-family: 'PFStarDust', sans-serif;
    	font-weight: bold;
   	 	font-size: 1vw;
    }
	
    .background-list-item {
	    position: relative;
	    text-align: center;
	}
	
	.delete-icon {
	    position: absolute;
	    top: 5px;
	    right: 10px;
	    width: 20px;
	    height: 20px;
	    opacity: 0;
	    transition: opacity 0.2s ease;
	    cursor: pointer;
	    z-index: 2;
	    background-color:transparent;
	}

	/* 마우스 오버 시 아이콘 보이게 */
	.background-list-item:hover .delete-icon {
	    opacity: 1;
	}

    .background-list-item input[type="checkbox"] {
	     position: absolute;
	    top: 5px;
	    left: 5px;
	    z-index: 1;
	}
	
	/* 체크된 상태 */
	.background-list-item input[type="checkbox"]:checked {
	    background-color: black;       /* 체크 시 검정색 채우기 */
	    border-color: white;
	}
	
	/* 체크된 상태에 체크 모양 (✓ 표시용) */
	.background-list-item input[type="checkbox"]:checked::after {
	    content: '✓';
	    color: white;
	    font-size: 11px;
	    font-weight: bold;
	    position: absolute;
	    top: 50%;
   	 	left: 50%;
    	transform: translate(-45%, -55%); /* 👈 수직 위치 살짝 위로 */
	}
	
	.background-list::-webkit-scrollbar {
	    width: 10px; /* 스크롤바 너비 */
	}
	
	.background-list::-webkit-scrollbar-track {
	    background: transparent; /* 트랙은 안 보이게 */
	}
	
	.background-list::-webkit-scrollbar-thumb {
	    background-color: white;  /* 스크롤바 색상 */
	    border-radius: 10px;
	    border: 2px solid transparent;
	    background-clip: content-box; /* 부드러운 느낌 */
	}
	
	.background-list::-webkit-scrollbar-button {
	    display: none; /* 🔥 위아래 화살표 제거 */
	}
	
	.background-image-button {
    border: none;
    background: none;
    padding: 0;
    cursor: pointer;
    border-radius: 8px;
    overflow: hidden;
    display: inline-block;
    transition: transform 0.2s ease;
}

.background-image-button:hover {
    transform: scale(1.03); /* 살짝 확대 효과 */
}

.background-image-button img {
    width: 150px;
    height: 150px;
    object-fit: cover;
    border-radius: 8px;
    display: block;
}
	
	
	/* 삭제 아이콘 */
	.background-list-item .iconPlusPlay {
	    position: absolute;
	    top: 8px;
	    left: 96%;
	    width: 25px;
	    height: 25px;
	    opacity: 0;
	    transition: opacity 0.2s ease;
	    cursor: pointer;
	    z-index: 2;
	}
	
	/* 마우스 오버 시 나타남 */
	.background-list-item:hover .iconPlusPlay {
	    opacity: 1;
	}
	
	.background-right {
	 margin-left: auto; /* 🔥 왼쪽 공간을 밀어서 오른쪽으로 이동 */
    justify-content: flex-end;
   	 	position: relative; /* 기준점 잡아줌 */
        flex: 3;
        padding: 10px;
        background-color: rgba(42, 18, 69, 0.5);
        display: flex;
    	border-top-right-radius: 15px;
    	border-bottom-right-radius: 15px;
        flex-direction: column;
        justify-content: space-between;
    }

	.backgroundImg {
	    width: 85%;           /* 부모 너비 꽉 채움 */
	    height: 270px;         /* 원하는 고정 높이 지정 */
	    object-fit: cover;     /* 이미지 비율 유지하며 꽉 채우고 넘치는 부분은 잘라냄 */
	    border-radius: 10px;   /* 둥근 테두리 유지 (선택 사항) */
	    box-shadow: 0 0 12px rgba(123, 44, 191, 0.6);
	}

    .background-controls {
        display: flex;
        justify-content: center;
        gap: 20px;
        font-size: 24px;
    }

    .background-description textarea {
    width: 100%;
    height: 200px;
    resize: none;
    border-radius: 10px;
    border: none;
    align-items: center;         /* 세로 가운데 */
    justify-content: center;     /* 가로 가운데 (텍스트 기준) */
    padding: 0;
    text-align: center;
    line-height: 100px;          /* 높이와 같게 맞춰서 가운데처럼 보이게 함 */

    /* ✅ 다크 스타일 추가 */
    background-color: #2e2e2e;   /* 짙은 회색 */
    color: white;                /* 흰 글자 */
    font-size: 14px;
    font-family: 'PFStarDust', sans-serif;
    box-shadow: 0 0 12px rgba(123, 44, 191, 0.4);  /* 살짝 보라빛 glow */
	}

    .background-cancel-button {
    display: flex;
    justify-content: center;
    margin-bottom: 12px;
	}
	
	.background-cancel-button button {
	    width: 80%;
	    height:40px;
	    padding: 12px;
	    border-radius: 8px;
	    border: none;
	    font-weight: bold;
	    font-size: 0.7vw;
	    cursor: pointer;
	    background-color: #7b2cbf;
	    color: white;
	    box-shadow: 0 0 8px rgba(123, 44, 191, 0.4);
	}
	
	/* 기존 버튼 영역 아래 좌우 배치 */
	.background-right-buttons {
	    display: flex;
	    justify-content: space-between;
	}
	
	.background-right-buttons button {
	    width: 30%;
	    height:40px;
	    padding: 5px;
	    border-radius: 8px;
	    border: 2px solid white;
	    background: none;
	    color: white;
	    font-weight: bold;
	    font-size: 0.9vw;
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
    
    .iconbackground2 {
	    width: 2.5vw;
	    height: 2.5vw;
	    cursor: pointer;
    }
    
    .iconbackgroundList {
    width: 2vw;
	height: 2vw;
	cursor: pointer;
	}
	
	/* 검색창 크기 조절 */
	.background-search {
	    padding: 4px 8px;
	    font-size: 13px;
	    border-radius: 4px;
	    border: none;
	}
	
	/* 오른쪽 상단 고정 */
	.preview-icons {
	    position: absolute;
	    top: 12px;
	    right: 12px;
	    display: flex;
	    gap: 8px;
	}
	
	.background-preview {
    padding-top: 60px; /* 👈 아이콘 높이만큼 위에 여유 공간 줌 */
    text-align: center;
	}
	
	.background-preview h2 {
    margin-top: 5px;     /* 줄이거나 0으로 설정 가능 */
    margin-bottom: -3px;
    font-size: 1.1vw;    /* 사이즈도 적당히 */
	}
	
	#backgroundPlayListWrapper {
	    display: none;
	}
	
	#backgroundPlayListAddWrapper {
	    display: none;
	}
}
	
</style>

<div class="background-container">
    <!-- 왼쪽 영역 -->
    <div class="background-left">
    	<!-- 🎵 음악 목록 / 재생 목록 탭 -->
		<div class="background-tab">
	    	<button class="tab-btn active">배경화면</button>
	    	<button class="tab-btn" onclick="switchToPlayList()">타이머</button>
		</div>
    
        <div class="background-header">
		
		    <!-- 오른쪽: 정렬/검색 -->
		    <div class="header-right">
		        <img class="iconbackgroundList" src="icon/아이콘_글자순_1.png" alt="글자 순 정렬" >
		        <input class="background-search" type="text" placeholder="배경 제목 검색" />
		        <img id="searchButton" class="iconbackgroundList" src="icon/아이콘_검색_1.png" alt="검색" >
		    </div>
		</div>

		<div class="background-list" id="backgroundList">
		<% 
		    // 정확한 파일 이름 배열로 처리
		    String[] gifFiles = {
		        "tema1.gif", "tema2.gif", "tema3.gif", "tema4.gif",
		        "tema6.gif", "tema7.gif","tema8.gif",
		        "tema9.gif","tema10.gif","tema11.gif","tema12.gif",
		        "tema13.gif","tema14.gif","tema15.gif","tema16.gif",
		        "tema17.gif","tema18.gif","tema19.gif","tema20.gif"
		    };
		
		    for (int i = 0; i < gifFiles.length; i++) {
		%>
		    <div class="background-list-item">
		        <button class="background-image-button" onclick="selectBackground('<%= gifFiles[i] %>')">
			<img src="<%= request.getContextPath() %>/jspproject/mplistImg/<%= gifFiles[i] %>" 
			     alt="<%= gifFiles[i] %>" />

    </button>

		

		    <!-- 🗑 삭제 버튼 - 이미지 안에 오른쪽 위에 겹치도록 배치 -->
		    <img class="delete-icon" 
		         src="<%= request.getContextPath() %>/jspproject/icon/아이콘_삭제_1.png" 
		         alt="삭제" 
		         onclick="deleteImage(this)" />

		    </div>
		<% } %>
</div>

        <div class="background-footer">
            <button class="btn-purple" onclick="addbackgroundItem()" >업로드</button>
        </div>
    </div>

    <!-- 오른쪽 영역 -->
    <div class="background-right">
    	<div class="preview-icons">
    		<img class="iconbackgroundList" src="icon/아이콘_수정_1.png" alt="수정" >
    		<img class="iconbackgroundList" src="icon/아이콘_삭제_1.png" alt="삭제">
		</div>
		
        <div class="background-preview">
            <img class = "backgroundImg" src="backgroundImg/background1.gif" alt="배경 이미지">
             <input id="backgroundTitleInput" type="text" value="배경 제목" style="text-align:center; 
             font-size:1.1vw; margin-top:5px; background:none; border:none; color:white; font-family:'PFStarDust', sans-serif;">
        </div>

        <div class="background-description">
            <textarea>배경 설명</textarea>
        </div>

        <!-- 가운데 위 버튼 -->
		<div class="background-cancel-button">
		    <button class="btn-purple">배경 취소</button>
		</div>
		
		<!-- 아래 좌우 버튼 -->
		<div class="background-right-buttons">
		    <button class="btn-dark" onclick="saveDescription()">수정</button>
		    <button class="btn-purple">적용</button>
		</div>

    </div>
</div>

<input type="file" id="backgroundFileInput" accept="image/*" style="display: none;" />

<script>
let backgroundDescriptions = {};

function saveDescription() {
    const titleInput = document.getElementById("backgroundTitleInput");
    const newTitle = titleInput.value.trim();
    const fileName = document.querySelector(".backgroundImg").src.split('/').pop();
    const description = document.querySelector(".background-description textarea").value;

    if (!fileName) return;

    // 저장
    backgroundDescriptions[fileName] = {
        title: newTitle,
        description: description
    };

    // 리스트업데이트
    const allImages = document.querySelectorAll(".background-list-item img");

    allImages.forEach(img => {
        const src = img.getAttribute("src");
        if (src.includes(fileName)) {
            img.setAttribute("alt", newTitle); 
        }
    });

    alert("제목과 설명이 저장되었습니다.");
}

function deleteImage(el) {
    const item = el.closest('.background-list-item');
    if (confirm("정말 삭제하시겠습니까?")) {
        item.remove();
    }
}

function addbackgroundItem() {
    document.getElementById("backgroundFileInput").click();
}

document.addEventListener("DOMContentLoaded", function () {
    const deleteButton = document.querySelector(".delete-selected");
    const searchInput = document.querySelector(".background-search");
    const searchButton = document.getElementById("searchButton");

    //  입력 중 부분 검색 
    searchInput.addEventListener("input", function () {
        const keyword = this.value.toLowerCase();
        const items = document.querySelectorAll(".background-list-item");
        items.forEach(item => {
            const img = item.querySelector("img");
            const title = img.getAttribute("alt").toLowerCase();
            item.style.display = title.includes(keyword) ? "block" : "none";
        });
    });

    //  정확히 일치하는 제목만 표시
    searchButton.addEventListener("click", function () {
        const keyword = searchInput.value.trim().toLowerCase();
        const items = document.querySelectorAll(".background-list-item");

        items.forEach(item => {
            const img = item.querySelector("img");
            const title = img.getAttribute("alt").toLowerCase();

            if (title === keyword || title === `${keyword}.gif`) {
                item.style.display = "block";
            } else {
                item.style.display = "none";
            }
        });
    });
});

function selectBackground(fileName) {
    const previewImg = document.querySelector(".backgroundImg");
    const titleInput = document.getElementById("backgroundTitleInput");
    const textarea = document.querySelector(".background-description textarea");
    const contextPath = "<%= request.getContextPath() %>";
    const fullPath = contextPath + "/jspproject/mplistImg/" + fileName;

    previewImg.src = fullPath;

    // 저장된 제목/설명 불러오기
    if (backgroundDescriptions[fileName]) {
        titleInput.value = backgroundDescriptions[fileName].title || fileName;
        textarea.value = backgroundDescriptions[fileName].description || "";
    } else {
        titleInput.value = fileName;
        textarea.value = "";
    }
}
	let backgroundDescriptions = {};
	
	function saveDescription() {
	    const titleInput = document.getElementById("backgroundTitleInput");
	    const fileName = document.querySelector(".backgroundImg").src.split('/').pop(); // 이미지 파일명
	    const description = document.querySelector(".background-description textarea").value;
	
	    if (fileName) {
	        backgroundDescriptions[fileName] = {
	            title: titleInput.value,
	            description: description
	        };
	        alert("제목과 설명이 저장되었습니다.");
	    }
	}
	
	function deleteImage(el) {
	    const item = el.closest('.background-list-item');
	    if (confirm("정말 삭제하시겠습니까?")) {
	        item.remove();
	    }
	}
	
	function addbackgroundItem() {
	    document.getElementById("backgroundFileInput").click();
	}
	
	document.addEventListener("DOMContentLoaded", function () {
	    const deleteButton = document.querySelector(".delete-selected");
	    const searchInput = document.querySelector(".background-search");
	    const searchButton = document.getElementById("searchButton");
	
	    //  입력 중 부분 검색 
	    searchInput.addEventListener("input", function () {
	        const keyword = this.value.toLowerCase();
	        const items = document.querySelectorAll(".background-list-item");
	        items.forEach(item => {
	            const img = item.querySelector("img");
	            const title = img.getAttribute("alt").toLowerCase();
	            item.style.display = title.includes(keyword) ? "block" : "none";
	        });
	    });
	
	    //  정확히 일치하는 제목만 표시
	    searchButton.addEventListener("click", function () {
	        const keyword = searchInput.value.trim().toLowerCase();
	        const items = document.querySelectorAll(".background-list-item");
	
	        items.forEach(item => {
	            const img = item.querySelector("img");
	            const title = img.getAttribute("alt").toLowerCase();
	
	            if (title === keyword || title === `${keyword}.gif`) {
	                item.style.display = "block";
	            } else {
	                item.style.display = "none";
	            }
	        });
	    });
	});
	
	function selectBackground(fileName) {
	    const previewImg = document.querySelector(".backgroundImg");
	    const titleInput = document.getElementById("backgroundTitleInput");
	    const textarea = document.querySelector(".background-description textarea");
	    const contextPath = "<%= request.getContextPath() %>";
	    const fullPath = contextPath + "/jspproject/mplistImg/" + fileName;
	
	    previewImg.src = fullPath;
	
	    // 저장된 제목/설명 불러오기
	    if (backgroundDescriptions[fileName]) {
	        titleInput.value = backgroundDescriptions[fileName].title || fileName;
	        textarea.value = backgroundDescriptions[fileName].description || "";
	    } else {
	        titleInput.value = fileName;
	        textarea.value = "";
	    }
	}
</script>
