<!-- mainScreen.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<link href="css/style.css?v=2" rel="stylesheet" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
	<img class="iconRightDown obj" src="icon/아이콘_작업목표_1.png" border="0" alt="작업 목표 설정" onclick = "toggleObjList()">
	<img class="iconRightDown" src="icon/아이콘_타이머_1.png" border="0" alt="타이머 키기" >
	<img class="iconRightDown" src="icon/아이콘_달력_1.png" border="0" alt="통계 보기" onclick = "toggleGraphView()" >
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

<!-- 통계 설정 영역 (처음엔 숨김) -->
<div id="GraphWrapper" style="display:none;">
    <div id="graph-spark-week" style="display:none;"><jsp:include page="objTotalGraphSpark.jsp" /></div>
    <div id="graph-bar-week" style="display:none;"><jsp:include page="objTotalGraphBar.jsp" /></div>
    <div id="graph-spark-month" style="display:none;"><jsp:include page="objTotalGraphSparkMonth.jsp" /></div>
    <div id="graph-bar-month" style="display:none;"><jsp:include page="objTotalGraphBarMonth.jsp" /></div>
</div>

<!-- 작업 목표 설정 영역 (처음엔 숨김) -->
<div id="objWrapper" style="display:none;">
    <jsp:include page="Objective.jsp" />
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
	
	// 일지 설정 on/off
	function toggleJournalList() {
        var journalDiv = document.getElementById("journalWrapper");
        journalDiv.style.display = (journalDiv.style.display === "none") ? "block" : "none";
    }
	
	// 작업 목록 on/off
	function toggleObjList() {
        var journalDiv = document.getElementById("objWrapper");
        journalDiv.style.display = (journalDiv.style.display === "none") ? "block" : "none";
    }
	
	// 통계 관련 설정
	// ✅ 전역 변수
	let lineChart = null;
	let lineMonthChart = null;
	let barWeekGoalChart = null;
	let barWeekMemoChart = null;
	let barMonthGoalChart = null;
	let barMonthMemoChart = null;

	function drawLineChart() {
		const ctx = document.getElementById('myChart')?.getContext('2d');
		if (!ctx) return;
		if (lineChart) lineChart.destroy();

		lineChart = new Chart(ctx, {
			type: 'line',
			data: {
				labels: ['2016', '2017', '2018', '2019', '2020', '2021'],
				datasets: [{
					label: '연간 작업량',
					data: [1230000, 1275000, 1330000, 1420000, 1450000, 1530000],
					borderColor: ctx => ctx.dataIndex === 5 ? 'red' : '#0277bd',
					pointBackgroundColor: ctx => ctx.dataIndex === 5 ? 'red' : '#0277bd',
					borderWidth: 2,
					pointRadius: 6,
					fill: false,
					tension: 0.3
				}]
			},
			options: {
				plugins: { legend: { display: false } },
				scales: {
					y: {
						ticks: {
							callback: value => value.toLocaleString()
						}
					}
				}
			}
		});
	}

	function drawBarWeekChart() {
		const goalCtx = document.getElementById('goalChart')?.getContext('2d');
		const memoCtx = document.getElementById('memoChart')?.getContext('2d');
		if (!goalCtx || !memoCtx) return;

		if (barWeekGoalChart) barWeekGoalChart.destroy();
		if (barWeekMemoChart) barWeekMemoChart.destroy();

		const options = {
			plugins: { legend: { display: false } },
			scales: {
				y: { ticks: { callback: v => v.toLocaleString() } }
			}
		};

		barWeekGoalChart = new Chart(goalCtx, {
			type: 'bar',
			data: {
				labels: ['2016', '2017', '2018', '2019', '2020', '2021'],
				datasets: [{
					label: '주간 목표',
					data: [300, 500, 700, 400, 600, 800],
					backgroundColor: '#4bc0c0',
					borderRadius: 8
				}]
			},
			options
		});

		barWeekMemoChart = new Chart(memoCtx, {
			type: 'bar',
			data: {
				labels: ['2016', '2017', '2018', '2019', '2020', '2021'],
				datasets: [{
					label: '주간 일지',
					data: [250, 450, 600, 380, 620, 780],
					backgroundColor: '#9966ff',
					borderRadius: 8
				}]
			},
			options
		});
	}

	function drawLineMonthChart() {
		const ctx = document.getElementById('myChartMonth')?.getContext('2d');
		if (!ctx) return;
		if (lineMonthChart) lineMonthChart.destroy();

		lineMonthChart = new Chart(ctx, {
			type: 'line',
			data: {
				labels: ['2016', '2017', '2018', '2019', '2020', '2021'],
				datasets: [{
					label: '월간 작업량',
					data: [1230000, 1275000, 1330000, 1420000, 1450000, 1530000],
					borderColor: ctx => ctx.dataIndex === 5 ? 'red' : '#0277bd',
					pointBackgroundColor: ctx => ctx.dataIndex === 5 ? 'red' : '#0277bd',
					borderWidth: 2,
					pointRadius: 6,
					fill: false,
					tension: 0.3
				}]
			},
			options: {
				plugins: { legend: { display: false } },
				scales: {
					y: {
						ticks: {
							callback: value => value.toLocaleString()
						}
					}
				}
			}
		});
	}

	function drawBarMonthChart() {
		const goalCtx = document.getElementById('goalChartMonth')?.getContext('2d');
		const memoCtx = document.getElementById('memoChartMonth')?.getContext('2d');
		if (!goalCtx || !memoCtx) return;

		if (barMonthGoalChart) barMonthGoalChart.destroy();
		if (barMonthMemoChart) barMonthMemoChart.destroy();

		const options = {
			plugins: { legend: { display: false } },
			scales: {
				y: { ticks: { callback: v => v.toLocaleString() } }
			}
		};

		barMonthGoalChart = new Chart(goalCtx, {
			type: 'bar',
			data: {
				labels: ['2016', '2017', '2018', '2019', '2020', '2021'],
				datasets: [{
					label: '월간 목표',
					data: [300, 500, 700, 400, 600, 800],
					backgroundColor: '#36a2eb',
					borderRadius: 8
				}]
			},
			options
		});

		barMonthMemoChart = new Chart(memoCtx, {
			type: 'bar',
			data: {
				labels: ['2016', '2017', '2018', '2019', '2020', '2021'],
				datasets: [{
					label: '월간 일지',
					data: [250, 450, 600, 380, 620, 780],
					backgroundColor: '#ffcd56',
					borderRadius: 8
				}]
			},
			options
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
	    setTimeout(() => {
	        if (typeof drawLineChart === 'function') drawLineChart();
	    }, 50);
	}

	function switchToWeekBar() {
	    hideAllGraphs();
	    document.getElementById("graph-bar-week").style.display = "block";
	    setTimeout(() => {
	        if (typeof drawBarWeekChart === 'function') drawBarWeekChart();
	    }, 50);
	}

	function switchToMonthSpark() {
	    hideAllGraphs();
	    document.getElementById("graph-spark-month").style.display = "block";
	    setTimeout(() => {
	        if (typeof drawLineMonthChart === 'function') drawLineMonthChart();
	    }, 50);
	}

	function switchToMonthBar() {
	    hideAllGraphs();
	    document.getElementById("graph-bar-month").style.display = "block";
	    setTimeout(() => {
	        if (typeof drawBarMonthChart === 'function') drawBarMonthChart();
	    }, 50);
	}
</script>