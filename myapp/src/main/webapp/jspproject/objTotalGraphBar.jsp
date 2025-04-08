<!-- objTotalGraphBar.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    @font-face {
        font-family: 'PFStarDust';
        src: url('fonts/PFStarDust-Bold.ttf') format('truetype');
        font-weight: bold;
        font-style: normal;
    }

    body {
        margin: 0;
        background-color: #1d102d;
        font-family: 'PFStarDust', sans-serif;
        color: white;
    }

    .bar-container {
        position: absolute;
        left: 18vw;
        top: 9.5vh;
        width: 70%;
        height: 74.5vh;
        background-color: rgba(29, 16, 45, 0.7);
        color: white;
        border-radius: 15px;
        box-shadow: 0 0 20px rgba(255,255,255,0.4);
        display: flex;
        flex-direction: column;
        padding: 20px;
        box-sizing: border-box;
    }

    /* 🔹 상단 탭 + 통계 */
    .graph-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }

    .graph-tab {
        display: flex;
        gap: 10px;
        margin-left:20px;
        margin-top:5px;
        margin-bottom:20px;
    }

    .graph-tab-btn {
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

    .graph-tab-btn.active {
        border-bottom: 2px solid white;
    }

    /* 🔹 중간: 그래프 + 버튼 */
    .graph-body {
	    flex: 1;
	    display: flex;
	}

	.graph-wrapper {
	    flex: 1;
	    display: flex;
	    justify-content: flex-start;
	    align-items: flex-start;
	}
	
	.graph-double {
	    display: flex;
	    justify-content: space-between;
	    align-items: flex-start;
	    height: 100%;
	    gap: 50px;
	}
	
	.graph-box {
	    width: 100%; /* ✅ 살짝 줄여서 gap과 함께 넓게 배치 */
	    height: 100%;
	    display: flex;
	    padding: 10px;
	    flex-direction: column;
	    align-items: center;
	    justify-content: center;
	    background: white;
	    border-radius: 10px;
	}

	.graph-box canvas {
	    width: 100% !important;
	    height: auto !important; /* ✅ 높이 제한 해제 */
	    aspect-ratio: 4 / 3;      /* ✅ 비율로 조정해서 반응형 유지 */
	}
	
	.graph-label {
	    text-align: center;
	    margin-top: 10px;
	    color: black;
	    font-family: 'PFStarDust', sans-serif;
        font-weight: bold;
        font-size: 1vw;
	}
	
	.graph-card2 {
	    width: 100%;
	    height: 100%;
	    border-radius: 10px;
	    padding: 10px; /* ✅ 패딩 줄이기 */
	    box-sizing: border-box;
	}

    .graph-sidebar {
        width: 120px;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        justify-content: flex-start;
        gap: 20px;
        margin-right:22px;
    }

    .graph-sidebar button {
	    width: 100%;
	    height: 40px;
	    padding: 5px 0;
	    border: none;
	    border-radius: 10px;
	    background-color: rgba(200, 200, 200, 0.15); /* 👈 좀 더 눈에 띄는 회색 */
	    color: white;
	    font-weight: bold;
	    font-size: 0.9vw;
	    cursor: pointer;
	    box-shadow: 0 4px 12px rgba(123, 44, 191, 0.4);
	    transition: 0.3s ease;
	}
	
	.graph-sidebar button:hover {
	    background-color: rgba(220, 220, 220, 0.25); /* 👈 hover 시 조금 더 밝게 */
	    box-shadow: 0 0 16px rgba(123, 44, 191, 0.6);
	    transform: scale(1.02);
	}

	.graph-sidebar button.btn-purple {
	    background-color: #7b2cbf !important;
	}
		
    .bottom-text {
	    margin-left: 5px;
	    margin-bottom:5px;
	    font-size: 1vw;
	    font-weight: bold;
	    color: #ffffff;
	    text-shadow: 0 0 8px rgba(255, 255, 255, 0.4); /* 살짝 glow */
	}

</style>

<div class="bar-container">
    <!-- 상단 탭 + 통계 -->
    <div class="graph-header">
        <div class="graph-tab">
            <button class="graph-tab-btn active">주간</button>
            <button class="graph-tab-btn" onclick = "switchToMonthBar()">월간</button>
        </div>
    </div>

    <!-- 중간 본문: 그래프 + 버튼 -->
    <div class="graph-body">
        <div class="graph-wrapper">
            <div class="graph-card2">
			    <div class="graph-double">
				    <div class="graph-card">
				        <div class="graph-box">
				            <canvas id="goalChart"></canvas>
				            <div class="graph-label">이번 주 목표 달성 건수</div>
				        </div>
				    </div>
				    
				    <div class="graph-card">
				        <div class="graph-box">
				            <canvas id="memoChart"></canvas>
				            <div class="graph-label">이번 주 일지 작성 건수</div>
				        </div>
				    </div>
				</div>
			</div>
        </div>

        <div class="graph-sidebar">
            <button onclick = "switchToWeekLine()">꺾은 선</button>
            <button class="btn-purple">막대</button>
        </div>
    </div>

    <!-- 하단 텍스트 -->
    <div class="bottom-text">이번 달 총 목표 완료 수 : 0개</div>
    <div class="bottom-text">이번 주 작성한 일지 수 : 0개</div>
</div>

<script>

</script>