<%@page import="jspproject.UserTimerBean"%>
<%@page import="jspproject.UserTimerMgr"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="TimerInfo.jsp" %>
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


<div class="timer1-timer-container" id="timerContainer" style="left:<%= left %>px; top:<%= top %>px;">
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
	const userId = "<%= user_id %>";
	let sessionDuration = <%= sessionTime %>;
	let breakDuration = <%= breakTime %>;
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

  // 알림 표시 함수
  const showNotification = (message) => {
    // 이미 존재하는 알림 제거
    const existingNotification = document.querySelector('.notification');
    if (existingNotification) {
      document.body.removeChild(existingNotification);
    }
    
    // 새 알림 생성
    const notification = document.createElement('div');
    notification.className = 'notification';
    notification.textContent = message;
    document.body.appendChild(notification);
    
    // 알림 표시
    setTimeout(() => {
      notification.classList.add('show');
    }, 10);
    
    // 3초 후 알림 사라짐
    setTimeout(() => {
      notification.classList.remove('show');
      setTimeout(() => {
        if (notification.parentNode) {
          document.body.removeChild(notification);
        }
      }, 300);
    }, 3000);
  };

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
			body: "user_id=" + userId + "&timer_session=" + parseInt(sessionDuration) + "&timer_break=" + parseInt(breakDuration)
		})
		.then(res => res.text())
		.then(data => console.log("세션/브레이크 저장 결과 : ", data));
	};

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
    	updateTimerSettingToDB();  // ← 여기서만 호출
    	resetTimer();
    };


    input.addEventListener("blur", confirm);
    input.addEventListener("keydown", (e) => {
      if (e.key === "Enter") confirm();
    });

    el.replaceWith(input);
    input.focus();
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

  sessionTimeEl.addEventListener("click", () => makeEditable(sessionTimeEl, "session"));
  breakTimeEl.addEventListener("click", () => makeEditable(breakTimeEl, "break"));

  const startInterval = () => {
    interval = setInterval(() => {
      if (timeLeft > 0) {
        timeLeft--;
        updateProgress();
      } else {
        clearInterval(interval);
        
        if (isSession) {
          // 작업 세션이 끝났음을 알림과 동시에 휴식 세션 시작
          showNotification("작업 시간이 끝났습니다!");
          
          // 휴식 세션으로 전환 및 자동 시작
          isSession = false;
          timeLeft = breakDuration;
          updateProgress();
          startInterval();
          isRunning = true;
          toggleIcon.src = "icon/아이콘_일시정지_1.png";
          timerInfo.style.display = "none";
        } else {
          // 휴식 세션이 끝났음을 알림
          showNotification("휴식 시간이 끝났습니다! 작업을 시작해주세요.");
          
          // 작업 세션으로 전환 및 자동 시작
          isSession = true;
          timeLeft = sessionDuration;
          updateProgress();
          startInterval();
          isRunning = true;
          toggleIcon.src = "icon/아이콘_일시정지_1.png";
          timerInfo.style.display = "none";
        }
      }
    }, 1000);
  };

  sessionTimeEl.textContent = formatTime(sessionDuration);
  breakTimeEl.textContent = formatTime(breakDuration);
  updateProgress();

  // Drag 기능 그대로 유지
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

	    let x = parseInt(timer.style.left);
	    let y = parseInt(timer.style.top);

	    // 화면 벗어나는거 방지 (너가 원하는 최소 값으로 설정 가능)
	    if(x < 10) x = 10;
	    if(y < 10) y = 10;

	    fetch("UpdateTimerSessionProc.jsp", {
	      method: "POST",
	      headers: { "Content-Type": "application/x-www-form-urlencoded" },
	      body: "user_id=" + userId + "&timer_loc=" + x + "," + y
	    })
	    .then(res => res.text())
	    .then(data => console.log("위치 저장 결과 : ", data));
	  }
	});

});
</script>


</body>
</html>