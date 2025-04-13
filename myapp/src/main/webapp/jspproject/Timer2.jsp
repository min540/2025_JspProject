<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jspproject.*" %>
<%@ include file="TimerInfo.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>네모 타이머</title>
<style>
    body {
      overflow: hidden;
      margin: 0;
    }

    .timer2-card {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 320px;
      background: white;
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
      padding: 16px 16px 20px;
      box-sizing: border-box;
      text-align: center;
      cursor: default;
      border: 10px solid #a259ff;
    }

    .timer2-drag-handle {
      font-size: 24px;
      cursor: grab;
      color: #bbb;
      user-select: none;
      margin-bottom: 10px;
    }

    .timer2-progress-container {
      width: 100%;
      height: 12px;
      background: #e0e0e0;
      border-radius: 6px;
      overflow: hidden;
      margin-bottom: 20px;
    }

    .timer2-progress-bar {
      height: 100%;
      background-color: #3f8efc;
      width: 100%;
      transition: width 0.3s ease;
    }

    .timer2-time-display {
      font-size: 36px;
      font-weight: bold;
      color: #222;
      margin-bottom: 10px;
    }

    .timer2-session-info {
      font-size: 14px;
      color: #555;
    }

    .timer2-session-info strong {
      color: #3f8efc;
      cursor: pointer;
    }

    .timer2-session-info .break-time {
      color: #4caf50;
    }

    input.timer2-input {
      width: 50px;
      font-size: 14px;
      text-align: center;
      border: 1px solid #ccc;
      border-radius: 4px;
      padding: 2px;
    }

    .timer2-btn-area {
      margin-top: 20px;
      display: flex;
      justify-content: center;
      gap: 12px;
    }

    .timer2-play-btn {
      width: 40px;
      height: 40px;
      background: white;
      border: none;
      border-radius: 8px;
      font-size: 20px;
      color: #3f8efc;
      cursor: pointer;
      transition: all 0.2s;
    }

    .timer2-play-btn:hover {
      background: #f0f4ff;
      color: #1a5ef0;
    }
  </style>
</head>
<body>

<div class="timer2-card" id="timerCard" 
 style="left:<%= left %>px; top:<%= top %>px; <%= extraStyle %>">
  <div class="timer2-drag-handle" id="dragHandle">:::</div>

  <div class="timer2-progress-container">
    <div class="timer2-progress-bar" id="progressBar"></div>
  </div>

  <div class="timer2-time-display" id="timeDisplay">00:00</div>

  <div class="timer2-session-info" id="timerInfo">
    <strong id="sessionTime">00:00</strong> 세션,
    <strong id="breakTime" class="break-time">00:00</strong> 휴식
  </div>

  <div class="timer2-btn-area">
    <button class="timer2-play-btn" id="toggleBtn">▶️</button>
    <button class="timer2-play-btn" id="btnReset">⟲</button>
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

  const timerCard = document.getElementById("timerCard");
  const dragHandle = document.getElementById("dragHandle");
  const progressBar = document.getElementById("progressBar");
  const timeDisplay = document.getElementById("timeDisplay");
  const sessionTimeEl = document.getElementById("sessionTime");
  const breakTimeEl = document.getElementById("breakTime");
  const toggleBtn = document.getElementById("toggleBtn");
  const btnReset = document.getElementById("btnReset");
  const timerInfo = document.getElementById("timerInfo");

  const formatTime = (sec) => {
    const m = Math.floor(sec / 60);
    const s = sec % 60;
    return m + ":" + String(s).padStart(2, '0');
  };

  const updateProgress = () => {
    const duration = isSession ? sessionDuration : breakDuration;
    const percent = timeLeft / duration;
    progressBar.style.width = (percent * 100) + "%";
    progressBar.style.backgroundColor = isSession ? "#3f8efc" : "#4caf50";
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

  sessionTimeEl.textContent = formatTime(sessionDuration);
  breakTimeEl.textContent = formatTime(breakDuration);
  timeDisplay.textContent = formatTime(sessionDuration);
  updateProgress();

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
          timeLeft = isSession ? sessionDuration : breakDuration;
          updateProgress();
        }
      }, 1000);
      isRunning = true;
      toggleBtn.textContent = "⏸";
      timerInfo.style.display = "none";
    }
  });

  const makeEditable = (el, type) => {
    const input = document.createElement("input");
    input.type = "number";
    input.className = "timer2-input";
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

  // 드래그 (미리보기면 막기)
  if (!isPreview) {
    let isDragging = false;
    let startX = 0, startY = 0, offsetX = 0, offsetY = 0;

    dragHandle.addEventListener("mousedown", (e) => {
      e.preventDefault();
      isDragging = true;
      startX = e.clientX;
      startY = e.clientY;
      offsetX = timerCard.offsetLeft;
      offsetY = timerCard.offsetTop;
      document.body.style.cursor = "grabbing";
    });

    document.addEventListener("mousemove", (e) => {
      if (!isDragging) return;
      timerCard.style.left = (offsetX + e.clientX - startX) + "px";
      timerCard.style.top = (offsetY + e.clientY - startY) + "px";
    });

    document.addEventListener("mouseup", () => {
      if (isDragging) {
        isDragging = false;
        document.body.style.cursor = "default";
        let x = parseInt(timerCard.style.left);
        let y = parseInt(timerCard.style.top);
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
