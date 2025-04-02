<!-- mainScreen.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<link href="css/style.css" rel="stylesheet" type="text/css">
<%
%>

<!-- 프로필 아이콘 -->
<img class = "iconLeftUp" src="icon/아이콘_프로필_1.png" border="0" alt=""> 

<!-- 오른쪽 상단 아이콘들-->
<div class="icon-container">
    <img class="iconRightUp allscreen" src="icon/아이콘_전체화면_1.png" border="0" alt="전체화면" onclick="toggleFullScreen()" > 
    <img class="iconRightUp notifi" src="icon/아이콘_공지사항_1.png" border="0" alt="공지사항 확인"> 
    <img class="iconRightUp tema" src="icon/아이콘_배경_2.png" border="0" alt="배경화면 설정"> 
    <img class="iconRightUp darkmode" src="icon/아이콘_다크모드_3.png" border="0" alt="다크모드로 변경"> 
    <img class="iconRightUp uioff" src="icon/아이콘_UI끄기_1.png" border="0" alt="UI 끄기" onclick="toggleUI()">
    <img class="iconRightUp logout" src="icon/아이콘_로그아웃_1.png" border="0" alt="로그아웃"> 
</div>

<!-- 음악 설정 쪽 아이콘-->
<div class="iconMusic-container">
	<img class="iconMusic" src="icon/아이콘_재생_1.png" border="0" alt="음악 재생" > 
	<img class="iconMusic" src="icon/아이콘_셔플_1.png" border="0" alt="음악 랜덤" > 
	<img class="iconMusic" src="icon/아이콘_반복_1.png" border="0" alt="음악 반복" > 
	<img class="iconMusic" src="icon/아이콘_이전음악_1.png" border="0" alt="이전 음악 재생" > 
	<img class="iconMusic" src="icon/아이콘_다음음악_1.png" border="0" alt="다음 음악 재생" > 
	<img class="iconMusic" src="icon/아이콘_볼륨_1.png" border="0" alt="볼륨 음소거" > 
</div>

<!-- 음악 볼륨바 표시-->
<div class = "iconMusicVolumbar-container">
	<img class="iconMusicVolum" src="icon/아이콘_볼륨바_2.png" border="0" alt="볼륨 조절1" >
	<img class="iconMusicVolum" src="icon/아이콘_볼륨바_2.png" border="0" alt="볼륨 조절2" >
	<img class="iconMusicVolum" src="icon/아이콘_볼륨바_2.png" border="0" alt="볼륨 조절3" >
	<img class="iconMusicVolum" src="icon/아이콘_볼륨바_2.png" border="0" alt="볼륨 조절4" >
	<img class="iconMusicVolum" src="icon/아이콘_볼륨바_2.png" border="0" alt="볼륨 조절5" >
	<img class="iconMusicVolum" src="icon/아이콘_볼륨바_2.png" border="0" alt="볼륨 조절6" >
	<img class="iconMusicVolum" src="icon/아이콘_볼륨바_2.png" border="0" alt="볼륨 조절7" >
	<img class="iconMusicVolum" src="icon/아이콘_볼륨바_2.png" border="0" alt="볼륨 조절8" >
	<img class="iconMusicVolum" src="icon/아이콘_볼륨바_2.png" border="0" alt="볼륨 조절9" >
	<img class="iconMusicVolum" src="icon/아이콘_볼륨바_2.png" border="0" alt="볼륨 조절10" >
</div>

<!-- 노래 제목 표시-->
<b class = "musicTitle">노래제목 - 예시 어쩌고 저쩌고 제목 길게 나오기 요렇게</b>

<!-- 오른쪽 하단 아이콘들 -->
<div class = "icon-container2">
	<img class="iconRightDown" src="icon/아이콘_음악_1.png" border="0" alt="음악 변경" onclick = "toggleMusicList()">
	<img class="iconRightDown obj" src="icon/아이콘_작업목표_1.png" border="0" alt="작업 목표 설정" >
	<img class="iconRightDown" src="icon/아이콘_타이머_1.png" border="0" alt="타이머 키기" >
	<img class="iconRightDown" src="icon/아이콘_달력_1.png" border="0" alt="통계 보기" >
	<img class="iconRightDown diary" src="icon/아이콘_일기_1.png" border="0" alt="일지 설정" onclick = "toggleJournalList()">
</div>

<!-- 음악 리스트 영역 (처음엔 숨김) -->
<div id="musicListWrapper" style="display:none;">
    <jsp:include page="musicList.jsp" />
</div>

<!-- 일지 설정 영역 (처음엔 숨김) -->
<div id="journalWrapper" style="display:none;">
    <jsp:include page="journal.jsp" />
</div>

<!-- JavaScript 함수 -->
<script>

	let uiVisible = true;
	function toggleUI() { /* UI 껐다 키는 기능 */
	    // 숨기고 싶은 UI 요소들을 선택
	    const uiElements = document.querySelectorAll('.iconLeftUp, .iconRightUp:not(.uioff), .iconMusic, .iconMusicVolumbar-container, .musicTitle, .iconRightDown, .icon-container2');
	
	    // uioff와 로그아웃 버튼은 항상 보이도록 설정
	    const uioffButton = document.querySelector('.uioff');
	    const logoutButton = document.querySelector('.logout');
	
	    // 상태 토글
	    if (uiVisible) {
	        // 모든 UI 요소 숨기기
	        uiElements.forEach(element => {
	            element.style.visibility = 'hidden';
	        });
	        // uioff와 로그아웃 버튼만 보이게 하기
	        uioffButton.style.visibility = 'visible';
	        logoutButton.style.visibility = 'visible';
	
	        // UI 키기 아이콘으로 변경
	        uioffButton.src = "icon/아이콘_UI키기_1.png";
	        uiVisible = false; // UI가 숨겨졌다는 상태로 설정
	    } else {
	        // 모든 UI 요소 다시 보이게 하기
	        uiElements.forEach(element => {
	            element.style.visibility = 'visible';
	        });
	        // uioff와 로그아웃 버튼은 계속 보이게 유지
	        uioffButton.style.visibility = 'visible';
	        logoutButton.style.visibility = 'visible';
	
	        // UI 끄기 아이콘으로 변경
	        uioffButton.src = "icon/아이콘_UI끄기_1.png";
	        uiVisible = true; // UI가 보인다는 상태로 설정
	    }
	}
	
	// 전체화면 on/off
	function toggleFullScreen() { /* 전체화면 껐다 키는 기능 */
		if (!document.fullscreenElement) { // 전체화면 모드가 아닌 경우
		    document.documentElement.requestFullscreen(); // HTML 요소를 전체화면 모드로
		} else { // 전체화면 모드인 경우
		    document.exitFullscreen();
		}
	}
	
	// 음악 리스트 on/off
	function toggleMusicList() {
        var musicDiv = document.getElementById("musicListWrapper");
        musicDiv.style.display = (musicDiv.style.display === "none") ? "block" : "none";
    }
	
	// 음악 리스트 on/off
	function toggleJournalList() {
        var journalDiv = document.getElementById("journalWrapper");
        journalDiv.style.display = (journalDiv.style.display === "none") ? "block" : "none";
    }
	
	
</script>