<!-- musicList.jsp -->
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jspproject.UserBean" %>
<%@ page import="jspproject.BgmBean" %>
<%@ page import="jspproject.MplistBean" %>
<%@ page import="jspproject.MplistMgrBean" %>
<%@ page import="jspproject.MplistBgmView" %>
<jsp:useBean id="lmgr" class="jspproject.LoginMgr"/>
<jsp:useBean id="bmgr" class="jspproject.BgmMgr"/>
<%
String user_id = (String) session.getAttribute("user_id");
if (user_id == null) {
    response.sendRedirect("login.jsp");
    return;
}


Vector<BgmBean> bgm = bmgr.getBgmList(user_id);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <style>
    .music-container {
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

	.music-tab {
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

    .music-header, .music-list{
        margin-bottom: 15px;
    }

    .music-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #555;
    padding-bottom: 8px;
    font-family: 'PFStarDust', sans-serif;
    font-weight: bold;
   	font-size: 1vw;
	}
    
    .music-header input[type="checkbox"] {
    appearance: none;
    width: 18px;
    height: 18px;
    border: 2px solid #ccc;
    border-radius: 4px;
    margin-left: 14px;
    margin-right: 10px;
    cursor: pointer;
    transition: all 0.2s ease;
    position: relative;
    background-color: white;

    vertical-align: middle;
    margin-top: -1px; /* ✅ 살짝 위로 올림 */
	}
	
	/* 체크된 상태 */
	.music-header input[type="checkbox"]:checked {
	    background-color: black;       /* 체크 시 검정색 채우기 */
	    border-color: white;
	}
	
	/* 체크된 상태에 체크 모양 (✓ 표시용) */
	.music-header input[type="checkbox"]:checked::after {
	    content: '✓';
	    color: white;
	    font-size: 11px;
	    font-weight: bold;
	    position: absolute;
	    top: 50%;
   	 	left: 50%;
    	transform: translate(-45%, -55%); /* 👈 수직 위치 살짝 위로 */
	}
	
	.music-search {
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

	.music-search::placeholder {
    color: rgba(255, 255, 255, 0.5);
	}

    
    /* 왼쪽 영역 고정 */
	.music-left {
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
	}
	
	.music-list {
	    flex: 1;
	    overflow-y: auto;
	    max-height: 100%; /* ← 최대 높이로 설정 */
	    padding-right: 4px;
	    margin-bottom: 10px;
	}
	
	/* 하단 버튼 박스 */
	.music-footer {
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
	
	.music-footer button {
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
	
    .music-list-item {
    	position: relative;
        background-color: #3c1e5c;
        margin-bottom: 12px;
        padding: 10px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .music-list-item input[type="checkbox"] {
    appearance: none;              /* 기본 브라우저 스타일 제거 */
    width: 18px;
    height: 18px;
    border: 2px solid #ccc;
    border-radius: 4px;            /* 둥근 모서리 */
    margin-right: 10px;
    cursor: pointer;
    transition: all 0.2s ease;
    position: relative;
    background-color: white;       /* 기본 배경 */
	}
	
	/* 체크된 상태 */
	.music-list-item input[type="checkbox"]:checked {
	    background-color: black;       /* 체크 시 검정색 채우기 */
	    border-color: white;
	}
	
	/* 체크된 상태에 체크 모양 (✓ 표시용) */
	.music-list-item input[type="checkbox"]:checked::after {
	    content: '✓';
	    color: white;
	    font-size: 11px;
	    font-weight: bold;
	    position: absolute;
	    top: 50%;
   	 	left: 50%;
    	transform: translate(-45%, -55%); /* 👈 수직 위치 살짝 위로 */
	}
	
	.music-list::-webkit-scrollbar {
	    width: 10px; /* 스크롤바 너비 */
	}
	
	.music-list::-webkit-scrollbar-track {
	    background: transparent; /* 트랙은 안 보이게 */
	}
	
	.music-list::-webkit-scrollbar-thumb {
	    background-color: white;  /* 스크롤바 색상 */
	    border-radius: 10px;
	    border: 2px solid transparent;
	    background-clip: content-box; /* 부드러운 느낌 */
	}
	
	.music-list::-webkit-scrollbar-button {
	    display: none; /* 🔥 위아래 화살표 제거 */
	}
	
	/* 삭제 아이콘 */
	.music-list-item .iconPlusPlay {
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
	
	.header-left {
    display: flex;
    align-items: center; /* 세로 정렬 */
	}
	
	
	/* 마우스 오버 시 나타남 */
	.music-list-item:hover .iconPlusPlay {
	    opacity: 1;
	}
	
	.music-right {
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

	.musicImg {
	    width: 85%;           /* 부모 너비 꽉 채움 */
	    height: 270px;         /* 원하는 고정 높이 지정 */
	    object-fit: cover;     /* 이미지 비율 유지하며 꽉 채우고 넘치는 부분은 잘라냄 */
	    border-radius: 10px;   /* 둥근 테두리 유지 (선택 사항) */
	    box-shadow: 0 0 12px rgba(123, 44, 191, 0.6);
	}

    .music-controls {
        display: flex;
        justify-content: center;
        gap: 20px;
        font-size: 24px;
    }

    .music-description textarea {
    width: 100%;
    height: 100px;
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

    .music-cancel-button {
    display: flex;
    justify-content: center;
    margin-bottom: 12px;
	}
	
	.music-cancel-button button {
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
	.music-right-buttons {
	    display: flex;
	    justify-content: space-between;
	}
	
	.music-right-buttons button {
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
    
    .iconMusic2 {
	    width: 2.5vw;
	    height: 2.5vw;
	    cursor: pointer;
    }
    
    .iconMusicList {
    width: 2vw;
	height: 2vw;
	cursor: pointer;
	}
	
	.iconDelete {
	width: 2vw;
	height: 2vw;
	cursor: pointer;
	}
	
	/* 검색창 크기 조절 */
	.music-search {
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
	
	.music-preview {
    padding-top: 60px; /* 👈 아이콘 높이만큼 위에 여유 공간 줌 */
    text-align: center;
	}
	
	.music-preview h2 {
    margin-top: 20px;     /* 줄이거나 0으로 설정 가능 */
    margin-bottom: -3px;
    font-size: 1.1vw;    /* 사이즈도 적당히 */
	}
	
	#musicPlayListWrapper {
	    display: none;
	}
	
	#musicPlayListAddWrapper {
	    display: none;
	}
	
	#musicPlayListDetailWrapper {
	    display: none;
	}

	
</style>

</head>

<body data-context="<%= request.getContextPath() %>" data-user-id="<%= user_id %>">
<div class="music-container">
    <!-- 왼쪽 영역 -->
    <div class="music-left">
    	<!-- 🎵 음악 목록 / 재생 목록 탭 -->
		<div class="music-tab">
	    	<button class="tab-btn active">음악 목록</button>
	    	<button class="tab-btn" onclick="switchToPlayList()">재생 목록</button>
		</div>

        <div class="music-header">
		    <!-- 왼쪽: 전체 선택 -->
		    <div class="header-left">
		        <input type="checkbox" id="selectAll">
		        <label for="selectAll">전체 선택</label>
		    </div>

		    <!-- 오른쪽: 정렬/검색 -->
		    <div class="header-right">
		        <img class="iconMusicList" src="icon/아이콘_글자순_1.png" alt="글자 순 정렬" onclick="sortMusicList()">
		        <input class="music-search" type="text" placeholder="음악 제목 검색" oninput="searchMusic()" />
		        <img class="iconMusicList" src="icon/아이콘_검색_1.png" alt="검색" >
		    </div>
		</div>

        <div class="music-list" id="musicList">
		<% 
		    Vector<MplistBgmView> bgmList = (Vector<MplistBgmView>) request.getAttribute("bgmList");
		
		    if (bgmList == null || bgmList.isEmpty()) {
		        // 재생목록에서 못 불러왔으면, 기본 유저 음악 목록으로 대체
		        bgmList = new Vector<MplistBgmView>();
		        Vector<BgmBean> defaultBgm = bmgr.getBgmList(user_id);
		
		        for (BgmBean b : defaultBgm) {
		            MplistBgmView view = new MplistBgmView();
		            view.setBgm(b);
		            view.setBgm_onoff(b.getBgm_onoff());
		            view.setBgm_order(0); // 기본값
		            view.setMplist_id(0); // 기본값
		            bgmList.add(view);
		        }
		    }
		
		    if (bgmList != null && !bgmList.isEmpty()) {
		        for (MplistBgmView view : bgmList) {
		            BgmBean b = view.getBgm();
		%>
		    <div class="music-list-item"
		         data-bgm-id="<%= b.getBgm_id() %>"
		         data-bgm-name="<%= b.getBgm_name() %>"
		         data-bgm-cnt="<%= b.getBgm_cnt() %>"
		         data-bgm-image="musicImg/<%= b.getBgm_image() %>"
		         data-bgm-music="<%= b.getBgm_music() %>"
		         data-bgm-onoff="<%= view.getBgm_onoff() %>"
		         data-bgm-order="<%= view.getBgm_order() %>"
		         data-mplist-id="<%= view.getMplist_id() %>">
		        <input type="checkbox" name="bgm_id" value="<%= b.getBgm_id() %>" />
		        <span><%= b.getBgm_name() %></span>
		        <img class="iconPlusPlay" src="icon/아이콘_플레이리스트추가_1.png" alt="추가">
		    </div>
		<%
		        } // end for
		    } else {
		%>
		    <div class="music-list-item2" style="color:white;">재생 가능한 음악이 없습니다.</div>
		<% 
		    } // end if-else
		%>
		</div>

        <div class="music-footer">
           	<input type="file" id="musicFileInput" accept=".mp3" style="display: none;" onchange="handleFileSelect(event)">
			<button class="btn-purple" onclick="document.getElementById('musicFileInput').click()">추가</button>
            <button class="btn-red delete-selected">삭제</button>
        </div>
    </div>

    <!-- 오른쪽 영역 -->
	<div class="music-right">
	  <div class="preview-icons">
	    <img class="iconMusicList" id="editIcon" src="icon/아이콘_수정_1.png" alt="수정">
	    <img class="iconDelete" src="icon/아이콘_삭제_1.png" alt="삭제">
	  </div>

	  <div class="music-preview">
	    <img id="bgmImg" class="musicImg" src="img/default.png" />
	    <h2 id="bgmName" contenteditable="false">선택된 음악 없음</h2>
	  </div>

	  <div class="music-controls">
		  <!-- 이전 곡 버튼 -->
		  <span>
		    <img 
		      class="iconMusic2" 
		      src="icon/아이콘_이전음악_1.png" 
		      alt="이전" 
		      id="prevBgmBtn"
		      title="이전 곡"
		      onclick="handlePrevMusic()"
		    >
		  </span>

		  <!-- 재생/일시정지 -->
		  <span>
		    <audio id="playAudioPlayer">
		      <source src="<%= request.getContextPath() %>/jspproject/music/" type="audio/mpeg">
		    </audio>
		    <img 
		      id="playToggleBtn" 
		      class="iconMusic2" 
		      src="icon/아이콘_재생_1.png" 
		      data-state="paused" 
		      alt="재생"
		      title="재생/일시정지 버튼"
		    >
		  </span>

		  <!-- 다음 곡 버튼 -->
		  <span>
		    <img 
		      class="iconMusic2" 
		      src="icon/아이콘_다음음악_1.png" 
		      alt="다음" 
		      id="nextBgmBtn"
		      title="다음 곡"
		      onclick="handleNextMusic2()"
		    >
		  </span>
		</div>


	  <div class="music-description">
	    <textarea id="bgmCnt" readonly>음악을 선택해주세요</textarea>
	  </div>

	  <!-- 가운데 위 버튼 -->
	  <div class="music-cancel-button">
	    <button class="btn-purple">음악 취소</button>
	  </div>

	  <!-- 아래 좌우 버튼 -->
	  <div class="music-right-buttons">
	    <button class="btn-dark" id="submitEditBtn" onclick="submitBgmEdit()" disabled>수정</button>
	    <button class="btn-purple">적용</button>
	  </div>

	  <!-- ✅ 추가된 hidden 필드 (반드시 여기 추가!) -->
	  <input type="hidden" id="hiddenBgmId">
	  <input type="hidden" id="hiddenBgmName">
	  <input type="hidden" id="hiddenBgmCnt">
	  <input type="file" id="bgmImgInput" accept="image/*" style="display:none;" onchange="uploadBgmImage(event)">
	  <!-- 현재 재생 중인 곡의 순서 및 재생목록 ID 저장용 -->
	  <input type="hidden" id="hiddenBgmOrder">
	  <input type="hidden" id="hiddenMplistId"> 
	</div>
</div>

<!-- 재생목록 추가 영역 (처음엔 숨김) -->
<div class = "add-playlist-container" id="musicPlayListAddWrapper"> 
    <jsp:include page="musicListAdd.jsp" />
</div>

<div id="musicPlayListDetailWrapper">
    <jsp:include page="musicPlayListDetail.jsp" />
</div>

</body>
</html>

<script>
	document.addEventListener('DOMContentLoaded', function () {
	    setupCheckboxListeners();
	    setupItemBoxClickListeners();
	
	    const playBtn = document.getElementById('playToggleBtn');
	    const audio = document.getElementById('playAudioPlayer');
	    playBtn.setAttribute('data-state', 'paused');
	
	    playBtn.addEventListener('click', function(e) {
	        e.stopPropagation();
	        const bgmId = document.getElementById("hiddenBgmId").value;
	        if (!bgmId) return alert("음악이 선택되지 않았습니다.");

	        const newOnoff = (playBtn.getAttribute('data-state') === 'paused') ? 1 : 0;

	        fetch("<%=request.getContextPath()%>/jspproject/bgmOnOff", {
	            method: "POST",
	            headers: { "Content-Type": "application/json" },
	            body: JSON.stringify({ bgm_id: parseInt(bgmId), bgm_onoff: newOnoff })
	        })
	        .then(res => res.json())
	        .then(data => {
	            if (data.success) {
	                if (newOnoff === 1) {
	                    audio.play();
	                    playBtn.src = 'icon/아이콘_일시정지_1.png';
	                    playBtn.setAttribute('data-state', 'playing');
	                } else {
	                    audio.pause(); // ✅ 일시정지만 하고 위치 유지
	                    playBtn.src = 'icon/아이콘_재생_1.png';
	                    playBtn.setAttribute('data-state', 'paused');
	                }

	            } else {
	                alert("재생 상태 변경 실패");
	            }
	        });
	    });
	
	 // 🎯 전역 변수에 DOM 요소 할당
	    playlistContainer = document.querySelector('.add-playlist-container');

	    const plusIcons = document.querySelectorAll('.iconPlusPlay');
	    plusIcons.forEach(icon => {
	        icon.addEventListener('click', function (e) {
	            e.stopPropagation();

	            const musicItem = this.closest(".music-list-item");
	            const bgmId = musicItem.getAttribute("data-bgm-id");

	            document.getElementById("addPlaylistBgmId").value = bgmId;

	            const rect = this.getBoundingClientRect();
	            playlistContainer.style.position = 'absolute';
	            playlistContainer.style.top = (rect.bottom + window.scrollY + 5) + 'px';
	            playlistContainer.style.left = (rect.left + window.scrollX - 180) + 'px';
	            playlistContainer.style.display = 'block';
	        });
	    });

	    // 🎯 바깥 클릭 시 닫기
	    document.addEventListener('click', function (e) {
	        if (
	            playlistContainer &&
	            !playlistContainer.contains(e.target) &&
	            !e.target.classList.contains('iconPlusPlay') &&
	            !e.target.closest('.iconPlusPlay')
	        ) {
	            playlistContainer.style.display = 'none';
	            playlistContainer.querySelectorAll('input[name="mplist_id"]').forEach(cb => cb.checked = false);
	        }
	    });

	    // 컨테이너 내부 클릭 전파 방지
	    if (playlistContainer) {
	        playlistContainer.addEventListener('click', function (e) {
	            e.stopPropagation();
	        });
	    }

	
	    document.addEventListener('click', function (e) {
	        if (
	            !e.target.closest('.music-list-item') &&
	            !e.target.closest('.music-right') &&
	            !e.target.closest('.add-playlist-container') &&
	            !e.target.closest('.iconPlusPlay')
	        ) {
	            resetDetailInfo();
	            if (playlistContainer) playlistContainer.style.display = 'none';
	        }
	    });
	
	    if (playlistContainer) {
	        playlistContainer.addEventListener('click', function(e) {
	            e.stopPropagation();
	        });
	    }
	
	    const deleteBtn = document.querySelector('.delete-selected');
	    if (deleteBtn) {
	        deleteBtn.addEventListener('click', function () {
	            const checkedItems = document.querySelectorAll('.music-list-item input[type="checkbox"]:checked');
	            if (checkedItems.length === 0) return alert("삭제할 음악을 선택해주세요.");
	            if (!confirm("정말 삭제하시겠습니까?")) return;
	
	            const bgmIds = Array.from(checkedItems).map(chk => Number(chk.value));
	            fetch('<%=request.getContextPath()%>/bgmDelete', {
	                method: 'POST',
	                headers: { 'Content-Type': 'application/json' },
	                body: JSON.stringify({ bgmIds })
	            })
	            .then(res => res.json())
	            .then(data => {
	                if (data.success) {
	                    alert("삭제 완료!");
	                    checkedItems.forEach(chk => chk.closest(".music-list-item").remove());
	                } else {
	                    alert("삭제 실패");
	                }
	            });
	        });
	    }
	    
	    const editIcon = document.getElementById('editIcon');
	    if (editIcon) {
	        editIcon.addEventListener('click', enableEditMode);
	    }
	    
	    const previewDeleteIcon = document.querySelector('.preview-icons .iconDelete');
	    
	    if (previewDeleteIcon) {
	        previewDeleteIcon.addEventListener('click', function (e) {
	            e.stopPropagation();
	            const bgmId = document.getElementById("hiddenBgmId").value;

	            if (!bgmId) return alert("삭제할 음악이 선택되지 않았습니다.");
	            if (!confirm("정말 이 음악을 삭제하시겠습니까?")) return;

	            fetch('<%=request.getContextPath()%>/bgmDelete', {
	                method: 'POST',
	                headers: { 'Content-Type': 'application/json' },
	                body: JSON.stringify({ bgmIds: [Number(bgmId)] })
	            })
	            .then(res => res.json())
	            .then(data => {
	            	if (data.success) {
	            	    alert("삭제 완료!");
	            	    window.location.href = "<%= request.getContextPath() %>/jspproject/mainScreen.jsp";
	            	} else {
	            	    alert("삭제 실패: " + data.message);
	            	}
	            })
	            .catch(err => {
	                console.error(err);
	                alert("삭제 중 오류 발생");
	            });
	        });
	    }
});

	function setupCheckboxListeners() {
	    const selectAllCheckbox = document.getElementById('selectAll');
	    const checkboxes = document.querySelectorAll('.music-list-item input[type="checkbox"]');
	
	    if (selectAllCheckbox) {
	        selectAllCheckbox.addEventListener('change', function () {
	            const isChecked = this.checked;
	            checkboxes.forEach(chk => chk.checked = isChecked);
	        });
	    }
	}
	
	let currentMusicIndex = -1;

	function setupItemBoxClickListeners() {
	    const items = document.querySelectorAll('.music-list-item');
	    items.forEach((item, index) => {
	        item.addEventListener('click', function (e) {
	            if (e.target.matches('input[type="checkbox"]')) return;

	            currentMusicIndex = index;
	            currentBgmId = item.getAttribute("data-bgm-id"); // ✅ 현재 곡 ID 저장

	            showBgmDetail(
	                item.dataset.bgmId,
	                item.dataset.bgmName,
	                item.dataset.bgmCnt,
	                item.dataset.bgmImage,
	                item.dataset.bgmMusic,
	                item.dataset.bgmOnoff,
	                true
	            );
	        });
	    });
	}

	// ✅ 메인 플레이어 제어 제거된 showBgmDetail()
	function showBgmDetail(bgmId, bgmName, bgmCnt, bgmImgPath, bgmMusic, bgmOnoff, autoPlay = false) {
	    document.getElementById("bgmImg").src = bgmImgPath || "img/default.png";
	    document.getElementById("bgmName").innerText = bgmName || "제목 없음";
	    document.getElementById("bgmCnt").value = bgmCnt || "음악에 대한 설명을 추가해주세요.";
	    document.getElementById("hiddenBgmId").value = bgmId;
	    document.getElementById("hiddenBgmName").value = bgmName;
	    document.getElementById("hiddenBgmCnt").value = bgmCnt;
	
	    const audioPlayer = document.getElementById("playAudioPlayer");
	    const playBtn = document.getElementById("playToggleBtn");
	
	    const src = (bgmMusic && bgmMusic !== "null")
	        ? document.body.dataset.context + "/jspproject/music/" + bgmMusic
	        : document.body.dataset.context + "/jspproject/music/default.mp3";
	
	    audioPlayer.src = src;
	
	    playBtn.setAttribute('data-state', Number(bgmOnoff) === 1 ? 'playing' : 'paused');
	    playBtn.src = Number(bgmOnoff) === 1 ? "icon/아이콘_일시정지_1.png" : "icon/아이콘_재생_1.png";
	
	    if (autoPlay) {
	        audioPlayer.load();
	        audioPlayer.onloadeddata = () => {
	            audioPlayer.play().then(() => {
	                playBtn.setAttribute('data-state', 'playing');
	                playBtn.src = "icon/아이콘_일시정지_1.png";
	            }).catch(err => {
	                console.warn("자동 재생 실패:", err);
	            });
	        };
	    }
	
	    const editBtn = document.getElementById('submitEditBtn');
	    editBtn.disabled = true;
	    editBtn.style.opacity = '0.5';
	    editBtn.style.cursor = 'default';
	}

	
	window.enableEditMode = function() {
		  const cntEl = document.getElementById('bgmCnt');
		  const editBtn = document.getElementById('submitEditBtn');
		  const bgmImg = document.getElementById('bgmImg');

		  if (!cntEl || !editBtn || !bgmImg) return;

		  const isEditing = !cntEl.hasAttribute('readonly');

		  if (isEditing) {
		    cntEl.setAttribute('readonly', true);
		    cntEl.style.boxShadow = 'none';
		    editBtn.disabled = true;
		    editBtn.style.opacity = '0.5';
		    editBtn.style.cursor = 'default';

		    bgmImg.classList.remove('clickable');
		    bgmImg.removeEventListener('click', triggerImageUpload);
		  } else {
		    cntEl.removeAttribute('readonly');
		    cntEl.style.boxShadow = '0 0 10px rgba(255,255,255,0.5)';
		    editBtn.disabled = false;
		    editBtn.style.opacity = '1';
		    editBtn.style.cursor = 'pointer';

		    bgmImg.classList.add('clickable');
		    bgmImg.addEventListener('click', triggerImageUpload);
		  }
		};

	function triggerImageUpload() {
	    document.getElementById('bgmImgInput').click();
	}
	
	window.uploadBgmImage = function(event) {
	    const file = event.target.files[0];
	    if (!file) return;

	    const bgmId = document.getElementById("hiddenBgmId").value;
	    if (!bgmId) {
	        alert("먼저 음악을 선택해주세요.");
	        return;
	    }

	    const formData = new FormData();
	    formData.append("bgm_id", bgmId);
	    formData.append("bgm_image", file);

	    fetch("<%=request.getContextPath()%>/jspproject/bgmImageUpdate", {
	        method: "POST",
	        body: formData
	    })
	    .then(res => res.json())
	    .then(data => {
	        if (data.success) {
	            document.getElementById("bgmImg").src = "img/" + data.filename + "?t=" + new Date().getTime();
	            alert("이미지가 성공적으로 변경되었습니다.");
	        } else {
	            alert("업로드 실패: " + data.message);
	        }
	    })
	    .catch(err => {
	        console.error(err);
	        alert("이미지 업로드 중 오류가 발생했습니다.");
	    });
	};
	
	window.submitBgmEdit = function() {
	    const name = document.getElementById("bgmName").innerText.trim();
	    const cnt = document.getElementById("bgmCnt").value.trim();
	    const bgmId = document.getElementById("hiddenBgmId").value;

	    if (!bgmId) {
	        alert("선택된 음악이 없습니다.");
	        return;
	    }

	    fetch("<%= request.getContextPath() %>/jspproject/bgmUpdate", {
	        method: "POST",
	        headers: {
	            "Content-Type": "application/json"
	        },
	        body: JSON.stringify({
	            bgm_id: parseInt(bgmId, 10),
	            bgm_name: name,
	            bgm_cnt: cnt
	        })
	    })
	    .then(res => res.json())
	    .then(data => {
	        if (data.success) {
	            alert("수정 완료!");
	            document.getElementById("bgmCnt").setAttribute("readonly", true);
	            document.getElementById("bgmCnt").style.boxShadow = "none";
	            window.location.href = "<%= request.getContextPath() %>/jspproject/mainScreen.jsp";
	        } else {
	            alert("수정 실패: " + data.message);
	        }
	    })
	    .catch(err => {
	        console.error(err);
	        alert("서버 오류 발생: " + err.message);
	    });
	};
	
	window.handleFileSelect = function(event) {
	    const file = event.target.files[0];
	    if (!file) return;

	    const formData = new FormData();
	    formData.append("music", file); // mp3 파일
	    formData.append("user_id", "<%= user_id %>"); // 현재 사용자
	    formData.append("bgm_name", file.name); // 파일명 그대로 제목
	    formData.append("bgm_cnt", ""); // 설명은 비워두기

	    fetch("<%=request.getContextPath()%>/jspproject/bgmUpload", {
	        method: "POST",
	        body: formData
	    })
	    .then(res => res.text())
	    .then(text => {
	        alert("업로드 성공!");
	        location.reload(); // 새로고침 또는 DOM에 새로 추가 가능
	    })
	    .catch(err => {
	        alert("업로드 실패: " + err.message);
	        console.error(err);
	    });
	};
	
	function resetDetailInfo() {
	    document.getElementById('bgmName').innerText = '선택된 음악 없음';
	    document.getElementById('bgmCnt').value = '선택된 음악이 없습니다';
	    document.getElementById('bgmImg').src = 'img/default.png';
	    document.getElementById('hiddenBgmId').value = '';
	    document.getElementById('hiddenBgmName').value = '';
	    document.getElementById('hiddenBgmCnt').value = '';
	}
	
	function switchToPlayList() {
	    const musicListContainer = document.querySelector('.music-container'); // 음악 목록 전체
	    const detailWrapper = document.querySelector('#musicPlayListDetailWrapper'); // 감싸는 div
	    const detailContainer = detailWrapper?.querySelector('.music-container3'); // 내부 진짜 컨테이너

	    if (musicListContainer && detailWrapper && detailContainer) {
	        musicListContainer.style.display = 'none';
	        detailWrapper.style.display = 'block'; // wrapper는 block이어도 되고
	        detailContainer.style.display = 'flex'; // 내부 컨테이너는 반드시 flex
	    }
	}
	
	// ✅ 현재 곡 ID 기억용 (전역)
	let currentBgmId = null;

	function handleNextMusic2(autoPlay = false) {
	    const musicItems = Array.from(document.querySelectorAll('.music-list-item'));
	    if (musicItems.length === 0) return alert("음악 목록이 비어있습니다.");

	    // 다음 곡 인덱스 계산
	    const nextIndex = currentMusicIndex + 1;

	    // 만약 다음 곡이 없다면, 경고창 표시하고 종료
	    if (nextIndex >= musicItems.length) {
	        alert("다음 곡이 없습니다.");
	        return;
	    }

	    // 다음 곡을 가져오기
	    const item = musicItems[nextIndex];
	    currentMusicIndex = nextIndex; // prevIndex 대신 nextIndex 사용

	    currentBgmId = item.dataset.bgmId;

	    // showBgmDetail 호출 (다음 곡 정보로 갱신)
	    showBgmDetail(
	        item.dataset.bgmId,
	        item.dataset.bgmName,
	        item.dataset.bgmCnt,
	        item.dataset.bgmImage,
	        item.dataset.bgmMusic,
	        item.dataset.bgmOnoff,
	        autoPlay
	    );
	}

	function handlePrevMusic(autoPlay = false) {
	    const musicItems = Array.from(document.querySelectorAll('.music-list-item'));
	    if (musicItems.length === 0) return alert("음악 목록이 비어있습니다.");

	    const prevIndex = currentMusicIndex - 1;
	    if (prevIndex < 0) {
	        alert("이전 곡이 없습니다.");
	        return;
	    }

	    const item = musicItems[prevIndex];

	    currentMusicIndex = prevIndex;
	    currentBgmId = item.dataset.bgmId;

	    // ✅ bgm_onoff 변경 없이 재생만!
	    showBgmDetail(
	        item.dataset.bgmId,
	        item.dataset.bgmName,
	        item.dataset.bgmCnt,
	        item.dataset.bgmImage,
	        item.dataset.bgmMusic,
	        item.dataset.bgmOnoff,
	        autoPlay
	    );
	}
	
	const audioPlayer = document.getElementById("playAudioPlayer");
	audioPlayer.onended = function () {
	    handleNextMusic2(true);  // 자동 다음 곡 재생
	};
	
	function searchMusic() {
	    const searchText = document.querySelector('.music-search').value.toLowerCase(); // 입력한 텍스트 소문자로 변환
	    const musicItems = document.querySelectorAll('.music-list-item'); // 음악 목록 아이템을 선택

	    // 각 음악 항목을 순회하면서 제목을 검색
	    musicItems.forEach(item => {
	        const title = item.querySelector('span').innerText.toLowerCase(); // 음악 제목
	        if (title.includes(searchText)) {
	            item.style.display = ''; // 검색어가 포함된 항목은 보이도록
	        } else {
	            item.style.display = 'none'; // 검색어가 포함되지 않은 항목은 숨김
	        }
	    });
	}

	let isSorted = false;  // 정렬 상태 여부를 추적하는 변수
	let originalOrder = [];  // 원래 순서를 저장할 배열

	function sortMusicList() {
	    const musicListContainer = document.getElementById('musicList');
	    const musicItems = Array.from(musicListContainer.getElementsByClassName('music-list-item'));

	    if (musicItems.length === 0) return;  // 음악 목록이 비어 있으면 처리 안 함

	    // 처음 한 번만 원래 순서를 저장
	    if (originalOrder.length === 0) {
	        originalOrder = musicItems.map(item => item);  // 원래 순서를 저장
	    }

	    if (!isSorted) {
	        // 음악 아이템을 알파벳 순으로 정렬
	        const sortedItems = musicItems.sort((a, b) => {
	            const titleA = a.querySelector('span').innerText.toLowerCase();
	            const titleB = b.querySelector('span').innerText.toLowerCase();
	            return titleA.localeCompare(titleB); // 문자열 순으로 비교
	        });

	        // 정렬된 항목을 다시 musicListContainer에 추가
	        sortedItems.forEach(item => {
	            musicListContainer.appendChild(item);
	        });

	        isSorted = true; // 정렬 상태로 설정
	    } else {
	        // 원래 순서로 돌아오기 위해, 음악 아이템을 처음 순서대로 다시 추가
	        originalOrder.forEach(item => {
	            musicListContainer.appendChild(item);  // 원래 순서대로 돌아오도록 추가
	        });

	        isSorted = false; // 정렬 취소 상태로 설정
	    }
	}

</script>