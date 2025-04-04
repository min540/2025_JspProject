<!-- ObjTotalGraphSparkMonth.jsp -->
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

    .spark-container2 {
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
	
	.graph-card {
	    width: 95%;
	    height: 95%;
	    background-color: white;
	    border-radius: 10px;
	    padding: 20px;
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
	
	#barMonthWrapper {
	    display: none;
	}

</style>

<div class="spark-container2">
    <!-- 상단 탭 + 통계 -->
    <div class="graph-header">
        <div class="graph-tab">
            <button class="graph-tab-btn" onclick= "switchToWeekLine()">주간</button>
            <button class="graph-tab-btn active">월간</button>
        </div>
    </div>

    <!-- 중간 본문: 그래프 + 버튼 -->
    <div class="graph-body">
        <div class="graph-wrapper">
            <div class="graph-card">
                <canvas id="myChartMonth"></canvas>
            </div>
        </div>

        <div class="graph-sidebar">
            <button class="btn-purple">꺾은 선</button>
            <button onclick = "switchToMonthBar()">막대</button>
        </div>
    </div>

    <!-- 하단 텍스트 -->
    <div class="bottom-text">이번 달 총 작업 시간 : 3000H</div>
</div>

<script>

</script>
