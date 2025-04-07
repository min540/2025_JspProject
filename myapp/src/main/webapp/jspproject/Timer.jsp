<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>타이머 탭</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/jspproject/css/Timer.css" />
</head>
<body>
  <div class="timer-container">
    <!-- 왼쪽 타이머 목록 패널 -->
    <div class="timer-left">
      <div class="timer-tab">
        <button class="tab-btn" onclick="location.href='Background.jsp'">배경화면</button>
        <button class="tab-btn active">타이머</button>
      </div>

      <div class="timer-header">
        <div class="header-left">
          <label>타이머 목록</label>
        </div>
        <div class="header-right">
           <img class="icontimerList" src="icon/아이콘_글자순_1.png" alt="글자순 정렬">
		  <img class="icontimerList" src="icon/아이콘_오래된순_최신순_1.png" alt="최신순 정렬"> <!-- 🔥 추가된 아이콘 -->
		  <input class="timer-search" type="text" placeholder="타이머 검색" />
		  <img id="searchTimerBtn" class="icontimerList" src="icon/아이콘_검색_1.png" alt="검색">
          
        </div>
      </div>

      <div class="timer-list" id="timerGrid"></div>
    </div>

    <!-- 오른쪽 미리보기/설정 -->
    <div class="timer-right">
      <div class="preview-icons">
        <img class="icontimerList" src="icon/아이콘_수정_1.png" alt="수정" />
        <img class="icontimerList" src="icon/아이콘_삭제_1.png" alt="삭제" />
      </div>

      <div class="timer-preview-wrapper">
        <div id="timerPreviewBox" class="timer-preview-box"></div>
      </div>

      <div class="timer-description">
        <textarea placeholder="타이머 설명을 입력하세요."></textarea>
      </div>

      <div class="timer-cancel-button">
        <button class="btn-purple">타이머 취소</button>
      </div>

	<div class="timer-right-buttons">
	  <button class="btn-purple" onclick="applyTimer()">적용</button>
	</div>
    </div>
  </div>

  <script>
    let selectedTimer = null;

    const timerData = [
      "15:00", "10:00 ▶", "⏱ 25분", "🔋 진행률",
      "00:30", "퍼센트 바", "03:00", "⭕ 5분",
      "12:00", "⏳ 시작", "25", "▶ 00:45",
      "🕒 01:15", "게이지바", "15분", "▶ 5분",
      "00:10", "타임업", "휴식 10분", "⏱ 01:00"
    ];

    const styles = {
      1: "<div style='width:100px;height:100px;border:6px solid #683FE2;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:20px;color:white;'>15:00</div>",
      2: "<div style='width:140px;height:50px;background:#F0F0F0;border-radius:10px;display:flex;justify-content:space-around;align-items:center;font-size:16px;color:black;'><span>10:00</span> ▶</div>",
      3: "<div style='font-size:22px;color:white;padding:10px;'>⏱ 25분 집중</div>",
      4: "<div style='width:20px;height:100px;background:#ddd;position:relative;border-radius:10px;'><div style='width:100%;height:60%;background:#683FE2;position:absolute;bottom:0;border-radius:10px 10px 0 0;'></div></div>",
      5: "<div style='font-size: 24px; color: white;'>00:30</div>",
      6: "<div style='width: 120px; height: 12px; background-color: #eee;'><div style='width: 40%; height: 100%; background-color: #683FE2;'></div></div>",
      7: "<div style='background: #f5f5f5; padding: 20px; border-radius: 8px;'>03:00</div>",
      8: "<div style='width: 100px; height: 100px; border: 2px dashed #683FE2; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 18px; color: white;'>5분</div>",
      9: "<div style='background: white; padding: 12px 16px; border-radius: 8px; color: #000;'>12:00</div>",
      10: "<div style='font-size: 20px; color: white;'>⏳ 집중 시작</div>",
      11: "<div style='width: 60px; height: 60px; background: #683FE2; color: white; display: flex; align-items: center; justify-content: center; border-radius: 4px;'>25</div>",
      12: "<div style='background: #ddd; padding: 16px 20px; border-radius: 8px;'>▶ 00:45</div>",
      13: "<div style='display: flex; gap: 8px; color: white;'>🕒 <span>01:15</span></div>",
      14: "<div style='width: 100px; height: 8px; background: #ccc;'><div style='width: 70%; height: 100%; background: #683FE2;'></div></div>",
      15: "<div style='color: white;'>15분</div>",
      16: "<div style='color: white;'>▶ 5분</div>",
      17: "<div style='color: white;'>00:10</div>",
      18: "<div style='color: #683FE2;'>타임업</div>",
      19: "<div style='color: white;'>휴식 10분</div>",
      20: "<div style='color: white;'>⏱ 01:00</div>"
    };

    const grid = document.getElementById("timerGrid");
    timerData.forEach((label, index) => {
      const div = document.createElement("div");
      div.textContent = label;
      div.className = "timer-button";
      div.onclick = () => selectTimer(index + 1);
      grid.appendChild(div);
    });

    function selectTimer(num) {
      selectedTimer = num;
      const previewBox = document.getElementById("timerPreviewBox");
      previewBox.innerHTML = styles[num] || `<div style='color:white;'>${timerData[num - 1]}</div>`;
    }

    document.addEventListener("DOMContentLoaded", () => {
      selectTimer(1);
    });

    function applyTimer() {
      if (selectedTimer === null) {
        alert("먼저 타이머를 선택해주세요!");
        return;
      }
      alert(`타이머 ${selectedTimer}번이 적용되었습니다!`);
    }
  </script>
</body>
</html>
