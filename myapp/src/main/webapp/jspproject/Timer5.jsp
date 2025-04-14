<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="TimerInfo.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>휴식 타이머</title>
    <style>
    body {
      overflow: hidden;
      margin: 0;
    }

    .timer5-timer-container {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 240px;
      height: 240px;
      border-radius: 50%;
      background: #1C1B2A;
      user-select: none;
      cursor: default;
    }

    .timer5-svg {
      position: absolute;
      top: 0;
      left: 0;
      transform: rotate(90deg) scaleX(-1);
    }

    .timer5-drag-handle {
      position: absolute;
      top: 30px;
      left: 50%;
      transform: translateX(-50%);
      font-size: 28px;
      color: white;
      user-select: none;
      cursor: grab;
      z-index: 10;
    }

    .timer5-center {
      position: absolute;
      top: 47%;
      left: 50%;
      transform: translate(-50%, -50%);
      text-align: center;
    }

    .timer5-time {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 6px;
      color: white;
    }

    .timer5-time strong {
      cursor: pointer;
    }

    input.timer5-input {
      width: 50px;
      font-size: 18px;
      text-align: center;
      background: transparent;
      border: none;
      color: white;
      outline: none;
    }

    .timer5-bottom-controls {
      position: absolute;
      bottom: 50px;
      left: 50%;
      transform: translateX(-50%);
      display: flex;
      gap: 24px;
    }

    .timer5-btn {
      font-size: 20px;
      background: none;
      border: none;
      color: white;
      cursor: pointer;
      transition: 0.2s;
    }

    .timer5-btn:hover {
      opacity: 0.8;
    }
  </style>
</head>
<body>

<div class="timer5-timer-container" id="timerContainer" style="left:<%= left %>px; top:<%= top %>px; <%= extraStyle %>">
  <div class="timer5-drag-handle">:::</div>

  <svg class="timer5-svg" width="240" height="240">
    <circle cx="120" cy="120" r="100" stroke="#333" stroke-width="12" fill="none" />
    <circle id="progress" cx="120" cy="120" r="100" stroke="#60BAAF" stroke-width="12" fill="none" stroke-linecap="butt" stroke-dasharray="628" />
  </svg>

  <div class="timer5-center">
    <div class="timer5-time" id="timeDisplay"><strong id="editableTime">00:00</strong></div>
  </div>

  <div class="timer5-bottom-controls">
    <button class="timer5-btn" id="btnReset">⟲</button>
    <button class="timer5-btn" id="toggleBtn"><img id="toggleIcon" src="icon/아이콘_재생_1.png" width="24" height="24" /></button>
  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
  const isPreview = "<%= request.getParameter("preview") != null %>" === "true";
  const userId = "<%= user_id %>";
  let sessionDuration = <%= sessionTime %>;
  let breakDuration = <%= breakTime %>;
  let timeLeft = breakDuration;
  let isRunning = false;
  let interval = null;

  const RADIUS = 100;
  const CIRCUMFERENCE = 2 * Math.PI * RADIUS;

  const editableTime = document.getElementById("editableTime");
  const progressCircle = document.getElementById("progress");
  const toggleIcon = document.getElementById("toggleIcon");
  const btnReset = document.getElementById("btnReset");
  const toggleBtn = document.getElementById("toggleBtn");
  const timer = document.getElementById("timerContainer");
  const dragHandle = document.querySelector(".timer5-drag-handle");

  progressCircle.style.strokeDasharray = CIRCUMFERENCE;

  const formatTime = (sec) => {
    const m = Math.floor(sec / 60);
    const s = sec % 60;
    return m + ":" + String(s).padStart(2, '0');
  };

  const updateProgress = () => {
    const percent = timeLeft / breakDuration;
    const offset = CIRCUMFERENCE * (1 - percent);
    progressCircle.style.strokeDashoffset = offset;
    editableTime.textContent = formatTime(timeLeft);
  };

  const updateTimerSettingToDB = () => {
    fetch("UpdateTimerSessionProc.jsp", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: "user_id=" + userId + "&timer_session=" + sessionDuration + "&timer_break=" + breakDuration
    }).then(res => res.text())
      .then(data => console.log(data));
  };

  const resetTimer = () => {
    clearInterval(interval);
    isRunning = false;
    timeLeft = breakDuration;
    toggleIcon.src = "icon/아이콘_재생_1.png";
    updateProgress();
  };

  updateProgress();

  btnReset.addEventListener("click", resetTimer);

  toggleBtn.addEventListener("click", () => {
    if (isRunning) {
      clearInterval(interval);
      isRunning = false;
      toggleIcon.src = "icon/아이콘_재생_1.png";
    } else {
      interval = setInterval(() => {
        if (timeLeft > 0) {
          timeLeft--;
          updateProgress();
        } else {
          clearInterval(interval);
          isRunning = false;
          toggleIcon.src = "icon/아이콘_재생_1.png";
        }
      }, 1000);
      isRunning = true;
      toggleIcon.src = "icon/아이콘_일시정지_1.png";
    }
  });

  editableTime.addEventListener("click", () => {
    const input = document.createElement("input");
    input.type = "number";
    input.className = "timer5-input";
    input.value = Math.floor(breakDuration / 60);

    const confirm = () => {
      let val = parseInt(input.value);
      if (isNaN(val) || val < 1) val = 1;
      if (val > 3600) val = 3600;
      breakDuration = val * 60;
      timeLeft = breakDuration;
      input.replaceWith(editableTime);
      updateTimerSettingToDB();
      updateProgress();
    };

    input.addEventListener("blur", confirm);
    input.addEventListener("keydown", (e) => {
      if (e.key === "Enter") confirm();
    });

    editableTime.replaceWith(input);
    input.focus();
  });

  if (!isPreview) {
    // Drag 기능 (미리보기에서는 안됨)
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
      timer.style.left = (e.clientX - offsetX) + "px";
      timer.style.top = (e.clientY - offsetY) + "px";
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
          .then(data => console.log("Timer5 위치 저장 결과 : ", data));
      }
    });
  }
});
</script>
</body>
</html>
