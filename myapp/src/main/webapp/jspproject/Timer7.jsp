<!-- Timer1.jsp -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="TimerInfo.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>흰색 타이머</title>
<style>
    body {
      overflow: hidden;
      margin: 0;
    }

    .timer7-timer-container {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 240px;
      height: 240px;
      border-radius: 50%;
      background: #11111c;
      border: 3px solid #1C1C1C;
      user-select: none;
      cursor: default;
    }

    .timer7-svg {
      position: absolute;
      top: 0;
      left: 0;
      transform: rotate(90deg) scaleX(-1);
    }

    .timer7-drag-handle {
      position: absolute;
      top: 30px;
      left: 50%;
      transform: translateX(-50%);
      font-size: 28px;
      color: white;
      user-select: none;
      cursor: grab;
      z-index: 10;
      letter-spacing: 1px;
      line-height: 1;
    }

    .timer7-center {
      position: absolute;
      top: 47%;
      left: 50%;
      transform: translate(-50%, -50%);
      text-align: center;
    }

    .timer7-time {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 6px;
      color: white;
    }

    .timer7-info {
      font-size: 14px;
      line-height: 1.3;
      color: white;
    }

    .timer7-info strong {
      cursor: pointer;
    }

    input.timer7-input {
      width: 50px;
      font-size: 14px;
      text-align: center;
      background: transparent;
      border: none;
      color: white;
      outline: none;
    }

    .timer7-bottom-controls {
      position: absolute;
      bottom: 50px;
      left: 50%;
      transform: translateX(-50%);
      display: flex;
      gap: 24px;
    }

    .timer7-btn {
      font-size: 20px;
      background: none;
      border: none;
      color: white;
      cursor: pointer;
      transition: 0.2s;
    }

    .timer7-btn:hover img {
      filter: brightness(1.2);
    }

    .timer7-btn img {
      width: 24px;
      height: 24px;
      vertical-align: middle;
    }

    /* 알림 스타일 */
    .notification {
      position: fixed;
      top: 20px;
      right: 20px;
      background-color: rgba(0, 0, 0, 0.8);
      color: white;
      padding: 15px 20px;
      border-radius: 5px;
      z-index: 1000;
      opacity: 0;
      transition: opacity 0.3s ease;
      max-width: 300px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .notification.show {
      opacity: 1;
    }
  </style>
</head>
<body>

<div class="timer7-timer-container" id="timerContainer"
     style="left:<%= left %>px; top:<%= top %>px; <%= extraStyle %>">
  <div class="timer7-drag-handle">:::</div>

  <svg class="timer7-svg" width="240" height="240">
    <circle cx="120" cy="120" r="100" stroke="#333" stroke-width="12" fill="none" />
    <circle id="progress" cx="120" cy="120" r="100" stroke="#ffffff" stroke-width="12" fill="none"
		stroke-linecap="butt" stroke-dasharray="628" />
  </svg>

  <div class="timer7-center">
    <div class="timer7-time" id="timeDisplay">00:00</div>
    <div class="timer7-info" id="timerInfo">
      <strong id="sessionTime">00:00</strong> 세션<br>
      과 <strong id="breakTime">00:00</strong> 휴식
    </div>
  </div>

  <div class="timer7-bottom-controls">
    <button class="timer7-btn" id="btnReset">⟲</button>
    <button class="timer7-btn" id="toggleBtn">
      <img id="toggleIcon" src="icon/아이콘_재생_1.png" alt="toggle" />
    </button>
  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {

  const isPreview = "<%= request.getParameter("preview") != null %>" === "true";

  const userId = "<%= user_id %>";
  let sessionDuration = <%= sessionTime %>;
  let breakDuration = <%= breakTime %>;
  let timeLeft = sessionDuration;
  let isSession = true;
  let isRunning = false;
  let interval = null;

  const RADIUS = 100;
  const CIRCUMFERENCE = 2 * Math.PI * RADIUS;

  const timer = document.getElementById("timerContainer");
  const dragHandle = document.querySelector(".timer7-drag-handle");
  const timeDisplay = document.getElementById("timeDisplay");
  const progressCircle = document.getElementById("progress");
  const sessionTimeEl = document.getElementById("sessionTime");
  const breakTimeEl = document.getElementById("breakTime");
  const toggleIcon = document.getElementById("toggleIcon");
  const btnReset = document.getElementById("btnReset");
  const timerInfo = document.getElementById("timerInfo");

  progressCircle.style.strokeDasharray = CIRCUMFERENCE;

  const formatTime = (sec) => {
    const m = Math.floor(sec / 60);
    const s = sec % 60;
    return m + ":" + String(s).padStart(2, '0');
  };

  const updateProgress = () => {
	  const duration = isSession ? sessionDuration : breakDuration;
	  const percent = timeLeft / duration;
	  const offset = CIRCUMFERENCE * (1 - percent);
	  progressCircle.style.stroke = isSession ? "#ffffff" : "#b4c8bb"; // 흰색 / 연청록
	  progressCircle.style.strokeDashoffset = offset;
	  timeDisplay.textContent = formatTime(timeLeft);
	};

  const startInterval = () => {
    interval = setInterval(() => {
      if (timeLeft > 0) {
        timeLeft--;
        updateProgress();
      } else {
        isSession = !isSession;
        timeLeft = isSession ? sessionDuration : breakDuration;
        updateProgress();
      }
    }, 1000);
  };

  const resetTimer = () => {
    clearInterval(interval);
    isRunning = false;
    isSession = true;
    timeLeft = sessionDuration;
    toggleIcon.src = "icon/아이콘_재생_1.png";
    updateProgress();
    timerInfo.style.display = "block";
  };

  const updateTimerSettingToDB = () => {
    fetch("UpdateTimerSessionProc.jsp", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: "user_id=" + userId + "&timer_session=" + sessionDuration + "&timer_break=" + breakDuration
    }).then(res => res.text())
      .then(data => console.log("세션/브레이크 업데이트 결과 : ", data));
  };

  btnReset.addEventListener("click", resetTimer);

  toggleBtn.addEventListener("click", () => {
    if (isRunning) {
      clearInterval(interval);
      isRunning = false;
      toggleIcon.src = "icon/아이콘_재생_1.png";
      timerInfo.style.display = "block";
    } else {
      startInterval();
      isRunning = true;
      toggleIcon.src = "icon/아이콘_일시정지_1.png";
      timerInfo.style.display = "none";
    }
  });

  const makeEditable = (el, type) => {
    const input = document.createElement("input");
    input.type = "number";
    input.className = "timer7-input";
    input.value = type === "session" ? sessionDuration : breakDuration;

    const confirm = () => {
      let val = parseInt(input.value);
      if (isNaN(val) || val < 10) val = 10;
      if (val > 3600) val = 3600;

      if (type === "session") {
        sessionDuration = val;
        sessionTimeEl.textContent = formatTime(sessionDuration);
      } else {
        breakDuration = val;
        breakTimeEl.textContent = formatTime(breakDuration);
      }

      input.replaceWith(type === "session" ? sessionTimeEl : breakTimeEl);
      updateTimerSettingToDB();
      resetTimer();
    };

    input.addEventListener("blur", confirm);
    input.addEventListener("keydown", (e) => { if (e.key === "Enter") confirm(); });

    el.replaceWith(input);
    input.focus();
  };

  sessionTimeEl.addEventListener("click", () => makeEditable(sessionTimeEl, "session"));
  breakTimeEl.addEventListener("click", () => makeEditable(breakTimeEl, "break"));

  // 처음 출력 처리!
  sessionTimeEl.textContent = formatTime(sessionDuration);
  breakTimeEl.textContent = formatTime(breakDuration);
  timeDisplay.textContent = formatTime(sessionDuration);
  updateProgress();

  if(isPreview){
	  updateProgress();  // 처음 화면 그리기
	  progressCircle.style.animation = "dash 3s linear infinite"; // css 애니메이션 효과 (선이 계속 돌게)
	}

  // 드래그
  let isDragging = false;
  let startX = 0, startY = 0, offsetX = 0, offsetY = 0;

  dragHandle.addEventListener("mousedown", (e) => {
    e.preventDefault();
    startX = e.clientX;
    startY = e.clientY;
    offsetX = timer.offsetLeft;
    offsetY = timer.offsetTop;
    isDragging = true;
    document.body.style.cursor = "grabbing";
  });

  document.addEventListener("mousemove", (e) => {
    if (!isDragging) return;
    timer.style.left = (offsetX + e.clientX - startX) + "px";
    timer.style.top = (offsetY + e.clientY - startY) + "px";
  });

  document.addEventListener("mouseup", () => {
    if (isDragging) {
      isDragging = false;
      document.body.style.cursor = "default";

      const x = parseInt(timer.style.left);
      const y = parseInt(timer.style.top);

      fetch("UpdateTimerSessionProc.jsp", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "user_id=" + userId + "&timer_loc=" + x + "," + y
      }).then(res => res.text())
        .then(data => console.log("타이머 위치 저장 결과 : ", data));
    }
  });
});
</script>


</body>
</html>
