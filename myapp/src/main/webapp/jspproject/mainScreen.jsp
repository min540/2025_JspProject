
<!-- mainScreen.jsp -->
<%@page import="jspproject.DBConnectionMgr"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jspproject.NotifiMgr"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<link href="css/style.css?v=2" rel="stylesheet" type="text/css">
<%@ page import="jspproject.UserBean" %>
<jsp:useBean id="lmgr" class="jspproject.LoginMgr"/>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<%
    String path = request.getContextPath();
    String user_id = (String) session.getAttribute("user_id");

    // ✅ 배경 초기값 (기본값)
  String appliedBackground = request.getContextPath() + "/jspproject/backgroundImg/tema1.jpg";

    if (user_id != null && !user_id.trim().equals("")) {
        // ✅ 현재 적용된 테마 이미지 가져오기
        jspproject.TemaMgr temaMgr = new jspproject.TemaMgr();
        jspproject.TemaBean currentTema = temaMgr.getOnTema(user_id);
        if (currentTema != null && currentTema.getTema_img() != null) {
        	appliedBackground = request.getContextPath() + "/jspproject/backgroundImg/" + currentTema.getTema_img();

        }

        // 🔔 알림용 날짜 처리
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String currentDate = sdf.format(new Date());

        // NotifiMgr 호출
        NotifiMgr notifiMgr = new NotifiMgr();
        notifiMgr.objEnd(user_id, currentDate);

        List<String> alertMessages = new ArrayList<>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DBConnectionMgr pool = DBConnectionMgr.getInstance();

        try {
            con = pool.getConnection();

            String sql = "SELECT o.obj_id, o.obj_title, o.obj_edate " +
                         "FROM obj o " +
                         "WHERE o.user_id = ? AND o.obj_check = 0 " +
                         "AND (DATE(o.obj_edate) = CURDATE() OR DATE(o.obj_edate) = DATE_SUB(CURDATE(), INTERVAL 1 DAY))";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, user_id);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String title = rs.getString("obj_title");
                Date edate = rs.getDate("obj_edate");

                String formattedDate = sdf.format(edate);

                if (formattedDate.equals(currentDate)) {
                    alertMessages.add("작업 목표 마감일 알림: '" + title + "'의 마감일이 오늘입니다.");
                } else {
                    alertMessages.add("작업 목표 마감일 지남 알림: '" + title + "'의 마감일이 지났습니다.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            if (con != null) pool.freeConnection(con);
        }

        if (!alertMessages.isEmpty()) {
            session.setAttribute("alertMessages", alertMessages);
        }
    }

    List<String> alertMessages = (List<String>) session.getAttribute("alertMessages");
    if (alertMessages != null && !alertMessages.isEmpty()) {
        session.removeAttribute("alertMessages");
%>

<div class="modal-container" id="notificationModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">작업 목표 마감일 알림</h3>
            <button class="modal-close" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
            <% for (String message : alertMessages) { %>
                <div class="notification-item"><%= message %></div>
            <% } %>
        </div>
        <div class="modal-footer">
            <button class="btn" onclick="closeModal()">확인</button>
        </div>
    </div>
</div>

	<!-- 작업 목록 알림 소리 플레이어 -->
	<audio id="notifiaudio">
		<source src="sound/alarm.mp3" type="audio/mp3">
		<!--  Your browser does not support the audio element.-->
	</audio>
   <% } %>
   <body style="background-image: url('<%= appliedBackground %>'); background-size: cover;">
<!-- 프로필 아이콘 -->

<img class = "iconLeftUp" src="icon/아이콘_프로필_1.png" border="0" alt="" onclick = "toggleProfile()"> 

<!-- 오른쪽 상단 아이콘들-->
<div class="icon-container">
    <img class="iconRightUp allscreen" src="icon/아이콘_전체화면_1.png" border="0" alt="전체화면" onclick="toggleFullScreen()" > 
    <img class="iconRightUp notifi" src="icon/아이콘_공지사항_1.png" border="0" alt="공지사항 확인" onclick = "toggleAnc()" > 
    <img class="iconRightUp tema" src="icon/아이콘_배경_2.png" border="0" alt="배경화면 설정" onclick = "toggleBackground()"> 
    <img class="iconRightUp darkmode" src="icon/아이콘_다크모드_3.png" border="0" alt="다크모드로 변경"> 
    <img class="iconRightUp uioff" src="icon/아이콘_UI끄기_1.png" border="0" alt="UI 끄기" onclick="toggleUI()">
    <img class="iconRightUp logout" src="icon/아이콘_로그아웃_1.png" border="0" alt="로그아웃" onclick="logout()">
</div>

<!-- 음악 설정 쪽 아이콘-->
<div class="iconMusic-container">
	<span>
		<img id="mainPlayToggleBtn" class="iconMusic" src="icon/아이콘_재생_1.png" border="0" alt="음악 재생" > 
	</span>
	<audio id="mainAudioPlayer" src="music/music1.mp3"></audio>
	<img class="iconMusic" src="icon/아이콘_셔플_1.png" border="0" alt="음악 랜덤" > 
	<img class="iconMusic" src="icon/아이콘_반복_1.png" border="0" alt="음악 반복" > 
	<img class="iconMusic" src="icon/아이콘_이전음악_1.png" border="0" alt="이전 음악 재생" > 
	<img class="iconMusic" src="icon/아이콘_다음음악_1.png" border="0" alt="다음 음악 재생" > 
	<img id="volumeMuteBtn" class="iconMusic" src="icon/아이콘_볼륨_1.png" border="0" alt="볼륨 음소거">
</div>

<!-- 음악 볼륨바 표시-->
<div class="iconMusicVolumbar-container" id="volumeBar">
    <% for (int i = 1; i <= 10; i++) { %>
        <img class="iconMusicVolum" 
             src="icon/아이콘_볼륨바_2.png" 
             border="0" 
             alt="볼륨 조절<%=i%>" 
             data-index="<%=i%>">
    <% } %>
</div>


<!-- 노래 제목 표시-->
<b class = "musicTitle">노래제목 - 예시 어쩌고 저쩌고 제목 길게 나오기 요렇게</b>

<!-- 오른쪽 하단 아이콘들 -->
<div class = "icon-container2">
	<img class="iconRightDown" src="icon/아이콘_음악_1.png" border="0" alt="음악 변경" onclick = "toggleMusicList()">
	<img class="iconRightDown obj" src="icon/아이콘_작업목표_1.png" border="0" alt="작업 목표 설정" onclick = "toggleObjList()">
	<img class="iconRightDown" src="icon/아이콘_타이머_1.png" border="0" alt="타이머 키기" onclick = "toggleTimerList()">
	<img class="iconRightDown" src="icon/아이콘_달력_1.png" border="0" alt="통계 보기" onclick = "toggleGraphView()" >
	<img class="iconRightDown diary" src="icon/아이콘_일기_1.png" border="0" alt="일지 설정" onclick = "toggleJournalList()">
</div>

<!-- 일지 설정 영역 (처음엔 숨김) -->
<div id="journalWrapper" style="display:none;">
    <jsp:include page="journal.jsp" />
</div>



<!-- 통계 설정 영역 (처음엔 숨김) -->
<div id="GraphWrapper" style="display:none;">
    <div id="graph-spark-week" style="display:none;"><jsp:include page="objTotalGraphSpark.jsp" /></div>
    <div id="graph-bar-week" style="display:none;"><jsp:include page="objTotalGraphBar.jsp" /></div>
    <div id="graph-spark-month" style="display:none;"><jsp:include page="objTotalGraphSparkMonth.jsp" /></div>
    <div id="graph-bar-month" style="display:none;"><jsp:include page="objTotalGraphBarMonth.jsp" /></div>
</div>

<!-- 작업 목표 영역 -->
<div id="objWrapper" style="display:none;">
    <jsp:include page="Objective.jsp" />
</div>

<!-- 새로운 리스트 추가 영역 -->
<div id="listCardWrapper" style="display:none;">
    <jsp:include page="List.jsp" />
</div>

<!-- 배경 설정 영역 -->
<div id="backgroundWrapper" style="display:none;">
    <jsp:include page="Background.jsp" />
</div>

<!-- 프로필 -->
<div id="profileWrapper" style="display:none; position: absolute; left: 0; top: 0; height: 100vh; z-index: 9999;">
    <jsp:include page="profile.jsp" />
</div>

<!-- 공지사항 -->
<div id="ancWrapper" style="display: none; position: absolute; left: 1400px; top: 75px; z-index: 9999;">
    <jsp:include page="ancList.jsp" />
</div>

<!-- 타이머 -->
<div id="timerWrapper" style="display: none;">
   <jsp:include page="GetTimerView.jsp" />
</div>

<!-- 타이머 설정 영역 -->
<div id="timerWrapper1" style="display: none;">
    <jsp:include page="TimerDesign.jsp" />
</div>

<!-- 음악 리스트 -->
<div id="musicListWrapper" style="display:none;">
    <jsp:include page="musicList.jsp" />
</div>

<style>
    .modal-container { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); display: flex; align-items: center; justify-content: center; z-index: 9999; }
    .modal-content { background-color: #3c1e5c; color: white; border-radius: 10px; padding: 20px; max-width: 500px; width: 80%; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); }
    .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
    .modal-title { margin: 0; font-size: 18px; }
    .modal-close { background: none; border: none; color: white; font-size: 20px; cursor: pointer; }
    .modal-body { margin-bottom: 20px; }
    .modal-footer { text-align: right; }
    .btn { background-color: rgba(255, 255, 255, 0.2); border: 1px solid white; border-radius: 5px; color: white; padding: 8px 15px; cursor: pointer; transition: background-color 0.3s; }
    .btn:hover { background-color: rgba(255, 255, 255, 0.3); }
    .notification-item { border-left: 3px solid #8e44ad; padding: 10px; margin-bottom: 10px; background-color: rgba(255, 255, 255, 0.1); border-radius: 5px; }
</style>

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
	
	function logout() {
		window.location.href = "<%= request.getContextPath() %>/jspproject/logout";
	}
	
	// 프로필 on/off
	function toggleProfile() {
	    const profileDiv = document.getElementById("profileWrapper");
	    const profileIcon = document.querySelector(".iconLeftUp");
	
	    const isHidden = profileDiv.style.display === "none" || profileDiv.style.display === "";
	
	    // 토글 동작
	    profileDiv.style.display = isHidden ? "block" : "none";
	    profileIcon.style.display = isHidden ? "none" : "block";
	}
	
	// 전체화면 on/off
	function toggleFullScreen() { /* 전체화면 껐다 키는 기능 */
		if (!document.fullscreenElement) { // 전체화면 모드가 아닌 경우
		    document.documentElement.requestFullscreen(); // HTML 요소를 전체화면 모드로
		} else { // 전체화면 모드인 경우
		    document.exitFullscreen();
		}
	}
	
	// 공지사항 리스트 on/off
	function toggleAnc() {
        var ancDiv = document.getElementById("ancWrapper");
        ancDiv.style.display = (ancDiv.style.display === "none") ? "block" : "none";
    }
	
	// 배경 설정 on/off
	function toggleBackground() {
	  const backgroundWrapper = document.getElementById("backgroundWrapper");
	  const timerWrapper1 = document.getElementById("timerWrapper1");
	
	  const isOpen = (backgroundWrapper?.style.display === "flex") || (timerWrapper1?.style.display === "flex");
	
	  [backgroundWrapper, timerWrapper1].forEach(el => {
	    if (el) el.style.display = isOpen ? "none" : (el === backgroundWrapper ? "flex" : "none");
	  });
	}
	
	// 음악 리스트 on/off
	function toggleMusicList() {
        var musicDiv = document.getElementById("musicListWrapper");
        musicDiv.style.display = (musicDiv.style.display === "none") ? "block" : "none";
    }
	
	// 타이머 on/off
	function toggleTimerList() {
        var timerDiv = document.getElementById("timerWrapper");
        timerDiv.style.display = (timerDiv.style.display === "none") ? "block" : "none";
    }
	
	// 일지 설정 on/off
	function toggleJournalList() {
        var journalDiv = document.getElementById("journalWrapper");
        journalDiv.style.display = (journalDiv.style.display === "none") ? "block" : "none";
    }
	
	// 작업 목록 on/off
	function toggleObjList() {
        var objDiv = document.getElementById("objWrapper");
        objDiv.style.display = (objDiv.style.display === "none") ? "block" : "none";
    }
	
	// 통계 관련 설정
	// ✅ 전역 변수
	let lineChart = null;
	let lineMonthChart = null;
	let barWeekGoalChart = null;
	let barWeekMemoChart = null;
	let barMonthGoalChart = null;
	let barMonthMemoChart = null;
	
	function drawWeeklyCompleteChartSpark() {
	    fetch("<%= request.getContextPath() %>/jspproject/getStats.jsp")
	        .then(res => res.json())
	        .then(data => {
	            const labels = ['일', '월', '화', '수', '목', '금', '토'];
	            const values = data.weeklyComplete;

	            const ctx = document.getElementById('myChart')?.getContext('2d');
	            if (!ctx) return;
	            if (lineChart) lineChart.destroy();

	            lineChart = new Chart(ctx, {
	                type: 'line',
	                data: {
	                    labels: labels,
	                    datasets: [{
	                        label: '요일별 목표 완료 수',
	                        data: values,
	                        borderColor: '#4caf50',
	                        backgroundColor: 'rgba(76, 175, 80, 0.3)',
	                        tension: 0.3,
	                        fill: true,
	                        pointRadius: 5,
	                        pointBackgroundColor: '#4caf50'
	                    }]
	                },
	                options: {
	                    plugins: { legend: { display: true } },
	                    scales: {
	                        y: {
	                            beginAtZero: true,
	                            ticks: { stepSize: 1 }
	                        }
	                    }
	                }
	            });

	            // ✅ 하단 텍스트 업데이트
	            const bottomText = document.getElementById('bottomWeeklySummary');
	            if (bottomText && data && !isNaN(Number(data.totalWeeklyComplete))) {
	                const completeCount = Number(data.totalWeeklyComplete);  // 숫자형으로 강제 변환
	                bottomText.textContent = '이번 주 총 목표 완료 수: ' + completeCount + '개';
	            }
	            
	        });
	}
	
	function drawWeeklyCompleteChartBar() {
	    fetch("<%= path %>/jspproject/getStats.jsp")
	        .then(res => res.json())
	        .then(data => {
	            const labels = ['일', '월', '화', '수', '목', '금', '토'];
	            const goalValues = data.weeklyComplete;
	            const journalValues = data.weeklyJournalCount;

	            // 목표 chart 그리기
	            const goalCtx = document.getElementById('goalChart')?.getContext('2d');
	            if (goalCtx) {
	                if (barWeekGoalChart) barWeekGoalChart.destroy();

	                barWeekGoalChart = new Chart(goalCtx, {
	                    type: 'bar',
	                    data: {
	                        labels: labels,
	                        datasets: [{
	                            label: '요일별 목표 완료 수',
	                            data: goalValues,
	                            backgroundColor: [
	                                '#ff4d4d', '#ff9933', '#ffff66',
	                                '#66cc66', '#3399ff', '#3366cc', '#9933ff'
	                            ],
	                            borderRadius: 8
	                        }]
	                    },
	                    options: {
	                        plugins: { legend: { display: false } },
	                        scales: {
	                            y: {
	                                beginAtZero: true,
	                                ticks: {
	                                    stepSize: 1
	                                }
	                            }
	                        }
	                    }
	                });
	            }

	            // 일지 chart 그리기
	            const memoCtx = document.getElementById('memoChart')?.getContext('2d');
	            if (memoCtx) {
	                if (barWeekMemoChart) barWeekMemoChart.destroy();

	                barWeekMemoChart = new Chart(memoCtx, {
	                    type: 'bar',
	                    data: {
	                        labels: labels,
	                        datasets: [{
	                            label: '요일별 일지 작성 수',
	                            data: journalValues,
	                            backgroundColor: [
	                                '#ff4d4d', '#ff9933', '#ffff66',
	                                '#66cc66', '#3399ff', '#3366cc', '#9933ff'
	                            ],
	                            borderRadius: 8
	                        }]
	                    },
	                    options: {
	                        plugins: { legend: { display: false } },
	                        scales: {
	                            y: {
	                                beginAtZero: true,
	                                ticks: {
	                                    stepSize: 1
	                                }
	                            }
	                        }
	                    }
	                });
	            }

	            // ✅ bar 그래프 하단 텍스트 업데이트 (확실하게 숫자 변환 적용)
	            const bottomTextList = document.querySelectorAll(".bar-container .bottom-text");
	            if (bottomTextList.length >= 2) {
	                const completeCount = Number(data.totalWeeklyComplete);
	                const journalCount = Number(data.totalWeeklyJournal);

	                if (!isNaN(completeCount)) {
	                    bottomTextList[0].textContent = '이번 주 총 목표 완료 수 : ' + completeCount + '개';
	                }
	                if (!isNaN(journalCount)) {
	                    bottomTextList[1].textContent = '이번 주 작성한 일지 수 : ' + journalCount + '개';
	                }
	            }
	        });
	}

	function drawMonthlyCompleteChartBar() {
	    fetch("<%= path %>/jspproject/getStats.jsp")
	        .then(res => res.json())
	        .then(data => {
	            const labels = data.monthLabels;
	            const goalValues = data.monthlyComplete;
	            const journalValues = data.monthlyJournalCount;

	            const goalCtx = document.getElementById('goalChartMonth')?.getContext('2d');
	            if (goalCtx) {
	                if (barMonthGoalChart) barMonthGoalChart.destroy();

	                barMonthGoalChart = new Chart(goalCtx, {
	                    type: 'bar',
	                    data: {
	                        labels: labels,
	                        datasets: [{
	                            label: '월간 목표 완료 수',
	                            data: goalValues,
	                            backgroundColor: [
		                            '#ff4d4d', '#ff9933', '#ffff66',
		                            '#66cc66', '#3399ff', '#3366cc'
		                        ],
	                            borderRadius: 8
	                        }]
	                    },
	                    options: {
	                        plugins: { legend: { display: false } },
	                        scales: {
	                            y: {
	                                beginAtZero: true,
	                                ticks: { stepSize: 1 }
	                            }
	                        }
	                    }
	                });
	            }

	            const memoCtx = document.getElementById('memoChartMonth')?.getContext('2d');
	            if (memoCtx) {
	                if (barMonthMemoChart) barMonthMemoChart.destroy();

	                barMonthMemoChart = new Chart(memoCtx, {
	                    type: 'bar',
	                    data: {
	                        labels: labels,
	                        datasets: [{
	                            label: '월간 일지 작성 수',
	                            data: journalValues,
	                            backgroundColor: [
		                            '#ff4d4d', '#ff9933', '#ffff66',
		                            '#66cc66', '#3399ff', '#3366cc'
		                        ],
	                            borderRadius: 8
	                        }]
	                    },
	                    options: {
	                        plugins: { legend: { display: false } },
	                        scales: {
	                            y: {
	                                beginAtZero: true,
	                                ticks: { stepSize: 1 }
	                            }
	                        }
	                    }
	                });
	            }

	         // ✅ 월간 하단 텍스트 업데이트 (bar용)
	            const bottomTextList = document.querySelectorAll(".bar-container2 .bottom-text");
	            if (bottomTextList.length >= 2) {
	                const completeCount = Number(data.thisMonthComplete);
	                const journalCount = Number(data.thisMonthJournal);

	                if (!isNaN(completeCount)) {
	                    bottomTextList[0].textContent = '이번 달 총 목표 완료 수 : ' + completeCount + '개';
	                }
	                if (!isNaN(journalCount)) {
	                    bottomTextList[1].textContent = '이번 달 작성한 일지 수 : ' + journalCount + '개';
	                }
	            }
	        });
	}

	function drawMonthlyCompleteChartSpark() {
	    fetch("<%= path %>/jspproject/getStats.jsp")
	        .then(res => res.json())
	        .then(data => {
	            const labels = data.monthLabels;
	            const values = data.monthlyComplete;

	            const ctx = document.getElementById('myChartMonth')?.getContext('2d');
	            if (!ctx) return;
	            if (lineMonthChart) lineMonthChart.destroy();

	            lineMonthChart = new Chart(ctx, {
	                type: 'line',
	                data: {
	                    labels: labels,
	                    datasets: [{
	                        label: '월간 목표 완료 수',
	                        data: values,
	                        borderColor: '#4caf50',
	                        backgroundColor: 'rgba(76, 175, 80, 0.3)',
	                        tension: 0.3,
	                        fill: true,
	                        pointRadius: 5,
	                        pointBackgroundColor: '#4caf50'
	                    }]
	                },
	                options: {
	                    plugins: { legend: { display: true } },
	                    scales: {
	                        y: {
	                            beginAtZero: true,
	                            ticks: { stepSize: 1 }
	                        }
	                    }
	                }
	            });

	         // ✅ 하단 텍스트 업데이트 (spark용)
	            const bottomTextList = document.querySelectorAll(".spark-container2 .bottom-text");
	            if (bottomTextList.length >= 1) {
	                const completeCount = Number(data.thisMonthComplete);
	                if (!isNaN(completeCount)) {
	                    bottomTextList[0].textContent = '이번 달 총 목표 완료 수 : ' + completeCount + '개';
	                }
	            }
	        });
	}

	function hideAllGraphs() {
	    document.querySelectorAll('#GraphWrapper > div').forEach(div => {
	        div.style.display = 'none';
	    });
	}

	function toggleGraphView() {
	    const wrapper = document.getElementById("GraphWrapper");
	    const isVisible = wrapper.style.display === "block";
	    wrapper.style.display = isVisible ? "none" : "block";

	    if (!isVisible) {
	        switchToWeekLine();  // 기본으로 꺾은선 차트만 호출
	    }
	}

	function switchToWeekLine() {
	    hideAllGraphs();
	    document.getElementById("graph-spark-week").style.display = "block";

	    // ✅ DOM 렌더링 완료 후 실행
	    setTimeout(() => {
	        drawWeeklyCompleteChartSpark();  // fetch + 그래프 + 텍스트 모두 여기서 처리
	    }, 150);
	}

	function switchToWeekBar() {
	    hideAllGraphs();
	    document.getElementById("graph-bar-week").style.display = "block";
	    setTimeout(() => {
	    	drawWeeklyCompleteChartBar();  // ✅ 조건 없이 실행
	    }, 50);
	}

	function switchToMonthSpark() {
	    hideAllGraphs();
	    document.getElementById("graph-spark-month").style.display = "block";
	    setTimeout(() => {
	    	drawMonthlyCompleteChartSpark();
	    }, 50);
	}

	function switchToMonthBar() {
	    hideAllGraphs();
	    document.getElementById("graph-bar-month").style.display = "block";
	    setTimeout(() => {
	    	drawMonthlyCompleteChartBar();
	    }, 50);
	}
	
	document.addEventListener('DOMContentLoaded', function () {
	    const playBtn = document.getElementById('mainPlayToggleBtn');
	    const audio = document.getElementById('mainAudioPlayer');

	    if (playBtn && audio) {
	        // 초기 상태
	        playBtn.setAttribute('data-state', 'paused');

	        playBtn.addEventListener('click', function () {
	            const currentState = playBtn.getAttribute('data-state');

	            // ✅ 기본 src 확인 (예: 아무 음악도 선택되지 않은 상태)
	            if (!audio.src || audio.src.includes("music1.mp3")) {
	                alert("재생 중인 음악이 없습니다.\n음악 목록에서 곡을 먼저 선택해주세요.");
	                return;
	            }

	            if (currentState === 'paused') {
	                // ▶️ → ⏸️ + 음악 재생
	                playBtn.src = 'icon/아이콘_일시정지_1.png';
	                playBtn.alt = '일시정지';
	                playBtn.setAttribute('data-state', 'playing');

	                audio.play();
	            } else {
	                // ⏸️ → ▶️ + 음악 정지
	                playBtn.src = 'icon/아이콘_재생_1.png';
	                playBtn.alt = '재생';
	                playBtn.setAttribute('data-state', 'paused');

	                audio.pause();
	            }
	        });
	    }
	});

	
	function syncMainMusicBar(bgm, autoPlay = false) {
	    const audio = document.getElementById("mainAudioPlayer");
	    const titleEl = document.querySelector(".musicTitle");
	    const playBtn = document.getElementById("mainPlayToggleBtn");

	    if (audio && titleEl && playBtn) {
	        const newSrc = "<%= request.getContextPath() %>/jspproject/uploadMusic/" + bgm.src;

	        if (audio.src !== newSrc) {
	            audio.src = newSrc;
	        }

	        titleEl.textContent = bgm.title;

	        if (autoPlay) {
	            audio.play();
	            playBtn.src = "icon/아이콘_일시정지_1.png";
	            playBtn.setAttribute("data-state", "playing");
	        } else {
	            playBtn.src = "icon/아이콘_재생_1.png";
	            playBtn.setAttribute("data-state", "paused");
	        }
	    }
	}
	
	// 볼륨 조절 관련 메소드
	document.addEventListener("DOMContentLoaded", function () {
	    const audio = document.getElementById('mainAudioPlayer');
	    const volumeImages = document.querySelectorAll('.iconMusicVolum');
	    const muteBtn = document.getElementById('volumeMuteBtn');
	
	    let isMuted = false;
	    let lastVolumeLevel = 10; // 기본은 10 (100%)
	    if (audio) audio.volume = 1.0;
	
	    // 볼륨 바 클릭 시
	    volumeImages.forEach(img => {
	        img.addEventListener('click', function () {
	            const selectedLevel = parseInt(img.getAttribute('data-index'));
	            lastVolumeLevel = selectedLevel;
	            isMuted = false;
	
	            // 볼륨 조절
	            if (audio) audio.volume = selectedLevel / 10;
	
	            // 아이콘 업데이트
	            updateVolumeBar(selectedLevel);
	            muteBtn.src = 'icon/아이콘_볼륨_1.png';
	        });
	    });
	
	    // 음소거 버튼 클릭 시
	    muteBtn.addEventListener('click', function () {
	        if (!isMuted) {
	            // 🔇 음소거 모드
	            isMuted = true;
	            if (audio) audio.volume = 0;
	            muteBtn.src = 'icon/아이콘_음소거_1.png';
	            updateVolumeBar(0);
	        } else {
	            // 🔊 복원 모드
	            isMuted = false;
	            if (audio) audio.volume = lastVolumeLevel / 10;
	            muteBtn.src = 'icon/아이콘_볼륨_1.png';
	            updateVolumeBar(lastVolumeLevel);
	        }
	    });
	
	    // 볼륨바 아이콘 갱신 함수
	    function updateVolumeBar(activeLevel) {
	        volumeImages.forEach((bar, idx) => {
	            bar.src = idx < activeLevel
	                ? 'icon/아이콘_볼륨바_2.png'
	                : 'icon/아이콘_볼륨바off_2.png';
	        });
	    }
	});
	
	//모달이 보이면 알림 소리 재생
	document.addEventListener('DOMContentLoaded', function() {
        var audio = document.getElementById('notifiaudio');
        if (audio) {
            // 소리 재생 (브라우저에 따라 자동 재생이 제한될 수 있음)
            audio.play().catch(function(error) {
                console.log("알림 소리 자동 재생 실패:", error);
            });
        }
    });
	
	function closeModal() {
        document.getElementById('notificationModal').style.display = 'none';
    }

</script>


	