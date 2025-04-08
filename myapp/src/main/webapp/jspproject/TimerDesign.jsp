<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>타이머 탭</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/jspproject/css/TimerDesign.css" />

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
          <img id="sortAlpha" class="icontimerList" src="icon/아이콘_글자순_1.png" alt="글자순 정렬">
          <img id="sortLatest" class="icontimerList" src="icon/아이콘_오래된순_최신순_1.png" alt="최신순 정렬">
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
      <div id="selectedTimerLabel" class="timer-name-display"></div>

      <div class="timer-description">
        <textarea id="timerDescription" placeholder="타이머 설명을 입력하세요." readonly></textarea>
      </div>

      <div class="timer-cancel-button">
        <button class="btn-purple">타이머 취소</button>
      </div>

      <div class="timer-right-buttons">
        <button class="btn-purple" id="btnSave">적용</button>
      </div>
    </div>
  </div>

  <script>
    const contextPath = "<%= request.getContextPath() %>";

    document.addEventListener("DOMContentLoaded", () => {
      let selectedTimer = null;
      let currentSort = "default";

      const timerData = [
        {
          thumb: contextPath + "/jspproject/img/기본타이머.png",
          label: "기본 타이머",
          type: 1,
          description: "기본적인 세션 타이머입니다."
        },
        {
          thumb: contextPath + "/jspproject/img/보라색타이머.png",
          label: "보라색타이머",
          type: 2,
          description: "집중할 때 사용하는 보라색 테마의 타이머입니다."
        }
      ];

      const styles = {
        1: "customTimer",
        2: "purpleTimer"
      };

      const grid = document.getElementById("timerGrid");
      const searchInput = document.querySelector(".timer-search");
      const searchBtn = document.getElementById("searchTimerBtn");
      const sortAlphaBtn = document.getElementById("sortAlpha");
      const sortLatestBtn = document.getElementById("sortLatest");

      function renderTimers(timers) {
        grid.innerHTML = "";
        timers.forEach((timer) => {
          const div = document.createElement("div");
          div.className = "timer-button";

          const img = document.createElement("img");
          img.src = timer.thumb;
          img.alt = timer.label;
          img.className = "timer-thumb";

          div.appendChild(img);
          div.onclick = () => selectTimer(timer.type);
          grid.appendChild(div);
        });
      }

      function selectTimer(num) {
        selectedTimer = num;
        const previewBox = document.getElementById("timerPreviewBox");
        const labelBox = document.getElementById("selectedTimerLabel");
        const descriptionBox = document.getElementById("timerDescription");
        const selected = timerData.find(t => t.type === num);

        labelBox.textContent = selected ? selected.label : "";
        descriptionBox.value = selected ? selected.description || "" : "";

        previewBox.innerHTML = "";

        if (styles[num] === "customTimer" || styles[num] === "purpleTimer") {
          const iframe = document.createElement("iframe");
          iframe.src = styles[num] === "customTimer" ? "Timer.jsp" : "Timer2.jsp";
          iframe.style.width = "100%";
          iframe.style.height = "100%";
          iframe.style.border = "none";
          iframe.style.position = "absolute";
          iframe.style.top = "0";
          iframe.style.left = "0";
          iframe.style.pointerEvents = "auto";
          iframe.style.borderRadius = "12px";

          previewBox.style.position = "relative";
          previewBox.appendChild(iframe);
        } else {
          previewBox.innerHTML = styles[num] || `<div style='color:white;'>미리보기 없음</div>`;
        }
      }

      document.getElementById("btnSave").addEventListener("click", () => {
        const name = document.getElementById("selectedTimerLabel").textContent;
        const description = document.getElementById("timerDescription").value;

        fetch("saveTimer.jsp", {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: "name=" + encodeURIComponent(name) + "&description=" + encodeURIComponent(description)
        })
        .then(res => res.text())
        .then(data => {
          alert("저장됨: " + data);
        });
      });

      function getFilteredAndSortedTimers() {
        const keyword = searchInput.value.trim().toLowerCase();
        let filtered = timerData.filter(timer => timer.label.toLowerCase().includes(keyword));

        if (currentSort === "alpha") {
          filtered.sort((a, b) => a.label.localeCompare(b.label));
        } else if (currentSort === "latest") {
          filtered.sort((a, b) => b.type - a.type);
        }
        return filtered;
      }

      function refreshTimers() {
        renderTimers(getFilteredAndSortedTimers());
      }

      searchInput.addEventListener("input", refreshTimers);
      searchBtn.addEventListener("click", refreshTimers);
      searchInput.addEventListener("keypress", (e) => {
        if (e.key === "Enter") refreshTimers();
      });

      sortAlphaBtn.addEventListener("click", () => {
        currentSort = (currentSort === "alpha") ? "default" : "alpha";
        refreshTimers();
      });

      sortLatestBtn.addEventListener("click", () => {
        currentSort = (currentSort === "latest") ? "default" : "latest";
        refreshTimers();
      });

      refreshTimers();
      selectTimer(1);
    });
  </script>
</body>
</html>
