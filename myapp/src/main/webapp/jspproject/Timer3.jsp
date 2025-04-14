<!-- 보라색 원형 타이머 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jspproject.*" %>
<%@ include file="TimerInfo.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>보라 타이머</title>
 <style>
    body {
      overflow: hidden;
      margin: 0;
    }

    .timer3-timer-container {
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

    .timer3-svg {
      position: absolute;
      top: 0;
      left: 0;
      transform: rotate(90deg) scaleX(-1);
    }

    .timer3-drag-handle {
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

    .timer3-center {
      position: absolute;
      top: 47%;
      left: 50%;
      transform: translate(-50%, -50%);
      text-align: center;
    }

    .timer3-time {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 6px;
      color: white;
    }

    .timer3-info {
      font-size: 14px;
      line-height: 1.3;
      color: white;
    }

    .timer3-info strong {
      cursor: pointer;
    }

    input.timer3-input {
      width: 50px;
      font-size: 14px;
      text-align: center;
      background: transparent;
      border: none;
      color: white;
      outline: none;
    }

    .timer3-bottom-controls {
      position: absolute;
      bottom: 50px;
      left: 50%;
      transform: translateX(-50%);
      display: flex;
      gap: 24px;
    }

    .timer3-btn {
      font-size: 20px;
      background: none;
      border: none;
      color: white;
      cursor: pointer;
      transition: 0.2s;
    }

    .timer3-btn:hover {
      color: #BA68C8;
    }
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

<div class="timer3-timer-container" id="timerContainer" 
style="left:<%= left %>px; top:<%= top %>px; <%= extraStyle %>">
  <div class="timer3-drag-handle">:::</div>

  <svg class="timer3-svg" width="240" height="240">
    <circle cx="120" cy="120" r="100" stroke="#333" stroke-width="12" fill="none" />
    <circle id="progress" cx="120" cy="120" r="100" stroke="#8E24AA" stroke-width="12" fill="none"
            stroke-linecap="butt" stroke-dasharray="628" />
  </svg>

  <div class="timer3-center">
    <div class="timer3-time" id="timeDisplay">00:00</div>
    <div class="timer3-info" id="timerInfo">
      <strong id="sessionTime">00:00</strong> 세션<br>
      과 <strong id="breakTime">00:00</strong> 휴식
    </div>
  </div>

  <div class="timer3-bottom-controls">
    <button class="timer3-btn" id="btnReset">⟲</button>
    <button class="timer3-btn" id="toggleBtn">▶️</button>
  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
  const userId = "<%= user_id %>";
  const isPreview = "<%= request.getParameter("preview") != null %>" === "true";

  let sessionDuration = <%= sessionTime %>;
  let breakDuration = <%= breakTime %>;
  let timeLeft = sessionDuration;
  let isSession = true;
  let isRunning = false;
  let interval = null;

  const RADIUS = 100;
  const CIRCUMFERENCE = 2 * Math.PI * RADIUS;

  const timer = document.getElementById("timerContainer");
  const dragHandle = document.querySelector(".timer3-drag-handle");
  const timeDisplay = document.getElementById("timeDisplay");
  const progressCircle = document.getElementById("progress");
  const sessionTimeEl = document.getElementById("sessionTime");
  const breakTimeEl = document.getElementById("breakTime");
  const toggleBtn = document.getElementById("toggleBtn");
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
    progressCircle.style.stroke = isSession ? "#8E24AA" : "#BA68C8";
    progressCircle.style.strokeDashoffset = offset;
    timeDisplay.textContent = formatTime(timeLeft);
  };

  const resetTimer = () => {
    clearInterval(interval);
    isRunning = false;
    isSession = true;
    timeLeft = sessionDuration;
    toggleBtn.textContent = "▶️";
    updateProgress();
    timerInfo.style.display = "block";
  };

  const updateTimerSettingToDB = () => {
    fetch("UpdateTimerSessionProc.jsp", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: "user_id=" + userId + "&timer_session=" + sessionDuration + "&timer_break=" + breakDuration
    }).then(res => res.text())
      .then(data => console.log(data));
  };

  btnReset.addEventListener("click", resetTimer);

  toggleBtn.addEventListener("click", () => {
    if (isRunning) {
      clearInterval(interval);
      isRunning = false;
      toggleBtn.textContent = "▶️";
      timerInfo.style.display = "block";
    } else {
      interval = setInterval(() => {
        if (timeLeft > 0) {
          timeLeft--;
          updateProgress();
        } else {
          isSession = !isSession;
          
          // 알림 표시
	      if (isSession) {
	        showNotification("휴식 시간이 끝났습니다. 작업 세션을 시작합니다.");
	      } else {
	        showNotification("작업 세션이 끝났습니다. 휴식 시간을 시작합니다.");
	      }
          
          timeLeft = isSession ? sessionDuration : breakDuration;
          updateProgress();
        }
      }, 1000);
      isRunning = true;
      toggleBtn.textContent = "⏸";
      timerInfo.style.display = "none";
    }
  });

//showNotification 함수 추가
  const showNotification = (message) => {
    const notification = document.createElement('div');
    notification.className = 'notification';
    notification.textContent = message;
    document.body.appendChild(notification);
    
    // 표시 애니메이션을 위해 약간의 지연 후 show 클래스 추가
    setTimeout(() => {
      notification.classList.add('show');
    }, 10);
    
    // 5초 후 알림 제거
    setTimeout(() => {
      notification.classList.remove('show');
      setTimeout(() => {
        document.body.removeChild(notification);
      }, 300); // 페이드 아웃 애니메이션이 끝날 때까지 기다림
    }, 5000);
  };
  
  const makeEditable = (el, type) => {
    const input = document.createElement("input");
    input.type = "number";
    input.className = "timer3-input";
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

  sessionTimeEl.textContent = formatTime(sessionDuration);
  breakTimeEl.textContent = formatTime(breakDuration);
  timeDisplay.textContent = formatTime(sessionDuration);
  updateProgress();

  // 미리보기 모드 아닐때만 드래그 허용
  if (!isPreview) {
    let isDragging = false;
    let startX = 0, startY = 0, offsetX = 0, offsetY = 0;

    dragHandle.addEventListener("mousedown", (e) => {
      e.preventDefault();
      isDragging = true;
      startX = e.clientX;
      startY = e.clientY;
      offsetX = timer.offsetLeft;
      offsetY = timer.offsetTop;
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
        let x = parseInt(timer.style.left);
        let y = parseInt(timer.style.top);
        if (x < 10) x = 10;
        if (y < 10) y = 10;
        fetch("UpdateTimerSessionProc.jsp", {
          method: "POST",
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
          body: "user_id=" + userId + "&timer_loc=" + x + "," + y
        }).then(res => res.text())
          .then(data => console.log(data));
      }
    });
  }
});
</script>

</body>
</html>
