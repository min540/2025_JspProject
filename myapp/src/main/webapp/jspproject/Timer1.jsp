<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>타이머</title>
  <style>
    body {
      overflow: hidden;
      margin: 0;
    }

    .timer1-timer-container {
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

    .timer1-svg {
      position: absolute;
      top: 0;
      left: 0;
      transform: rotate(90deg) scaleX(-1);
    }

    .timer1-drag-handle {
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

    .timer1-center {
      position: absolute;
      top: 47%;
      left: 50%;
      transform: translate(-50%, -50%);
      text-align: center;
    }

    .timer1-time {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 6px;
      color: white;
    }

    .timer1-info {
      font-size: 14px;
      line-height: 1.3;
      color: white;
    }

    .timer1-info strong {
      cursor: pointer;
    }

    input.timer1-input {
      width: 50px;
      font-size: 14px;
      text-align: center;
      background: transparent;
      border: none;
      color: white;
      outline: none;
    }

    .timer1-bottom-controls {
      position: absolute;
      bottom: 50px;
      left: 50%;
      transform: translateX(-50%);
      display: flex;
      gap: 24px;
    }

    .timer1-btn {
      font-size: 20px;
      background: none;
      border: none;
      color: white;
      cursor: pointer;
      transition: 0.2s;
    }

    .timer1-btn:hover img {
      filter: brightness(1.2);
    }

    .timer1-btn img {
      width: 24px;
      height: 24px;
      vertical-align: middle;
    }
  </style>
</head>
<body>

<div class="timer1-timer-container" id="timerContainer">
  <div class="timer1-drag-handle">:::</div>

  <svg class="timer1-svg" width="240" height="240">
    <circle cx="120" cy="120" r="100" stroke="#333" stroke-width="12" fill="none" />
    <circle id="progress" cx="120" cy="120" r="100" stroke="#3f8efc" stroke-width="12"
            fill="none" stroke-linecap="butt" stroke-dasharray="628" />
  </svg>

  <div class="timer1-center">
    <div class="timer1-time" id="timeDisplay">10:00</div>
    <div class="timer1-info" id="timerInfo">
      <strong id="sessionTime">10:00</strong> 세션<br>
      과 <strong id="breakTime">05:00</strong> 휴식
    </div>
  </div>

  <div class="timer1-bottom-controls">
    <button class="timer1-btn" id="btnReset">⟲</button>
    <button class="timer1-btn" id="toggleBtn">
      <img id="toggleIcon" src="icon/아이콘_재생_1.png" alt="toggle" />
    </button>
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

  const RADIUS = 100;
  const CIRCUMFERENCE = 2 * Math.PI * RADIUS;

  const timeDisplay = document.getElementById("timeDisplay");
  const progressCircle = document.getElementById("progress");
  const sessionTimeEl = document.getElementById("sessionTime");
  const breakTimeEl = document.getElementById("breakTime");
  const toggleBtn = document.getElementById("toggleBtn");
  const toggleIcon = document.getElementById("toggleIcon");
  const btnReset = document.getElementById("btnReset");
  const timer = document.getElementById("timerContainer");
  const dragHandle = document.querySelector(".timer1-drag-handle");
  const timerInfo = document.getElementById("timerInfo");

  progressCircle.style.strokeDasharray = CIRCUMFERENCE;

  const formatTime = (seconds) => {
    const m = Math.floor(seconds / 60);
    const s = seconds % 60;
    return m + ":" + String(s).padStart(2, '0');
  };

  const updateProgress = () => {
    const duration = isSession ? sessionDuration : breakDuration;
    const percent = timeLeft / duration;
    const offset = CIRCUMFERENCE * (1 - percent);
    progressCircle.style.stroke = isSession ? "#3f8efc" : "#4caf50";
    progressCircle.style.strokeDashoffset = offset;
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
        toggleIcon.src = "icon/아이콘_재생_1.png";
        timerInfo.style.display = "block";
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
    input.className = "timer1-input";
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
    const rect = timer.getBoundingClientRect();
    offsetX = e.clientX - rect.left;
    offsetY = e.clientY - rect.top;
    isDragging = true;
    document.body.style.cursor = "grabbing";

    timer.style.transform = "none";
    timer.style.left = rect.left + "px";
    timer.style.top = rect.top + "px";
  });

  document.addEventListener("mousemove", (e) => {
    if (!isDragging) return;
    const x = e.clientX - offsetX;
    const y = e.clientY - offsetY;
    timer.style.left = x + "px";
    timer.style.top = y + "px";
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
