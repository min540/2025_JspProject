<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>휴식 타이머</title>
  <style>
    body {
      margin: 0;
      background: transparent;
    }

    .rest-timer-wrapper {
      width: 220px;
      height: 220px;
      margin: auto;
      position: relative;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
    }

    .dots {
      display: grid;
      grid-template-columns: repeat(3, 6px);
      grid-template-rows: repeat(2, 6px);
      gap: 6px;
      position: absolute;
      top: 10px;
      right: 10px;
    }

    .dots div {
      width: 6px;
      height: 6px;
      background-color: white;
      border-radius: 50%;
    }

    .circle-timer {
      width: 100%;
      height: 100%;
      position: relative;
    }

    svg {
      transform: rotate(-90deg);
    }

    .circle-bg {
      fill: none;
      stroke: #444;
      stroke-width: 10;
    }

    .circle-progress {
      fill: none;
      stroke: #3C7A50;
      stroke-width: 10;
      stroke-linecap: round;
      transition: stroke-dashoffset 0.3s linear;
    }

    .time-text {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      color: white;
      font-size: 20px;
      font-family: 'PFStarDust', sans-serif;
      text-align: center;
    }

    .knob {
      width: 14px;
      height: 14px;
      background-color: #3C7A50;
      border-radius: 50%;
      position: absolute;
      top: 0;
      left: 50%;
      transform: translate(-50%, -7px);
      cursor: pointer;
    }
  </style>
</head>
<body>
  <div class="rest-timer-wrapper">
    <!-- 3x2 점 -->
    <div class="dots">
      <div></div><div></div><div></div>
      <div></div><div></div><div></div>
    </div>

    <!-- 원형 타이머 -->
    <div class="circle-timer">
      <svg width="220" height="220">
        <circle class="circle-bg" cx="110" cy="110" r="90" />
        <circle class="circle-progress" cx="110" cy="110" r="90" stroke-dasharray="565.48" stroke-dashoffset="0" />
      </svg>
      <div class="time-text" id="restTimeText">05:00</div>
      <div class="knob" id="restKnob"></div>
    </div>
  </div>

  <script>
    document.addEventListener("DOMContentLoaded", () => {
      const knob = document.getElementById("restKnob");
      const circle = document.querySelector(".circle-progress");
      const text = document.getElementById("restTimeText");

      const radius = 90;
      const circumference = 2 * Math.PI * radius;
      circle.style.strokeDasharray = circumference;
      let angle = 0;

      function updateProgress(percent) {
        const offset = circumference * (1 - percent);
        circle.style.strokeDashoffset = offset;
      }

      function angleFromMouse(x, y) {
        const rect = circle.getBoundingClientRect();
        const centerX = rect.left + rect.width / 2;
        const centerY = rect.top + rect.height / 2;
        const dx = x - centerX;
        const dy = y - centerY;
        return Math.atan2(dy, dx);
      }

      function updateKnobPosition(angleRad) {
        const x = 110 + radius * Math.cos(angleRad);
        const y = 110 + radius * Math.sin(angleRad);
        knob.style.left = `${x}px`;
        knob.style.top = `${y}px`;
      }

      function setTimeByAngle(rad) {
        const percent = (rad + Math.PI / 2) / (2 * Math.PI);
        const clamped = Math.max(0, Math.min(1, percent));
        const totalSeconds = 5 * 60; // 기본 5분
        const current = Math.floor(totalSeconds * clamped);
        const m = String(Math.floor(current / 60)).padStart(2, '0');
        const s = String(current % 60).padStart(2, '0');
        text.textContent = `${m}:${s}`;
        updateProgress(clamped);
        updateKnobPosition(rad);
      }

      let dragging = false;

      knob.addEventListener("mousedown", (e) => {
        dragging = true;
      });

      document.addEventListener("mousemove", (e) => {
        if (!dragging) return;
        const rad = angleFromMouse(e.clientX, e.clientY);
        setTimeByAngle(rad);
      });

      document.addEventListener("mouseup", () => {
        dragging = false;
      });

      // 초기값 설정
      setTimeByAngle(-Math.PI / 2); // 12시 방향
    });
  </script>
</body>
</html>
