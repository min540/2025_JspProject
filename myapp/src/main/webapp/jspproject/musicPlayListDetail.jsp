<!-- musicPlayListDetail.jsp -->
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jspproject.UserBean" %>
<%@ page import="jspproject.BgmBean" %>
<%@ page import="jspproject.MplistBean" %>
<%@ page import="jspproject.MplistMgrBean" %>
<jsp:useBean id="lmgr" class="jspproject.LoginMgr"/>
<jsp:useBean id="bmgr" class="jspproject.BgmMgr"/>
<jsp:useBean id="pmgr" class="jspproject.MplistMgr"/>
<%
		String user_id = (String) session.getAttribute("user_id");  // ✅ 이제 문자열로 바로 받아도 안전함
		if (user_id == null) {
		    response.sendRedirect("login.jsp");
		    return;
}

	UserBean user = lmgr.getUser(user_id);                // 유저 정보 (필요시)
	Vector<MplistBean> mplist = pmgr.getMplist(user_id); // 유저의 재생목록 가져오기
	Vector<BgmBean> bgm = bmgr.getBgmList(user_id); //유저의 음악 가져오기
%>
 <style>
    .music-container3 {
	    position: absolute;
	    left: 18vw;
	    top: 9.5vh;
	    display: flex;
	    width: 70%;
	    height: 74.5vh;
	    background-color: rgba(29, 16, 45, 0.7);
	    color: white;
	    border-radius: 15px;
	    box-shadow: 0 0 20px rgba(255,255,255,0.4);
	}
	
	/* 좌+중앙 묶은 div */
	.music-main2 {
	  flex: 8.35;
	  display: flex;
	  flex-direction: column;
	  border-right: 2px solid #311e4f;
	}
			
	.music-tab2 {
	    display: flex;
	    gap: 10px;
	    padding: 15px 30px;
	    background-color: transparent;
	    border-bottom: 1px solid rgba(255,255,255,0.2);
	    margin-top:10px;
	}
	
	.tab-btn2 {
	    background: none;
	    border: none;
	    color: #fff;
	    padding: 5px 12px;
	    cursor: pointer;
	    transition: 0.2s;
	    font-family: 'PFStarDust', sans-serif;
    	font-weight: bold;
   	 	font-size: 1vw;
	}
	
	.tab-btn2.active2 {
	    font-weight: bold;
	    border-bottom: 2px solid white;
	}
	
	.music-layout2 {
	    flex: 1;
	    display: flex; /* 왼쪽, 가운데, 오른쪽 배치 */
	    overflow: hidden;
	}
	
	.music-left2 {
	    flex: 3;
	    display: flex;
	    flex-wrap: wrap;               /* 줄 바꿈 허용 */
	    align-content: flex-start;     /* 위부터 채우기 */
	    gap: 6px;
	    padding: 10px;
	    overflow-y: auto;
	    box-sizing: border-box;
	    background-color: rgba(42, 18, 69, 0.2);
	}

	.playlist-box2 {
	    width: calc(50% - 3px);       /* gap 보정 포함 2열 */
	    aspect-ratio: 1 / 1;
	    position: relative;
	    border-radius: 8px;
	    overflow: hidden;
	    background-color: #444;
	    cursor: pointer;
	}
	
	/* ✅ 내부 이미지: 정사각형 내부 꽉 채우기 */
	.playlist-box2 img {
	    position: absolute;
	    top: 0; left: 0;
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    border-radius: 8px;
	}
	
	/* ✅ 오버레이 텍스트 */
	.playlist-name2 {
	    position: absolute;
	    top: 3px;
	    left:3px;
	    background-color: rgba(0, 0, 0, 0.7);
	    color: white;
	    font-size: 0.67vw;
	    padding: 3px 6px;
	    border-radius: 4px;
	    font-weight: bold;
	    z-index: 2;
	    white-space: nowrap;
	}
	
	.playlist-count2 {
	    position: absolute;
	    bottom: 6px;
	    right: 6px;
	    background-color: rgba(0, 0, 0, 0.7);
	    color: white;
	    font-size: 0.7vw;
	    padding: 2px 6px;
	    border-radius: 4px;
	    z-index: 2;
	}
	
	.add-playlist2 {
	    width: calc(50% - 3px);          /* gap 보정 포함 (2열) */
	    aspect-ratio: 1 / 1;             /* 정사각형 유지 */
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    
	    border-radius: 8px;
	    border: 2px dashed #aaa;
	    cursor: pointer;
	    background-color: #666;
	    color: white;
	    font-size: 2vw;
	    font-weight: bold;
	    transition: 0.3s;
	}
	
	.add-playlist2:hover {
	    background-color: #999;
	    color: black;
	}
	
	/* 삭제 아이콘 */
	.playlist-box2 .iconDelete2 {
	    position: absolute;
	    top: 4px;
	    left: 85px;
	    width: 25px;
	    height: 25px;
	    opacity: 0;
	    transition: opacity 0.2s ease;
	    cursor: pointer;
	    z-index: 2;
	}
	
	/* 마우스 오버 시 나타남 */
	.playlist-box2:hover .iconDelete2 {
	    opacity: 1;
	}
	
	.music-left2::-webkit-scrollbar {
	    width: 10px; /* 스크롤바 너비 */
	}
	
	.music-left2::-webkit-scrollbar-track {
	    background: transparent; /* 트랙은 안 보이게 */
	}
	
	.music-left2::-webkit-scrollbar-thumb {
	    background-color: white;  /* 스크롤바 색상 */
	    border-radius: 10px;
	    border: 2px solid transparent;
	    background-clip: content-box; /* 부드러운 느낌 */
	}
	
	.music-left2::-webkit-scrollbar-button {
	    display: none; /* 🔥 위아래 화살표 제거 */
	}

    .music-middle2 {
    flex: 4;
    padding: 20px;
    display: flex;
    flex-direction: column;
    overflow: hidden;
	}
    
    .music-header2, .music-list2{
        margin-bottom: 15px;
    }

    .music-header2 {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    border-bottom: 1px solid #555;
	    padding-bottom: 8px;
	    font-family: 'PFStarDust', sans-serif;
	    font-weight: bold;
	   	font-size: 1vw;
	}
	
	.header-title2 {
	    font-family: 'PFStarDust', sans-serif;
	    font-weight: bold;
	    font-size: 1vw;
	    padding: 12px 16px;
	    
	    display: flex;
	    align-items: center;
	    justify-content: space-between;
	
	    background-color: rgba(0, 0, 0, 0.7); /* 검정 반투명 배경 */
	    border-radius: 5px;                  /* 둥근 모서리 */
	    border-bottom: 1px solid #555;        /* 아래쪽 경계선 */
	    margin-bottom: 12px;                  /* 아래 여백 */
	    box-shadow: 0 0 6px rgba(0,0,0,0.3);   /* 약한 그림자 */
	}
    
    .music-header2 input[type="checkbox"] {
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
	.music-header2 input[type="checkbox"]:checked {
	    background-color: black;       /* 체크 시 검정색 채우기 */
	    border-color: white;
	}
	
	/* 체크된 상태에 체크 모양 (✓ 표시용) */
	.music-header2 input[type="checkbox"]:checked::after {
	    content: '✓';
	    color: white;
	    font-size: 11px;
	    font-weight: bold;
	    position: absolute;
	    top: 50%;
   	 	left: 50%;
    	transform: translate(-45%, -55%); /* 👈 수직 위치 살짝 위로 */
	}
	
	.music-search2 {
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

	.music-search2::placeholder {
    color: rgba(255, 255, 255, 0.5);
	}

    
    /* 왼쪽 영역 고정 */
	.music-middle2 {
    flex: 8;
    padding: 20px;
    display: flex;
    flex-direction: column;
    overflow: hidden; /* ← 중요: 전체 스크롤 막기 */
	}
	
	/* 오른쪽 요소 오른쪽 끝으로 밀기 */
	.header-right2 {
	    display: flex;
	    align-items: center;
	    gap: 10px;
	}
	
	.music-list2 {
	    flex: 1;
	    overflow-y: auto;
	    max-height: 100%; /* ← 최대 높이로 설정 */
	    padding-right: 4px;
	}
	
	/* 하단 버튼 박스 */
	.music-footer2 {
	    display: flex;
	    justify-content: flex-end;
	    margin-top: auto;          /* ✅ 아래로 밀기 */
	    padding: 0 5px 0 20px;  /* ✅ 아래 패딩 약간 추가해서 적용 버튼이랑 딱 맞추기 */
	}

	@font-face {
	    font-family: 'PFStarDust';
	    src: url('fonts/PFStarDust-Bold.ttf') format('truetype');
	    font-weight: bold;
	    font-style: normal;
	}
	
	.music-footer2 button {
	 	width: 20%;
        margin: 5px;
        padding: 10px;
        border-radius: 8px;
        border: none;
        cursor: pointer;
        font-family: 'PFStarDust', sans-serif;
    	font-weight: bold;
   	 	font-size: 1vw;
    }
    
    .header-left2 {
	    display: flex;
	    align-items: center; /* 세로 정렬 */
	}	
	
    .music-list-item2 {
        background-color: #3c1e5c;
        margin-bottom: 12px;
        padding: 10px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .music-list-item2 input[type="checkbox"] {
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
	.music-list-item2 input[type="checkbox"]:checked {
	    background-color: black;       /* 체크 시 검정색 채우기 */
	    border-color: white;
	}
	
	/* 체크된 상태에 체크 모양 (✓ 표시용) */
	.music-list-item2 input[type="checkbox"]:checked::after {
	    content: '✓';
	    color: white;
	    font-size: 11px;
	    font-weight: bold;
	    position: absolute;
	    top: 50%;
   	 	left: 50%;
    	transform: translate(-45%, -55%); /* 👈 수직 위치 살짝 위로 */
	}
	
	.music-list2::-webkit-scrollbar {
	    width: 10px; /* 스크롤바 너비 */
	}
	
	.music-list2::-webkit-scrollbar-track {
	    background: transparent; /* 트랙은 안 보이게 */
	}
	
	.music-list2::-webkit-scrollbar-thumb {
	    background-color: white;  /* 스크롤바 색상 */
	    border-radius: 10px;
	    border: 2px solid transparent;
	    background-clip: content-box; /* 부드러운 느낌 */
	}
	
	.music-list2::-webkit-scrollbar-button {
	    display: none; /* 🔥 위아래 화살표 제거 */
	}
	
	.music-right2 {
   	 	position: relative; /* 기준점 잡아줌 */
        flex: 3;
        padding: 10px;
        background-color: rgba(42, 18, 69, 0.5);
        display: flex;
    	border-top-right-radius: 15px;
    	border-bottom-right-radius: 15px;
        flex-direction: column;
    }

	.musicImg2 {
	    width: 85%;           /* 부모 너비 꽉 채움 */
	    height: 270px;         /* 원하는 고정 높이 지정 */
	    object-fit: cover;     /* 이미지 비율 유지하며 꽉 채우고 넘치는 부분은 잘라냄 */
	    border-radius: 10px;   /* 둥근 테두리 유지 (선택 사항) */
	    box-shadow: 0 0 12px rgba(123, 44, 191, 0.6);
	}

    .music-controls2 {
        display: flex;
        justify-content: center;
        gap: 20px;
        font-size: 24px;
    }
    
    .music-controls3 {
        display: flex;
        justify-content: center;
        gap: 20px;
        font-size: 24px;
        margin-top: 20px;
    }

    .music-description3 textarea {
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
	
	.music-preview3 {
	    padding-top: 60px; /* 👈 아이콘 높이만큼 위에 여유 공간 줌 */
    	text-align: center;
	}
	
	.music-preview3 h2 {
	    margin-top: 20px;     /* 줄이거나 0으로 설정 가능 */
	    margin-bottom: -3px;
	    font-size: 1.1vw;    /* 사이즈도 적당히 */
	}
	
			
	.music-description2 textarea {
	    width: 100%;
	    height: 200px;
	    resize: none;
	    border-radius: 10px;
	    border: none;
	    padding: 12px;
	    background-color: #2e2e2e;
	    color: white;
	    font-size: 14px;
	    font-family: 'PFStarDust', sans-serif;
	    box-shadow: 0 0 12px rgba(123, 44, 191, 0.4);
	    text-align: center;
	}
	
	.music-cancel-button3 {
	    display: flex;
	    justify-content: center;
	    margin-bottom: 12px;
	}
	
	.music-cancel-button3 button {
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
	.music-right-buttons3 {
	    display: flex;
	    justify-content: space-between;
	}
	
	.music-right-buttons3 button {
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

    .music-cancel-button2 {
    display: flex;
    justify-content: center;
    margin-bottom: 12px;
	}
	
	.music-cancel-button2 button {
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
	.music-right-buttons2 {
	    display: flex;
	    justify-content: flex-end;    /* 👉 오른쪽 정렬 */
	    margin-top: 0px;
	    transition: opacity 0.3s ease;
	}

	.music-right-buttons2 button {
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
	    margin-top: 57px;
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
    
    .iconMusicList2 {
    width: 2vw;
	height: 2vw;
	cursor: pointer;
	}
	
	.iconMusicList3{
	width: 1.5vw;
	height: 1.5vw;
	cursor: pointer;
	}
	
	/* 검색창 크기 조절 */
	.music-search2 {
	    padding: 4px 8px;
	    font-size: 13px;
	    border-radius: 4px;
	    border: none;
	}
	
	/* 오른쪽 상단 고정 */
	.preview-icons2 {
	    position: absolute;
	    top: 12px;
	    right: 12px;
	    display: flex;
	    gap: 8px;
	}
	
	.music-preview2 {
    padding-top: 60px; /* 👈 아이콘 높이만큼 위에 여유 공간 줌 */
    text-align: center;
	}
	
	.editable-title {
	    margin-top: 20px;
	    margin-bottom: 20px;
	    font-size: 1.1vw;
	    font-weight: bold;
	    text-align: center;
	}
	
	.music-description3 {
	margin-top: 30px;
	margin-bottom:30px;
	font-size: 0.9vw;    /* 사이즈도 적당히 */
	}
	
	.mplistCnt_detail {
	margin-top: 30px;
	margin-bottom:30px;
	font-size: 0.9vw;    /* 사이즈도 적당히 */
	}	
	
	#musicPlayListWrapper {
	    display: none;
	}

	
</style>
        


<div class="music-container3" id="musicPlayListDetailWrapper" style="display: none;">
 	<!-- 🔸 div1: 탭 + 레이아웃 묶는 부모 -->
	  <div class="music-main2">
		<!-- 🔹 왼쪽: 재생 목록 UI -->
		<div class="music-tab2">
		    	<button class="tab-btn2" onclick="switchToMusicList()">음악 목록</button>
		    	<button class="tab-btn2 active2">재생 목록</button>
		</div>
		<div class="music-layout2">
		    <div class="music-left2">
		    	<% if (mplist != null && !mplist.isEmpty()) {
					     for (MplistBean m : mplist) { %>
					    <div class="playlist-box2"
					         data-mplist-id="<%= m.getMplist_id() %>"
					         data-mplist-name="<%= m.getMplist_name() %>"
					         data-mplist-img="<%= m.getMplist_img() %>"
					         data-mplist-cnt="<%= m.getMplist_cnt() %>">
					        <img src="img/<%= m.getMplist_img() != null ? m.getMplist_img() : "default.png" %>" alt="">
					        <div class="playlist-name2"><%= m.getMplist_name() %></div>
					        <div class="playlist-count2">곡 수</div>
					        <img class="iconDelete2" src="icon/아이콘_삭제_1.png" alt="삭제">
					    </div>
					<% }
					} else { %>
					    <div style="color:white;">재생 목록이 없습니다.</div>
				<% } %>
		        <div class="add-playlist2" onclick = "addPlaylistBox_detail()">+</div>
		    </div>
		
		    <!-- 왼쪽 영역 -->
		    <div class="music-middle2">
		    	<!-- 상단 타이틀 -->
			    <div class="header-title2">
			        <span id="headerMplistName">재생 목록 이름</span>
			        <img class="iconMusicList3" src="icon/아이콘_수정_1.png" alt="수정" >
			    </div>
			    
		    	<!-- 재생 목록 탭 -->    
		        <div class="music-header2">
				    <!-- 왼쪽: 전체 선택 -->
				    <div class="header-left2">
				        <input type="checkbox" id="selectAll_detail">
				        <label for="selectAll2">전체 선택</label>
				    </div>
				
				    <!-- 오른쪽: 정렬/검색 -->
				    <div class="header-right2">
				        <img class="iconMusicList2" src="icon/아이콘_글자순_1.png" alt="글자 순 정렬" onclick="sortMusicList()">
				        <input class="music-search2" type="text" placeholder="음악 제목 검색" oninput="searchMusic()"/>
				        <img class="iconMusicList2" src="icon/아이콘_검색_1.png" alt="검색" >
				    </div>
				</div>
		
		
		        <div class="music-list2" id="musicList_detail">
		        	<% if (bgm != null && !bgm.isEmpty()) {
					     for (BgmBean b : bgm) {
					%>
					    <div class="music-list-item2">
					        <input type="checkbox" name="bgm_id" value="<%= b.getBgm_id() %>" />
					        <span><%= b.getBgm_name() %></span>
					    </div>
					<%  }
					   } else { %>
					    <div class="music-list-item2" style="color:white;">재생 가능한 음악이 없습니다.</div>
					<% } %>
		        </div>
		
		        <div class="music-footer2">
		            <button class="btn-red delete-selected_detail">삭제</button>
		        </div>
		    </div>
		</div>
	</div>
	<!-- 오른쪽 영역 -->
	<div class="music-right2">
	
	  <!-- 🔹 재생목록 정보 -->
	  <div id="playlistPreview">
	    <!-- 재생목록용 아이콘 -->
	    <div class="preview-icons2" style="display: none;">
	      <img id="editIcon2" class="iconMusicList2" src="icon/아이콘_수정_1.png" alt="재생 목록 수정">
	      <img class="iconMusicList2" src="icon/아이콘_삭제_1.png" alt="삭제">
	    </div>
	
	    <div class="music-preview2">
	      <img id="mplistImg" class="musicImg2" src="img/default.png" alt="기본 이미지" />
	      <div id="mplistName_detail" class="editable-title">재생목록을 선택해주세요.</div>
	    </div>
	
	    <div class="music-description2">
	      <textarea id="mplistCnt_detail" readonly>재생목록을 선택해주세요.</textarea>
	    </div>
	
	    <div class="music-right-buttons2" style="display: none;">
	      <button class="btn-purple" onclick="submitEditForm()">수정</button>
	    </div>
	
	    <!-- 수정 폼 -->
	    <form id="mplistEditForm_detail"
	          method="post"
	          action="<%= request.getContextPath() %>/jspproject/mplistUpdate"
	          enctype="multipart/form-data"
	          style="display:none;">
	      <input type="hidden" name="mplist_id" id="hiddenMplistId_detail" value="">
	      <input type="hidden" name="mplist_name" id="hiddenMplistName_detail">
	      <input type="hidden" name="mplist_cnt" id="hiddenMplistCnt_detail">
	      <input type="hidden" name="original_img" id="originalImgInput_detail">
	      <input type="file" name="mplist_img" id="mplistImgInput_detail" onchange="uploadMplistImage(event)">
	    </form>
	  </div>
	
	  <!-- 🔸 음악 미리보기 -->
	  <div id="musicPreview" style="display: none;"></div>
</div>


<script>
	document.addEventListener('DOMContentLoaded', function () {
	    const selectAll = document.getElementById('selectAll_detail');
	    const musicList = document.getElementById('musicList_detail');
	    const deleteBtn = document.querySelector('.delete-selected_detail');
	    const musicLeft = document.querySelector(".music-left2");
	    const previewIcons = document.querySelector('.preview-icons2');
	    const rightButtons = document.querySelector('.music-right-buttons2');
	    const editIcon = document.getElementById('editIcon2');
	    let isEditing = false;
	    let currentBgmList = [];
	    let currentBgmIndex = -1;

	
	    // ✅ 전체 선택 체크박스
	    if (selectAll && musicList && deleteBtn) {
	        selectAll.addEventListener('change', function () {
	            const checkboxes = musicList.querySelectorAll('input[type="checkbox"]');
	            checkboxes.forEach(cb => cb.checked = selectAll.checked);
	        });
	
	        musicList.addEventListener('change', function (e) {
	            if (e.target.type === 'checkbox') {
	                const checkboxes = musicList.querySelectorAll('input[type="checkbox"]');
	                const checkedCount = Array.from(checkboxes).filter(cb => cb.checked).length;
	                selectAll.checked = checkedCount === checkboxes.length;
	            }
	        });
	
	        deleteBtn.addEventListener('click', function () {
	            const items = musicList.querySelectorAll('.music-list-item2');
	            const idsToDelete = [];

	            items.forEach(item => {
	                const checkbox = item.querySelector('input[type="checkbox"]');
	                if (checkbox && checkbox.checked) {
	                    const id = item.dataset.mplistmgrId;
	                    if (id) idsToDelete.push(parseInt(id));
	                }
	            });

	            if (idsToDelete.length === 0) {
	                alert("삭제할 곡을 선택해주세요.");
	                return;
	            }

	            if (!confirm("선택한 곡들을 재생목록에서 삭제하시겠습니까?")) return;

	            // 여러 개 삭제를 하나씩 보내는 방식으로 처리
	            Promise.all(idsToDelete.map(id =>
	                fetch("<%= request.getContextPath() %>/jspproject/deleteMplistBgm", {
	                    method: "POST",
	                    headers: {
	                        "Content-Type": "application/json"
	                    },
	                    body: JSON.stringify({ mplistmgr_id: id })
	                })
	            ))
	            .then(() => {
	                alert("삭제 완료!");
	                const currentMplistId = document.getElementById("hiddenMplistId_detail").value;
	                loadMusicListByMplistId(currentMplistId);
	                document.getElementById("playlistPreview").style.display = "block";
	                document.getElementById("musicPreview").style.display = "none";
	                selectAll.checked = false;
	            })
	            .catch(err => {
	                console.error("삭제 실패:", err);
	                alert("삭제 중 오류 발생");
	            });
	        });

	    }
	
	    // ✅ 재생목록 클릭 이벤트
	    musicLeft.addEventListener("click", function (e) {
		    const box = e.target.closest(".playlist-box2");
		    if (!box || e.target.classList.contains("iconDelete2")) return;
		
		    document.querySelectorAll(".playlist-box2").forEach(el => el.classList.remove("selected"));
		    box.classList.add("selected");
		
		    const id = box.dataset.mplistId;
		    const name = box.dataset.mplistName;
		    const img = box.dataset.mplistImg || "default.png";
		    const cnt = box.dataset.mplistCnt;
		
		    // 🔥 복원
		    document.getElementById("playlistPreview").style.display = "block";
		    document.getElementById("musicPreview").style.display = "none";
		    document.getElementById("musicPreview").innerHTML = "";
		
		    document.getElementById("mplistImg").src = "<%= request.getContextPath() %>/jspproject/img/" + img;
		    document.getElementById("mplistName_detail").innerText = name;
		    document.getElementById("mplistCnt_detail").innerText = cnt;
		
		    document.getElementById("hiddenMplistId_detail").value = id;
		    document.getElementById("hiddenMplistName_detail").value = name;
		    document.getElementById("hiddenMplistCnt_detail").value = cnt;
		    document.getElementById("originalImgInput_detail").value = img;
		
		    previewIcons.style.display = 'flex';
		    rightButtons.style.display = 'flex';
		
		    loadMusicListByMplistId(id); // 중앙 리스트도 갱신
		});

	    // ✅ 수정 아이콘
	    if (editIcon) {
	    editIcon.addEventListener('click', () => {
	        const nameField = document.getElementById('mplistName_detail');
	        const cntField = document.getElementById('mplistCnt_detail');
	
	        isEditing = !isEditing;
	
	        nameField.setAttribute('contenteditable', isEditing ? "true" : "false");
	        cntField.readOnly = !isEditing; // textarea는 readOnly로 컨트롤
	        cntField.style.backgroundColor = isEditing ? "#2e2e2e" : "transparent";
	        cntField.style.border = isEditing ? "1px dashed white" : "none";
	
	        rightButtons.style.pointerEvents = isEditing ? 'auto' : 'none';
	        rightButtons.style.opacity = isEditing ? '1' : '0.5';
	    });
	}

	    // ✅ 삭제 아이콘
	    const deleteIcon = document.querySelector('.preview-icons2 img[alt="삭제"]');
	    if (deleteIcon) {
	        deleteIcon.addEventListener('click', () => {
	            const id = document.getElementById("hiddenMplistId_detail").value;
	            if (!id) return alert("삭제할 재생목록이 선택되지 않았습니다.");
	            if (!confirm("정말 삭제하시겠습니까?")) return;
	
	            fetch('<%= request.getContextPath() %>/jspproject/mplistDelete', {
	                method: 'POST',
	                headers: { 'Content-Type': 'application/json' },
	                body: JSON.stringify({ mplist_id: parseInt(id) })
	            })
	            .then(res => res.json())
	            .then(data => {
	                if (data.success) {
	                    alert("삭제 완료!");
	                    location.reload();
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
	    
	    const mplistImg = document.getElementById("mplistImg");
	    if (mplistImg) {
	        mplistImg.style.cursor = "pointer"; // 마우스 커서도 바뀌게
	        mplistImg.addEventListener("click", () => {
	            document.getElementById("mplistImgInput_detail").click();
	        });
	    }
	    
	    function searchMusic() {
	        const searchText = document.querySelector('.music-search2').value.toLowerCase(); // 입력한 텍스트 소문자로 변환
	        const musicItems = document.querySelectorAll('.music-list-item2'); // 음악 목록 아이템을 선택

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
	        const musicListContainer = document.getElementById('musicList_detail');
	        const musicItems = Array.from(musicListContainer.getElementsByClassName('music-list-item2'));

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

	    // 페이지 로드 시 음악 목록의 순서를 저장
	    function storeOriginalMusicList() {
	        const musicListContainer = document.getElementById('musicList_detail');
	        const musicItems = Array.from(musicListContainer.getElementsByClassName('music-list-item2'));
	        originalOrder = [...musicItems]; // 원본 순서를 저장
	    }

	    // 페이지가 로드될 때 originalMusicList를 저장하도록
	    document.addEventListener('DOMContentLoaded', function() {
	        storeOriginalMusicList();
	    });

	    // 이벤트 연결
	    const sortBtn = document.querySelector('.iconMusicList2');
	    if (sortBtn) {
	        sortBtn.addEventListener('click', sortMusicList);
	    }

	    const searchInput = document.querySelector('.music-search2');
	    if (searchInput) {
	        searchInput.addEventListener('input', searchMusic);
	    }

});
	
	// ✅ 곡 삭제 아이콘 클릭 시 삭제 처리
	document.addEventListener("click", function (e) {
	    if (e.target && e.target.classList.contains("delete-bgm")) {
	        const mplistmgrId = e.target.dataset.mplistmgrId;
	        if (!mplistmgrId) {
	            alert("삭제할 항목 ID를 찾을 수 없습니다.");
	            return;
	        }

	        if (!confirm("정말 이 곡을 재생목록에서 삭제할까요?")) return;

	        fetch("<%= request.getContextPath() %>/jspproject/deleteMplistBgm", {
	            method: "POST",
	            headers: {
	                "Content-Type": "application/json"
	            },
	            body: JSON.stringify({ mplistmgr_id: parseInt(mplistmgrId) })
	        })
	        .then(res => res.json())
	        .then(data => {
	            if (data.success) {
	                alert("삭제되었습니다.");
	                // 목록 갱신
	                const currentMplistId = document.getElementById("hiddenMplistId_detail").value;
	                loadMusicListByMplistId(currentMplistId);
	                document.getElementById("playlistPreview").style.display = "block";
	                document.getElementById("musicPreview").style.display = "none";
	            } else {
	                alert("삭제 실패: " + data.message);
	            }
	        })
	        .catch(err => {
	            console.error("삭제 오류:", err);
	            alert("서버 오류가 발생했습니다.");
	        });
	    }
	});


	function addPlaylistBox_detail() {
	    const musicLeft = document.querySelector('#musicPlayListDetailWrapper .music-left2');
	    const addButton = document.querySelector('#musicPlayListDetailWrapper .add-playlist2');
	    if (!musicLeft || !addButton) return;

	    const playlistCount = musicLeft.querySelectorAll('.playlist-box2').length + 1;

	    // 프론트에 추가
	    const newBox = document.createElement('div');
	    newBox.className = 'playlist-box2';
	    newBox.innerHTML =
	        '<img src="img/default.png" alt="">' +
	        '<div class="playlist-name2">제목을 지어주세요</div>' +
	        '<div class="playlist-count2">내용을 정해주세요</div>' +
	        '<img class="iconDelete2" src="icon/아이콘_삭제_1.png" alt="삭제">';
	    musicLeft.insertBefore(newBox, addButton);

	    // 서버(DB)에 추가 요청
	    const formData = new FormData();
	    formData.append("mplist_name", "제목을 지어주세요");
	    formData.append("mplist_cnt", "내용을 정해주세요");
	    formData.append("user_id", "<%= user_id %>");
	    formData.append("mplist_img", "default.png"); // ✅ 문자열로 직접 전달

	    fetch("<%= request.getContextPath() %>/jspproject/mplistInsert", {
	        method: "POST",
	        body: formData
	    })
	    .then(res => res.text())
	    .then(text => {
	        console.log("DB 추가 완료:", text);
	        // 필요한 경우 서버 응답에 따라 박스에 ID나 데이터셋 추가 가능
	        window.location.href = "<%= request.getContextPath() %>/jspproject/mainScreen.jsp";
	    })
	    .catch(err => {
	        console.error("재생목록 추가 실패:", err);
	        alert("서버에 재생목록 추가 중 오류가 발생했습니다.");
	    });
	}


	document.addEventListener("DOMContentLoaded", function () {
	    const musicLeft = document.querySelector(".music-left2");
	    musicLeft.addEventListener("click", function (e) {
	        if (e.target.classList.contains("iconDelete2")) {
	            const box = e.target.closest(".playlist-box2");
	            if (box) box.remove();
	        }
	    });
	});

	function switchToMusicList() {
	    const musicListContainer = document.querySelector('.music-container');
	    const playListContainer = document.querySelector('#musicPlayListWrapper');
	    const detailContainer = document.querySelector('#musicPlayListDetailWrapper');
	    if (playListContainer) playListContainer.style.display = 'none';
	    if (detailContainer) detailContainer.style.display = 'none';
	    if (musicListContainer) musicListContainer.style.display = 'flex';
	}

	function previewImage(event) {
	    const reader = new FileReader();
	    reader.onload = function (e) {
	    	document.getElementById('mplistImg').src = "mplistImg/" + e.target.result;
	    };
	    reader.readAsDataURL(event.target.files[0]);
	}

	function submitEditForm() {
		const form = document.getElementById("mplistEditForm_detail");

	    // 혹시라도 빠진 경우 대비해서 강제로 다시 세팅
	    const selectedBox = document.querySelector(".playlist-box2.selected");
	    if (selectedBox) {
	        form.querySelector("input[name='mplist_id']").value = selectedBox.dataset.mplistId;
	    }

	    // ✅ 이미 위에서 const로 id 선언했으니 여기선 다시 선언하지 말고 그냥 변수만 사용
	    const id = form.querySelector("input[name='mplist_id']").value;
	    console.log("최종 제출 mplist_id:", id);

	    if (!id || id.trim() === "") {
	        alert("재생목록이 선택되지 않았습니다.");
	        return;
	    }

	    // 제목과 내용 가져오기
	    const name = document.getElementById("mplistName_detail").innerText.trim();
		const cnt = document.getElementById("mplistCnt_detail").value.trim();

	    // 히든에 반영
	    document.getElementById('hiddenMplistName_detail').value = name;
	    document.getElementById('hiddenMplistCnt_detail').value = cnt;

	    // 편집 종료
	    document.getElementById('mplistName_detail').setAttribute('contenteditable', 'false');
	    document.getElementById('mplistCnt_detail').setAttribute('contenteditable', 'false');
	    document.querySelector('.music-right-buttons2').style.display = 'none';

	    form.submit();
	}
	
	function uploadMplistImage(event) {
	    const file = event.target.files[0];
	    if (!file) return;

	    const mplistId = document.getElementById("hiddenMplistId_detail").value;
	    if (!mplistId) {
	        alert("먼저 재생목록을 선택해주세요.");
	        return;
	    }

	    const formData = new FormData();
	    formData.append("mplist_id", mplistId);
	    formData.append("mplist_img", file);

	    fetch("<%= request.getContextPath() %>/jspproject/mplistImageUpdate", {
	        method: "POST",
	        body: formData
	    })
	    .then(res => res.json())
	    .then(data => {
	        if (data.success) {
	        	document.getElementById("mplistImg").src = "mplistImg/" + data.filename + "?t=" + new Date().getTime();
	            alert("이미지가 성공적으로 변경되었습니다.");
	        } else {
	            alert("업로드 실패: " + data.message);
	        }
	    })
	    .catch(err => {
	        console.error(err);
	        alert("이미지 업로드 중 오류 발생");
	    });
	}
	
	function loadMusicListByMplistId(mplistId) {
	    fetch("<%= request.getContextPath() %>/jspproject/getBgmByBgmId.jsp?mplist_id=" + mplistId)
	        .then(response => response.text())
	        .then(html => {
	            const container = document.getElementById("musicList_detail");
	            container.innerHTML = html;

	            // ✅ 음악 리스트 캐싱
	            currentBgmList = Array.from(container.querySelectorAll('.music-list-item2'));

	            // ✅ 클릭 이벤트 연결
	            currentBgmList.forEach((item, index) => {
	                item.addEventListener('click', function () {
	                    const bgmId = item.querySelector('input[name="bgm_id"]').value;
	                    currentBgmIndex = index;
	                    loadMusicPreviewByBgmId(bgmId, true);

	                });
	            });
	        })
	        .catch(error => {
	            console.error("❌ 음악 리스트 로딩 실패:", error);
	        });
	}
	
	function loadMusicPreviewByBgmId(bgmId, autoPlay = false) {
		  fetch("<%= request.getContextPath() %>/jspproject/getBgmIdByMplistId.jsp?bgm_id=" + bgmId)
		    .then(res => res.text())
		    .then(html => {
		      document.getElementById("playlistPreview").style.display = "none";
		      const preview = document.getElementById("musicPreview");
		      preview.style.display = "block";
		      preview.innerHTML = html;

		      // 🎯 새로 삽입된 audio와 버튼 이벤트 연결
		      setTimeout(() => {
				  const audio = document.getElementById("playListAudioPlayer");
				  const playBtn = document.getElementById("playToggleBtn2");
				
				  // ✅ 기존 mainAudioPlayer 정지
				  const mainAudio = document.getElementById("mainAudioPlayer");
				  if (mainAudio && !mainAudio.paused) {
				    mainAudio.pause();
				    mainAudio.currentTime = 0;
				  }
				
				  // 기존 코드 유지
				  if (!audio || !playBtn) return;

		        // autoPlay일 경우에만 재생
		        if (autoPlay) {
				  playBtn.src = "icon/아이콘_일시정지_1.png";
				  playBtn.setAttribute("data-state", "playing");
				  audio.play();
				}	
		        // ✅ onoff 상태 갱신은 항상 수행
		        const mplistId = document.getElementById("hiddenMplistId_detail").value;
		        updateOnOffStates(bgmId, mplistId);

		        // 재생 끝나면 다음 곡으로
		        audio.onended = () => {
		          fetch("<%= request.getContextPath() %>/jspproject/bgmOnOff", {
		            method: "POST",
		            headers: { "Content-Type": "application/json" },
		            body: JSON.stringify({ bgm_id: parseInt(bgmId), bgm_onoff: 0 })
		          }).then(() => {
		            playNextMusicInPlaylist();
		          });
		        };

		        bindMusicPreviewControls();
		      }, 100);
		 	});
	}
	
	// ✅ 전역 변수
	window.currentBgmList = [];  // 음악 목록
	window.currentBgmIndex = -1; // 현재 곡의 인덱스

	// ✅ 다음곡 재생
	function playNextMusicInPlaylist() {
	  if (window.currentBgmIndex === -1 || window.currentBgmIndex + 1 >= window.currentBgmList.length) {
	    alert("다음 곡이 없습니다.");
	    return;
	  }
	
	  // 현재 곡 종료
	  const currentId = window.currentBgmList[window.currentBgmIndex].querySelector('input[name="bgm_id"]').value;
	  fetch('<%= request.getContextPath() %>/jspproject/bgmOnOff', {
	    method: 'POST',
	    headers: { 'Content-Type': 'application/json' },
	    body: JSON.stringify({ bgm_id: parseInt(currentId), bgm_onoff: 0 })
	  });
	
	  // 다음 곡 인덱스 증가 및 정보 가져오기
	  window.currentBgmIndex++;
	  const nextItem = window.currentBgmList[window.currentBgmIndex];
	  const nextId = nextItem.querySelector('input[name="bgm_id"]').value;
	
	  loadMusicPreviewByBgmId(nextId);
	
	  // 🔥 자동 재생 + 메인 동기화
	  setTimeout(() => {
	    const nextAudio = document.getElementById("playListAudioPlayer");
	    const nextBtn = document.getElementById("playToggleBtn2");
	    if (nextAudio && nextBtn) {
	      // bgm_onoff = 1로
	      fetch('<%= request.getContextPath() %>/jspproject/bgmOnOff', {
	        method: 'POST',
	        headers: { 'Content-Type': 'application/json' },
	        body: JSON.stringify({ bgm_id: parseInt(nextId), bgm_onoff: 1 })
	      }).then(response => response.json())
	        .then(data => {
	          if (!data.success) {
	            console.error("bgm_onoff 갱신 실패", data.message);
	          } else {
	            nextAudio.play();
	            nextBtn.src = "icon/아이콘_일시정지_1.png";
	            nextBtn.setAttribute("data-state", "playing");
	          }
	        })
	        .catch(err => {
	          console.error("bgm_onoff 갱신 실패", err);
	        });
	    }
	  }, 500);
	}

	// ✅ 이전곡 재생
	function playPrevMusicInPlaylist() {
	  if (window.currentBgmIndex <= 0) {
	    alert("이전 곡이 없습니다.");
	    return;
	  }
	
	  // 현재 음악 종료 처리
	  const currentId = window.currentBgmList[window.currentBgmIndex].querySelector('input[name="bgm_id"]').value;
	
	  fetch('<%= request.getContextPath() %>/jspproject/bgmOnOff', {
	    method: 'POST',
	    headers: { 'Content-Type': 'application/json' },
	    body: JSON.stringify({ bgm_id: parseInt(currentId), bgm_onoff: 0 })
	  });
	
	  // 이전 곡으로 이동
	  window.currentBgmIndex--;
	  const prevId = window.currentBgmList[window.currentBgmIndex].querySelector('input[name="bgm_id"]').value;
	  loadMusicPreviewByBgmId(prevId);
	
	  setTimeout(() => {
	    const prevAudio = document.getElementById("playListAudioPlayer");
	    const prevBtn = document.getElementById("playToggleBtn2");
	    if (prevAudio && prevBtn) {
	      prevAudio.play();
	      prevBtn.src = "icon/아이콘_일시정지_1.png";
	      prevBtn.setAttribute("data-state", "playing");
	
	      updateOnOffStates(prevId, document.getElementById("hiddenMplistId_detail").value);

	    }
	  }, 500);
	}

	// ✅ 재생 버튼, 다음/이전 버튼 연결
	function bindMusicPreviewControls() {
	  const playBtn = document.getElementById("playToggleBtn2");
	  const audio = document.getElementById("playListAudioPlayer");
	  const bgmId = playBtn ? parseInt(playBtn.dataset.bgmId) : null;

	  if (!playBtn || !audio || !bgmId) return;

	  playBtn.onclick = () => {
		  const isPaused = playBtn.getAttribute("data-state") === "paused";
		  const newOnoff = isPaused ? 1 : 0;

		  // ✅ bgm_onoff 서버 반영
		  fetch('<%= request.getContextPath() %>/jspproject/bgmOnOff', {
		    method: 'POST',
		    headers: { 'Content-Type': 'application/json' },
		    body: JSON.stringify({ bgm_id: bgmId, bgm_onoff: newOnoff })
		  });

		  if (isPaused) {
		    // ▶️ → ⏸️
		    audio.play();
		    playBtn.src = "icon/아이콘_일시정지_1.png";
		    playBtn.setAttribute("data-state", "playing");
		  } else {
		    // ⏸️ → ▶️
		    audio.pause();
		    playBtn.src = "icon/아이콘_재생_1.png";
		    playBtn.setAttribute("data-state", "paused");
		  }
		};

	  audio.onended = () => {
	    fetch('<%= request.getContextPath() %>/jspproject/bgmOnOff', {
	      method: 'POST',
	      headers: { 'Content-Type': 'application/json' },
	      body: JSON.stringify({ bgm_id: bgmId, bgm_onoff: 0 })
	    }).then(() => {
	      // ✅ 다음 곡 재생 후 자동으로 play() 호출
	      if (window.currentBgmIndex + 1 < window.currentBgmList.length) {
	        window.currentBgmIndex++;
	        const nextId = window.currentBgmList[window.currentBgmIndex].querySelector('input[name="bgm_id"]').value;
	        loadMusicPreviewByBgmId(nextId, true);

	        // 💡 약간의 지연 후 자동 재생 보장
	        setTimeout(() => {
	          const nextAudio = document.getElementById("playListAudioPlayer");
	          const nextBtn = document.getElementById("playToggleBtn2");
	          if (nextAudio && nextBtn) {
	            nextAudio.play();
	            nextBtn.src = "icon/아이콘_일시정지_1.png";
	            nextBtn.setAttribute("data-state", "playing");
	          }
	        }, 500);
	      } else {
	        alert("마지막 곡입니다.");
	      }
	    });
	  };

	  document.querySelector('.next-btn')?.addEventListener('click', playNextMusicInPlaylist);
	  document.querySelector('.prev-btn')?.addEventListener('click', playPrevMusicInPlaylist);
	}

	// 전역 등록
	window.playNextMusicInPlaylist = playNextMusicInPlaylist;
	window.playPrevMusicInPlaylist = playPrevMusicInPlaylist;
	window.loadMusicPreviewByBgmId = loadMusicPreviewByBgmId;
	window.loadMusicListByMplistId = loadMusicListByMplistId;

	
	let lastMplistId = null;  // 마지막 재생 중이던 재생목록 기억용

	function updateOnOffStates(bgmId, mplistId) {
	  // ✅ 이전 재생목록 off
	  if (lastMplistId && lastMplistId !== mplistId) {
	    fetch('<%= request.getContextPath() %>/jspproject/mplistOnOff', {
	      method: 'POST',
	      headers: { 'Content-Type': 'application/json' },
	      body: JSON.stringify({ mplist_id: parseInt(lastMplistId), mplist_onoff: 0 })
	    });
	  }

	  // ✅ 현재 재생곡 on
	  fetch('<%= request.getContextPath() %>/jspproject/bgmOnOff', {
	    method: 'POST',
	    headers: { 'Content-Type': 'application/json' },
	    body: JSON.stringify({ bgm_id: parseInt(bgmId), bgm_onoff: 1 })
	  });

	  // ✅ 현재 재생목록 on
	  fetch('<%= request.getContextPath() %>/jspproject/mplistOnOff', {
	    method: 'POST',
	    headers: { 'Content-Type': 'application/json' },
	    body: JSON.stringify({ mplist_id: parseInt(mplistId), mplist_onoff: 1 })
	  });

	  // ✅ 현재 재생목록 기억
	  lastMplistId = mplistId;
	}
	
	
    
</script>