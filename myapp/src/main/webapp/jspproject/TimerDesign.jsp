<!-- TimerDesign.jsp -->
<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*, jspproject.*" %>
<%
  TimerMgr mgr = new TimerMgr();
  Vector<TimerBean> timerList = mgr.listTimer(0);
  String user_id = (String)session.getAttribute("user_id");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>타이머 탭</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/jspproject/css/TimerDesign.css" />
<style>
.timer-preview-box {
  width: 100%; height: 260px;
  position: relative; overflow: hidden;
  border-radius: 12px;
  box-shadow: 0 0 12px rgba(123, 44, 191, 0.6);
  background: white;
}
</style>
</head>

<body>

<div class="timer-container" id="timerContainer">
  <div class="timer-left">
    <div class="timer-tab">
      <button class="timer-tab-btn" onclick="switchToBackground()">배경화면</button>
      <button class="timer-tab-btn active">타이머</button>
    </div>

	<div class="timer-header">
	  <div class="timer-header-left"></div>
	  <div class="timer-header-right">
	    <div class="timer-filter-controls">
	      <img id="sortAlpha" class="timer-icontimerList" src="icon/아이콘_글자순_1.png" alt="글자순 정렬">
	      <input class="timer-search" type="text" placeholder="타이머 검색" />
	      <img id="searchTimerBtn" class="timer-icontimerList" src="icon/아이콘_검색_1.png" alt="검색">
	    </div>
	  </div>
	</div>

    <div class="timer-list" id="timerGrid"></div>
  </div>

  <div class="timer-right">
    <div class="timer-preview-wrapper">
      <div id="timerPreviewBox" class="timer-preview-box"></div>
    </div>
    <div id="selectedTimerLabel" class="timer-name-display"></div>
    <div class="timer-description">
      <textarea id="timerDescription" placeholder="타이머 설명을 입력하세요." readonly></textarea>
    </div>
<div class="timer-cancel-button">
  <button class="timer-btn-purple" id="btnCancel">타이머 취소</button>
</div>
    <div class="timer-right-buttons">
      <button class="timer-btn-purple" id="btnSave">적용</button>
    </div>
  </div>
</div>
<script>
const contextPath = "<%= request.getContextPath() %>";
const timerData = [
<% for (int i = 0; i < timerList.size(); i++) {
  TimerBean t = timerList.get(i);
%>
  {
    id: <%= t.getTimer_id() %>,
    label: "<%= t.getTimer_title().replace("\"", "\\\"") %>",
    description: "<%= t.getTimer_cnt() != null ? t.getTimer_cnt().replaceAll("\"", "\\\"").replaceAll("\r", "").replaceAll("\n", "\\n") : "" %>",
    thumb: contextPath + "/jspproject/img/<%= t.getTimer_img() %>",
    type: <%= t.getTimer_id() %>,
    session: 600,
    rest: 300
  }<%= (i < timerList.size() - 1) ? "," : ""%>
<% } %>
];

let selectedTimer = null;
let isAlphaSort = false;

function renderTimers(timers) {
  const grid = document.getElementById("timerGrid");
  grid.innerHTML = "";

  timers.forEach((timer) => {
    const div = document.createElement("div");
    div.className = "timer-button";
    const img = document.createElement("img");
    img.src = timer.thumb;
    img.alt = timer.label;
    img.className = "timer-thumb";
    div.appendChild(img);
    div.onclick = () => selectTimer(timer.type, timer.label, timer.description, timer.session, timer.rest);
    grid.appendChild(div);
  });
}

function selectTimer(type, label, description, session, rest) {
  selectedTimer = type;
  const previewBox = document.getElementById("timerPreviewBox");
  const labelBox = document.getElementById("selectedTimerLabel");
  const descriptionBox = document.getElementById("timerDescription");

  labelBox.textContent = label;
  descriptionBox.removeAttribute("readonly");
  descriptionBox.value = description || "";
  descriptionBox.setAttribute("readonly", true);
  previewBox.innerHTML = "";

  const iframe = document.createElement("iframe");
  iframe.src = "Timer" + type + ".jsp?session=" + session + "&break=" + rest + "&preview=true&t=" + new Date().getTime();
  Object.assign(iframe.style, {
    width: "100%",
    height: "100%",
    border: "none",
    borderRadius: "12px"
  });
  previewBox.appendChild(iframe);
}

function getFilteredAndSortedTimers() {
  const keyword = document.querySelector(".timer-search").value.trim().toLowerCase();
  let filtered = timerData.filter(timer => timer.label.toLowerCase().includes(keyword));

  const basic = filtered.find(t => t.type === 1);
  let others = filtered.filter(t => t.type !== 1);

  if(isAlphaSort){
    others.sort((a, b) => a.label.localeCompare(b.label));
  }

  return basic ? [basic, ...others] : others;
}

function refreshTimers() {
  renderTimers(getFilteredAndSortedTimers());
}

document.getElementById("sortAlpha").addEventListener("click", () => {
  isAlphaSort = !isAlphaSort;
  refreshTimers();
});

document.getElementById("searchTimerBtn").addEventListener("click", refreshTimers);
document.querySelector(".timer-search").addEventListener("input", refreshTimers);
document.querySelector(".timer-search").addEventListener("keypress", e => {
  if(e.key === "Enter") refreshTimers();
});

document.addEventListener("DOMContentLoaded", () => {
  refreshTimers();
  if(timerData.length > 0){
    const first = timerData.find(t => t.type === 1) || timerData[0];
    selectTimer(first.type, first.label, first.description, first.session, first.rest);
  }
});

// 적용 버튼 -> DB 저장
document.getElementById("btnSave").addEventListener("click", function(){
  if(!selectedTimer){
    alert("타이머를 선택해주세요.");
    return;
  }

  fetch("UpdateTimerIdProc.jsp", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: "user_id=<%= user_id %>&timer_id=" + selectedTimer
  })
  .then(res => res.text())
  .then(result => {
    if(result.trim() === "ok"){
      alert("타이머가 변경되었습니다!");
      reloadTimerView();  // 타이머 다시 로딩
    }else{
      alert("변경 실패 : " + result);
    }
  });
});

//취소 버튼 -> Timer1.jsp 리셋 + DB에도 timer_id=1 저장
document.getElementById("btnCancel").addEventListener("click", function(){

  selectedTimer = 1;  // 무조건 Timer1 고정
  const first = timerData.find(t => t.type === 1);
  if(!first) return;

  // 미리보기 다시 Timer1.jsp 로 변경
  selectTimer(first.type, first.label, first.description, first.session, first.rest);

  // DB에도 Timer1로 변경
  fetch("UpdateTimerIdProc.jsp", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: "user_id=<%= user_id %>&timer_id=1"
  }).then(res => res.text())
	   .then(result => {
	  if(result.trim() !== "ok"){
	    alert("DB 업데이트 실패 : " + result);
	  }
	});
});

function switchToBackground() {
    const timerWrapper = document.getElementById("timerWrapper1");
    if (timerWrapper) timerWrapper.style.display = "none";

    const backgroundWrapper = document.getElementById("backgroundWrapper");
    if (backgroundWrapper) backgroundWrapper.style.display = "flex";
}

</script>
</body>
</html>