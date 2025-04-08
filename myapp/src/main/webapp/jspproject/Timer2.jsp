<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>드래그 가능한 네모 타이머</title>
  <style>
    body {
      margin: 0;
      background: #f1f4fa;
      font-family: 'Segoe UI', sans-serif;
      height: 100vh;
      overflow: hidden;
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

<div class="timer2-card" id="timerCard">
  <div class="timer2-drag-handle" id="dragHandle">:::</div>

  <div class="timer2-progress-container">
    <div class="timer2-progress-bar" id="progressBar"></div>
  </div>

  <div class="timer2-time-display" id="timeDisplay">10:00</div>

  <div class="timer2-session-info" id="timerInfo">
    <strong id="sessionTime">10:00</strong> 세션,
    <strong id="breakTime" class="break-time">05:00</strong> 휴식
  </div>

  <div class="timer2-btn-area">
    <button class="timer2-play-btn" id="toggleBtn">▶️</button>
    <button class="timer2-play-btn" id="btnReset">⟲</button>
  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
  let sessionDuration = 600;
  let breakDuration = 300;
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

  const formatTime = (seconds) => {
    const m = Math.floor(seconds / 60);
    const s = seconds % 60;
    return m + ":" + String(s).padStart(2, '0');
  };

  const updateProgress = () => {
    const duration = isSession ? sessionDuration : breakDuration;
    const percent = timeLeft / duration;
    progressBar.style.width = (percent * 100) + "%";
    progressBar.style.backgroundColor = isSession ? "#3f8efc" : "#4caf50";
    timeDisplay.textContent = formatTime(timeLeft);
  };

  const startInterval = () => {
    interval = setInterval(() => {
      if (timeLeft > 0) {
        timeLeft--;
        updateProgress();
      } else {
        clearInterval(interval);
        isRunning = false;
        isSession = !isSession;
        timeLeft = isSession ? sessionDuration : breakDuration;
        updateProgress();
        toggleBtn.textContent = "▶️";
        timerInfo.style.display = "block";
      }
    }, 1000);
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

  btnReset.addEventListener("click", resetTimer);

  toggleBtn.addEventListener("click", () => {
    if (isRunning) {
      clearInterval(interval);
      isRunning = false;
      toggleBtn.textContent = "▶️";
      timerInfo.style.display = "block";
    } else {
      startInterval();
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
      resetTimer();
    };

    input.addEventListener("blur", confirm);
    input.addEventListener("keydown", (e) => {
      if (e.key === "Enter") confirm();
    });

    el.replaceWith(input);
    input.focus();
  };

  sessionTimeEl.addEventListener("click", () => makeEditable(sessionTimeEl, "session"));
  breakTimeEl.addEventListener("click", () => makeEditable(breakTimeEl, "break"));

  sessionTimeEl.textContent = formatTime(sessionDuration);
  breakTimeEl.textContent = formatTime(breakDuration);
  updateProgress();

  // 드래그 기능
  let isDragging = false;
  let offsetX = 0;
  let offsetY = 0;

  dragHandle.addEventListener("mousedown", (e) => {
    e.preventDefault();
    const rect = timerCard.getBoundingClientRect();
    offsetX = e.clientX - rect.left;
    offsetY = e.clientY - rect.top;
    isDragging = true;
    document.body.style.cursor = "grabbing";

    timerCard.style.transform = "none";
    timerCard.style.left = rect.left + "px";
    timerCard.style.top = rect.top + "px";
  });

  document.addEventListener("mousemove", (e) => {
    if (!isDragging) return;
    const x = e.clientX - offsetX;
    const y = e.clientY - offsetY;
    timerCard.style.left = x + "px";
    timerCard.style.top = y + "px";
  });

  document.addEventListener("mouseup", () => {
    if (isDragging) {
      isDragging = false;
      document.body.style.cursor = "default";
    }
  });
});
</script>

</body>
</html>
