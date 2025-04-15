<!-- Objective.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘, 내일</title>
<style>
@font-face {
	font-family: 'PFStarDust';
	src: url('fonts/PFStarDust-Bold.ttf') format('truetype');
	font-weight: bold;
	font-style: normal;
}

.pf-font {
	font-family: 'PFStarDust', sans-serif !important;
	color: white;
}


.obj-card-wrapper {
	background-color: rgba(29, 16, 45, 0.35); /* 기존 #1d102d = rgb(29,16,45) */
	padding: 5px;
	border-radius: 15px;
	box-shadow: 0 0 20px rgba(255,255,255,0.4);
	position: absolute;
	top: 100px;
	left: 100px;
	cursor: grab;
}

.obj-todo-card {
	width: 500px;
	height: 540px;
	padding: 20px;
	border-radius: 16px;
	background-color: rgba(29, 16, 45, 0.3); /* 기존 #1d102d = rgb(29,16,45) */
	position: relative;
	color: white;
	text-align: center;
}

.obj-top-dots {
	position: absolute;
	top: 5px;
	left: 50%;
	transform: translateX(-50%);
	font-size: 28px;
	color: white;
	cursor: grab;
	user-select: none;
}

.obj-todo-header {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 60px;
}

.obj-todo-title {
	background: none;
	border: 1px solid white;
	border-radius: 10px;
	color: white;
	font-size: 16px;
	padding: 10px 15px;
	width: 350px;
}

.obj-edit-btn {
	background: none;
	border: 1px solid white;
	border-radius: 10px;
	color: white;
	font-size: 18px;
	padding: 10px 15px;
	cursor: pointer;
}
.obj-edit-btn.selected {
	background-color: rgba(255, 255, 255, 0.3);
	color: #ffe0fd;
	transform: scale(1.05);
}
.obj-edit-btn:hover {
      background-color: rgba(255, 255, 255, 0.2);
      transform: scale(1.05);
      transition: all 0.2s ease;
  }

/* 드롭다운 메뉴 스타일 */
.dropdown-menu {
	position: absolute;
	background-color: rgba(147, 102, 192, 0.2);
	border: 1px solid white;
	border-radius: 10px;
	padding: 10px;
	display: none;
	z-index: 9999;
}

/* 드롭다운 항목 스타일 */
.dropdown-item {
	border: 1px solid white;
	border-radius: 8px;
	padding: 8px 15px;
	color: white;
	font-family: 'PFStarDust', sans-serif;
	margin-bottom: 5px;
	cursor: pointer;
	transition: background-color 0.2s ease;
}
.obj-todo-header {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 60px;
	position: relative; /*  이거 꼭 있어야 드롭다운 기준 맞음 */
}

.dropdown-item:hover {
	background-color: rgba(255, 255, 255, 0.2);
}


.obj-completed {
	position: absolute;
	top: 130px;
	left: 50px;
	font-size: 20px;
	color: white;
}

#obj-taskList {
	margin-top: 65px;
	margin-left: 20px;
	padding: 0 10px;
	display: flex;
	flex-direction: column;
	gap: 5px;
	height: 290px; /*  높이 고정 */
	overflow-y: auto; /*  스크롤 가능 */
	margin-bottom:20px;
}

#obj-taskList::-webkit-scrollbar {
    width: 10px;
}

#obj-taskList::-webkit-scrollbar-track {
    background: transparent;
}

#obj-taskList::-webkit-scrollbar-thumb {
    background-color: white;
    border-radius: 10px;
    border: 2px solid transparent;
    background-clip: content-box;
}

#obj-taskList::-webkit-scrollbar-button {
    display: none;
}

.obj-task-item {
	width: 419px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	background-color: #3c1e5c;
	color:white;
	border-radius: 10px;
	padding: 10px;
	position: relative;
	box-shadow: 0 0 8px rgba(123, 44, 191, 0.6);
	margin-bottom:5px;
}

.obj-task-left {
	display: flex;
	align-items: center;
	gap: 10px;
	flex: 1;
	 flex-wrap: wrap;
}

.obj-task-left input[type="text"] {
	flex: 1;
	min-width: 0;
	background: none;
	border: none;
	color: white;
	font-size: 16px;
}

.obj-task-left input[type="checkbox"] {
	appearance: none;
    width: 20px;
    height: 20px;
    border: 2px solid #ccc;
    border-radius: 4px;
    margin-left: 14px;
    cursor: pointer;
    transition: all 0.2s ease;
    position: relative;
    background-color: white;
}


.obj-task-left input[type="checkbox"]:checked {
	background-color: black;       /* 체크 시 검정색 채우기 */
	border-color: white;
}
	

.obj-task-left input[type="checkbox"]:checked::after {
	content: '✓';
	color: white;
	font-size: 11px;
	font-weight: bold;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-45%, -55%); /*  수직 위치 살짝 위로 */
}

.obj-start-date{
	display: inline-block;
	font-size: 14px;
	color: white;
	min-width: 120px;       /*  너비 확보 */
	display: inline-flex;   /*  텍스트 제대로 보이게 */
	align-items: center;    /*  중앙 정렬 */
}

.obj-created-date {
  display: inline-block;
  color: white;
  font-size: 10px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
 /*  max-width: 200px;  */
} 

.obj-task-buttons {
	display: none;
	gap: 5px;
}

.obj-task-buttons button {
	background: none;
	border: none;
	color: white;
	font-size: 18px;
	cursor: pointer;
}

.obj-task-item:hover .obj-task-buttons {
	display: flex;
} 
 
.obj-task-item:hover .obj-created-date {
	display:  inline-block;
}  


.obj-add-task-btn {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	bottom: 10px;
	width: 400px;
	height: 60px;
	padding: 10px;
	border-radius: 10px;
	background-color: rgba(255, 255, 255, 0.1);
	border: 1px solid white;
	color: white;
	cursor: pointer;
	font-size: 18px;
	margin-bottom:20px;
	font-family: 'PFStarDust', sans-serif;
}

#calendarModal {
	display: none;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: none;
	z-index: 9999;
}

.calendar-content {
	width: 500px;
	height: 500px;
	padding: 20px;
	border-radius: 16px;
	background-color: rgba(30, 0, 50, 0.95);
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
	position: absolute;
	border: 2px solid white;
	color: white;
	overflow-y: auto;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	transition: all 0.3s ease;
}
</style>

</head> 
<body>
	<div class="obj-card-wrapper" id="cardWrapper">
		<div class="obj-todo-card">
			<div class="obj-top-dots" id="dragHandle">:::</div>
			<div class="obj-todo-header" id="listButtonContainer"></div>
			<p class="obj-completed">
				완료된 항목 : <span id="completedNum">0</span>/<span id="totalNum">0</span>
			</p>
			
			<!-- ✅ 과제 리스트 영역을 form으로 감싸기 -->
			<form id="taskForm" onsubmit="return false;">
				<div id="obj-taskList"></div>
				<button type="button" class="obj-add-task-btn">과제 추가하기</button>
			</form>
		</div>
	</div>

<!-- ✅ 마감일 설정용 달력 폼 -->
<div id="calendarModal">
  <div class="calendar-content" id="calendarContent">
    <p id="calendarTitle">기간 설정</p>

    <label for="startDatePicker">시작일:</label>
    <input type="date" id="startDatePicker"><br>

    <label for="endDatePicker">마감일:</label>
    <input type="date" id="endDatePicker"><br>

    <button id="confirmDateBtn">확인</button>
  </div>
</div>

	<script>
        const handle = document.getElementById('dragHandle');
        const cardWrapper = document.getElementById('cardWrapper');
        const calendarContent = document.getElementById('calendarContent');
        const taskList = document.getElementById('obj-taskList');
        const addBtn = document.querySelector('.obj-add-task-btn');
        /* const calendarModal = document.getElementById('calendarModal'); */
        const calendarTitle = document.getElementById('calendarTitle');
        const calendarPicker = document.getElementById('calendarPicker'); 
        const confirmDateBtn = document.getElementById('confirmDateBtn');
       <%--  const user_id = "<%= userId %>";
	    sessionStorage.setItem("user_id", user_id);  --%>
        
        let currentTargetTask = null;
        let isDragging = false, offsetX = 0, offsetY = 0;
        handle.addEventListener('mousedown', (e) => {
            isDragging = true;
            offsetX = e.clientX - cardWrapper.offsetLeft;
            offsetY = e.clientY - cardWrapper.offsetTop;
            handle.style.cursor = 'grabbing';
        });
        document.addEventListener('mousemove', (e) => {
            if (isDragging) {
                cardWrapper.style.left = (e.clientX - offsetX) + 'px';
                cardWrapper.style.top = (e.clientY - offsetY) + 'px';
            }
        });
        document.addEventListener('mouseup', () => {
            isDragging = false;
            handle.style.cursor = 'grab';
        });

        function getFormattedDate() {
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0');
            const day = String(today.getDate()).padStart(2, '0');
            return `${year}/${month}/${day}`;
        }

        function updateCompleteCount() {
            const allTasks = document.querySelectorAll('#obj-taskList .obj-task-item');
            const total = allTasks.length;
            let completed = 0;

            allTasks.forEach(task => {
                const checkbox = task.querySelector('input[type="checkbox"]');
                if (checkbox && checkbox.checked) completed++;
            });

            document.getElementById('completedNum').textContent = completed;
            document.getElementById('totalNum').textContent = total;
        }
        
        //기본 1개의 리스트를 제공
        function createDefaultGroupOnce() {
	    return fetch("insertObjGroup.jsp", {
	        method: "POST",
	        headers: { "Content-Type": "application/x-www-form-urlencoded" },
	        body: "objgroup_name=" + encodeURIComponent("목표")
	    })
	    .then(res => res.text())
	    .then(id => {
	        console.log("✅ 기본 리스트 DB에 생성됨:", id);
	        localStorage.setItem("currentList", id);
	        renderTasksForCurrentList();
	        return id; // 혹시 이후에 .then(id => ...) 하게 된다면 필요함
	    })
	    .catch(err => {
	        console.error("❌ 기본 리스트 생성 실패:", err);z
	    });
	}
        
        function debounce(func, delay) {
            let timer;
            return function (...args) {
                clearTimeout(timer);
                timer = setTimeout(() => func.apply(this, args), delay);
            };
        }
        
        //이동시 재등록

       function escapeHtml(str) {
	    if (!str) return "";
	    return str
	        .replace(/&/g, "&amp;")
	        .replace(/"/g, "&quot;")
	        .replace(/</g, "&lt;")
	        .replace(/>/g, "&gt;")
	        .replace(/'/g, "&#39;")
	        .replace(/\//g, "&#47;") 
	        .replace(/\$/g, "&#36;") 
	        .replace(/{/g, "&#123;")
	        .replace(/}/g, "&#125;"); 
				}

        addBtn.addEventListener('click', () => {
            const currentList = localStorage.getItem("currentList");
            if (!currentList) return alert("리스트를 먼저 선택해주세요!");

            const taskData = JSON.parse(localStorage.getItem("taskData") || "{}");
            const today = getFormattedDate(); // ✅ 여기에서만 선언

            const newTask = {
                title: "",
                checked: false,
                date: today
            };

            if (!taskData[currentList]) taskData[currentList] = [];
            taskData[currentList].push(newTask);
            localStorage.setItem("taskData", JSON.stringify(taskData));

            const taskItem = document.createElement('div');
            taskItem.className = 'obj-task-item';

            taskItem.innerHTML = `
            	  <div class="obj-task-left">
            	    <input type="checkbox" class="task-check">
            	    <input type="text" class="pf-font" placeholder="과제 제목 입력" value="">
            	    <span class="obj-created-date" title="마감일이 지정되지 않았습니다.">기간을 설정해주세요</span>
            	  </div>
            	  <div class="obj-task-buttons">
            	    <button class="calendar-btn">📅</button>
            	    <button class="delete-task">X</button>
            	  </div>
            	`;
            //user_id 값 가져오기
			<%
            String userId = (String) session.getAttribute("user_id");
    		if (userId == null) userId = "";
    		 %>
			
    		const user_id = "<%= userId %>";
 		    sessionStorage.setItem("user_id", user_id); 
    		 
            // 제목 input에 포커스 주기
            const titleInput = taskItem.querySelector('input[type="text"]');
            titleInput.focus();
            
         	//서버에 insert 요청 보내기
            const taskObj = {
            	    user_id: sessionStorage.getItem("user_id") || "user01",
            	    obj_title: titleInput.value.trim(),
            	    obj_check: 0,
            	    obj_sdate: "",  // 초기값 설정
            	    obj_edate: "",
            	    objgroup_id: parseInt(localStorage.getItem("currentList"))
            	};

         	//과제 추가, 업데이트 실시간 타이머
            function debounce(func, delay) {
                let timeout;
                return function(...args) {
                    clearTimeout(timeout);
                    timeout = setTimeout(() => func.apply(this, args), delay);
                };
            }

            fetch("objInsertServlet", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(taskObj)
            })
            .then(res => res.json())
            .then(data => {
                const objId = data.obj_id;
                taskItem.dataset.objId = objId;
                
                taskList.appendChild(taskItem);
                updateCompleteCount();
                
                titleInput.focus();
                
                taskItem.querySelector(".calendar-btn").addEventListener("click", () => {
                    currentTargetTask = taskItem;
                    calendarTitle.textContent = `기간 설정: ${titleInput.value}`;
                    document.getElementById("startDatePicker").value = "";
                    document.getElementById("endDatePicker").value = "";
                    calendarModal.style.display = "block";
                    cardWrapper.style.display = "none";
                  });

                // 실시간 업데이트 (입력마다 서버에 전송)
                titleInput.addEventListener("input", debounce(() => {
                    const updatedTitle = titleInput.value.trim();
                    if (!updatedTitle) return;

                    fetch("objUpdateServlet", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({
                            obj_id: objId,
                            obj_title: updatedTitle
                        })
                    })
                    .then(res => res.json())
                    .then(data => {
                        console.log("📝 제목 실시간 업데이트 성공:", data);
                    })
                    .catch(err => {
                        console.error("❌ 제목 업데이트 실패:", err);
                    });
                }, 0)); // 👈 0.1초 디바운싱
                
               
               renderTasksForCurrentList();
                
                taskItem.querySelector(".delete-task").addEventListener("click", () => {
                    const confirmed = confirm(`"${titleInput.value.trim()}"을(를) 삭제하시겠습니까?`);
                    if (!confirmed) return;

                    taskItem.remove();
                    updateCompleteCount();

                    deleteTaskImmediately(objId); // objId 확보됐기 때문에 이제 가능!
                });
                updateCompleteCount();
            });
            
			//여기??
			const checkbox = taskItem.querySelector(".task-check");
            checkbox.addEventListener("change", () => {
                const checked = checkbox.checked ? 1 : 0;
                const objId = taskItem.dataset.objId;

                fetch("objCheckUpdateServlet", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({
                        obj_id: objId,
                        obj_check: checked
                    })
                })
                .then(res => res.json())
                .then(data => {
                    console.log("✅ 체크 상태 업데이트 완료", data);
                })
                .catch(err => {
                    console.error("❌ 체크 상태 업데이트 실패", err);
                });

                updateCompleteCount();
            });
        });

	// 날짜 확인 버튼 - 날짜 설정 및 서버 전송
confirmDateBtn.addEventListener('click', () => {
	const startDateVal = document.getElementById("startDatePicker").value;
	const endDateVal = document.getElementById("endDatePicker").value;

	if (!startDateVal || !endDateVal) {
		alert("📛 날짜를 모두 입력해주세요.");
		console.error("❌ 시작일 또는 마감일이 비어있습니다.");
		return;
	}

	if (!currentTargetTask) return;

	const objId = currentTargetTask.dataset.objId;
	if (!objId) return;

	// 날짜 라벨 업데이트
	const dateLabel = currentTargetTask.querySelector('.obj-created-date');
	if (dateLabel) {
		dateLabel.textContent = startDateVal + " ~ " + endDateVal;
		dateLabel.title = "마감일: " + endDateVal;
	}

	// 제목 가져오기
	const titleInput = currentTargetTask.querySelector("input[type='text']");
	const trimmedTitle = titleInput?.value.trim() || "";

	// 서버 반영
	fetch("objUpdateServlet", {
		method: "POST",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify({
			obj_id: objId,
			obj_title: trimmedTitle,
			obj_sdate: startDateVal,
			obj_edate: endDateVal
		})
	})
	.then(res => res.json())
	.then(result => {
		console.log("📅 날짜 업데이트 완료", result);
		setTimeout(() => {
			renderTasksForCurrentList();
		}, 300);
	})
	.catch(err => console.error("❌ 날짜 업데이트 실패", err));

	// 모달 닫기
	calendarModal.style.display = 'none';
	cardWrapper.style.display = 'block';
});



        window.addEventListener('click', (e) => {
            if (e.target === calendarModal) {
                calendarModal.style.display = 'none';
                cardWrapper.style.display = 'block';
            }
        });

        document.addEventListener("DOMContentLoaded", () => {

            //  위치 복원
            const savedLeft = localStorage.getItem("cardLeft") || "100";
            const savedTop = localStorage.getItem("cardTop") || "100";
            document.getElementById("cardWrapper").style.left = savedLeft + "px";
            document.getElementById("cardWrapper").style.top = savedTop + "px";
            
          
            loadCategoryButtons();
            renderTasksForCurrentList();          
        });
    
       
		
		function deleteTaskImmediately(objId) {
		    console.log("🧪 삭제 요청 시도:", objId);

		
		    fetch("objDeleteServlet", {
		        method: "POST",
		        headers: { "Content-Type": "application/json" },
		        body: JSON.stringify({ obj_id: objId })
		    })
		    .then(res => res.json())
		    .then(data => {
		        if (data.status === "success") {
		            console.log("🗑️ 삭제 성공:", objId);
		        } else {
		            console.error("❌ 삭제 실패: 서버 응답 실패");
		        }
		    })
		    .catch(err => {
		        console.error("❌ 삭제 요청 실패:", err);
		    });
		}

  	
            function attachDeleteListener(taskItem, objId, titleInput) {
                taskItem.querySelector(".delete-task").addEventListener("click", () => {
                    if (!objId) {
                        alert("❌ 아직 서버에 저장되지 않았습니다. 잠시 후 시도하세요.");
                        return;
                    }

                    const confirmed = confirm(`"${titleInput.value.trim()}"을(를) 삭제하시겠습니까?`);
                    if (!confirmed) return;

                    taskItem.remove(); // UI 반영
                    updateCompleteCount();

                    deleteTaskImmediately(objId); // 서버 요청
                });
            }
            
            
            function loadCategoryButtons() {
            	  const listContainer = document.getElementById('listButtonContainer');
            	  listContainer.innerHTML = "";

            	  // 📦 보관함 버튼 먼저 만들어두기 (선언 먼저!)
            	  const archiveBtn = document.createElement('button');
            	  archiveBtn.className = 'obj-edit-btn';
            	  archiveBtn.textContent = '✉'; 
            	  archiveBtn.title = '보관함 보기';

            	  archiveBtn.addEventListener('click', () => {
            	    renderArchiveTasks();
            	    document.querySelectorAll('.obj-edit-btn, .dropdown-item').forEach(btn => btn.classList.remove('selected'));
            	    archiveBtn.classList.add('selected');
            	  });

            	  // ✎ 편집 버튼도 미리 선언
            	  const editBtn = document.createElement('button');
            	  editBtn.className = 'obj-edit-btn';
            	  editBtn.textContent = '✎';
            	  editBtn.title = '카테고리 편집';

            	  editBtn.addEventListener('click', () => {
            	    const rect = document.getElementById('cardWrapper').getBoundingClientRect();
            	    localStorage.setItem("cardLeft", Math.floor(rect.left));
            	    localStorage.setItem("cardTop", Math.floor(rect.top));

            	    document.getElementById("cardWrapper").style.display = "none";
            	    document.getElementById("listCardWrapper").style.display = "block";
            	  });

            	  // 📂 카테고리 불러오기
            	  fetch("getObjGroupList.jsp")
            	    .then(res => res.json())
            	    .then(data => {
            	      if (data.length === 0) {
            	        createDefaultGroupOnce().then(() => loadCategoryButtons());
            	        return;
            	      }

            	      const maxVisible = 3;
            	      const visible = data.slice(0, maxVisible);
            	      const hidden = data.slice(maxVisible);

            	      // 기본 visible 버튼
            	      visible.forEach(group => {
            	        const btn = document.createElement('button');
            	        btn.className = 'obj-edit-btn';
            	        btn.textContent = group.objgroup_name;

            	        const selectedId = localStorage.getItem("currentList");
            	        if (group.objgroup_id == selectedId) btn.classList.add("selected");

            	        btn.addEventListener('click', () => {
            	          document.querySelectorAll('.obj-edit-btn, .dropdown-item').forEach(b => b.classList.remove('selected'));
            	          btn.classList.add('selected');

            	          localStorage.setItem("currentList", group.objgroup_id);
            	          localStorage.setItem("currentListName", group.objgroup_name);

            	          fetch("objCurrentGroupSetServlet", {
            	            method: "POST",
            	            headers: { "Content-Type": "application/json" },
            	            body: JSON.stringify({ objgroup_id: group.objgroup_id })
            	          })
            	            .then(() => renderTasksForCurrentList())
            	            .catch(err => console.error("❌ 그룹 설정 실패:", err));
            	        });

            	        listContainer.appendChild(btn);
            	      });

            	      // 드롭다운 처리
            	      if (hidden.length > 0) {
            	        const dropdownBtn = document.createElement('button');
            	        dropdownBtn.className = 'obj-edit-btn';
            	        dropdownBtn.textContent = '...';

            	        const dropdownMenu = document.createElement('div');
            	        dropdownMenu.className = 'dropdown-menu';

            	        hidden.forEach(group => {
            	          const item = document.createElement('div');
            	          item.className = 'dropdown-item';
            	          item.textContent = group.objgroup_name;

            	          const selectedId = localStorage.getItem("currentList");
            	          if (group.objgroup_id == selectedId) item.classList.add("selected");

            	          item.addEventListener('click', () => {
            	            document.querySelectorAll('.obj-edit-btn, .dropdown-item').forEach(b => b.classList.remove('selected'));
            	            item.classList.add('selected');

            	            localStorage.setItem("currentList", group.objgroup_id);
            	            localStorage.setItem("currentListName", group.objgroup_name);

            	            fetch("objCurrentGroupSetServlet", {
            	              method: "POST",
            	              headers: { "Content-Type": "application/json" },
            	              body: JSON.stringify({ objgroup_id: group.objgroup_id })
            	            }).then(() => {
            	              renderTasksForCurrentList();
            	              dropdownMenu.style.display = 'none';
            	            });
            	          });

            	          dropdownMenu.appendChild(item);
            	        });

            	        dropdownBtn.addEventListener('click', () => {
            	          dropdownMenu.style.top = dropdownBtn.offsetTop + dropdownBtn.offsetHeight + 'px';
            	          dropdownMenu.style.left = (dropdownBtn.offsetLeft - 5) + 'px';
            	          dropdownMenu.style.display = dropdownMenu.style.display === 'none' ? 'block' : 'none';
            	        });

            	        document.addEventListener('click', (e) => {
            	          if (!dropdownBtn.contains(e.target) && !dropdownMenu.contains(e.target)) {
            	            dropdownMenu.style.display = 'none';
            	          }
            	        });

            	        listContainer.appendChild(dropdownBtn);
            	        listContainer.appendChild(dropdownMenu);
            	      }

            	      // ✅ 버튼은 무조건 마지막에 추가!
            	      listContainer.appendChild(editBtn);
            	      listContainer.appendChild(archiveBtn);
            	    })
            	    .catch(err => {
            	      console.error("❌ 리스트 불러오기 실패:", err);
            	    });
            	}

            
            
            
            
            
            
            
            function renderArchiveTasks() {
            	  fetch("objArchivedListServlet")
            	    .then(res => res.json())
            	    .then(data => {
            	      const taskList = document.getElementById("obj-taskList");
            	      taskList.innerHTML = "";

            	      if (data.status !== "success") {
            	        console.error("❌ 보관함 데이터 불러오기 실패:", data.message);
            	        return;
            	      }

            	      const tasks = data.data;

            	      if (tasks.length === 0) {
            	        taskList.innerHTML = `
            	          <div style="text-align: center; color: white; padding-top: 30px;">
            	             완료된 과제가 없습니다.
            	          </div>`;
            	        return;
            	      }

            	      console.log("📦 보관함 과제 수:", tasks.length);

            	      tasks.forEach(task => {
            	        const taskItem = document.createElement("div");
            	        taskItem.className = "obj-task-item";
            	        taskItem.dataset.objId = task.obj_id;

            	        // ✅ 제목 및 날짜
            	        const safeTitle = task.obj_title?.trim() || "제목 없음";
            	        const sdate = task.obj_sdate || "";
            	        const edate = task.obj_edate || "";
            	        const dateLabel = sdate && edate ? `${sdate} ~ ${edate}` : "기간을 설정해주세요";

            	        // ✅ task-left
            	        const taskLeft = document.createElement("div");
            	        taskLeft.className = "obj-task-left";

            	        const checkbox = document.createElement("input");
            	        checkbox.type = "checkbox";
            	        checkbox.className = "task-check";
            	        checkbox.checked = task.obj_check === 1;

            	        const titleInput = document.createElement("input");
            	        titleInput.type = "text";
            	        titleInput.className = "pf-font";
            	        titleInput.value = safeTitle;
            	        titleInput.readOnly = true;

            	        const dateSpan = document.createElement("span");
            	        dateSpan.className = "obj-created-date";
            	        dateSpan.textContent = dateLabel;
            	        dateSpan.title = "마감일: " + (edate || "없음");

            	        taskLeft.appendChild(checkbox);
            	        taskLeft.appendChild(titleInput);
            	        taskLeft.appendChild(dateSpan);

            	        // ✅ 버튼 영역
            	        const btnWrap = document.createElement("div");
            	        btnWrap.className = "obj-task-buttons";

            	        const deleteBtn = document.createElement("button");
            	        deleteBtn.className = "delete-task";
            	        deleteBtn.textContent = "X";

            	        btnWrap.appendChild(deleteBtn);

            	        // ✅ 전체 조립
            	        taskItem.appendChild(taskLeft);
            	        taskItem.appendChild(btnWrap);
            	        taskList.appendChild(taskItem);

            	        // ✅ 체크 해제 처리 → 리스트로 복귀
            	        checkbox.addEventListener("change", () => {
            	          const isChecked = checkbox.checked ? 1 : 0;

            	          fetch("objCheckUpdateServlet", {
            	            method: "POST",
            	            headers: { "Content-Type": "application/json" },
            	            body: JSON.stringify({
            	              obj_id: task.obj_id,
            	              obj_check: isChecked
            	            })
            	          })
            	            .then(res => res.json())
            	            .then(result => {
            	              console.log("🔁 체크 상태 변경:", result);
            	              if (isChecked === 0) {
            	            	  taskItem.remove();
            	            	  updateCompleteCount();
            	              } else {
            	                renderArchiveTasks(); // 재랜더링
            	              }
            	            });
            	        });

            	        // ✅ 삭제 처리
            	        deleteBtn.addEventListener("click", () => {
            	          const confirmed = confirm(`"${task.obj_title}"을(를) 삭제할까요?`);
            	          if (!confirmed) return;

            	          fetch("objDeleteServlet", {
            	            method: "POST",
            	            headers: { "Content-Type": "application/json" },
            	            body: JSON.stringify({ obj_id: task.obj_id })
            	          })
            	            .then(res => res.json())
            	            .then(() => {
            	              taskItem.remove();
            	              updateCompleteCount();
            	            });
            	        });
            	      });

            	      updateCompleteCount();
            	    })
            	    .catch(err => {
            	      console.error("❌ 보관함 fetch 오류:", err);
            	    });
            	}
     
            //화면 출력되는 부분
           let isRendering = false;
           async function renderTasksForCurrentList(objgroup_id) {
        	if (isRendering) return; // 중복 방지
        	//isRendering = true;
            	
            const taskList = document.getElementById("obj-taskList");
		    taskList.innerHTML = "";
		
		    const selectedId = localStorage.getItem("currentList");
		
		    try {
		        // 1. 현재 그룹 ID를 세션에 저장
		        const groupRes = await fetch("objCurrentGroupSetServlet", {
		            method: "POST",
		            headers: { "Content-Type": "application/json" },
		            body: JSON.stringify({ objgroup_id: parseInt(selectedId) })
		        });
		
		        const groupData = await groupRes.json();
		        
		        if (groupData.status !== "success") {
		            throw new Error("❌ 그룹 설정 실패");
		        }
		
		        // 2. 그룹 설정 성공 → 과제 리스트 요청
		        const listRes = await fetch("objListServlet");
		        const tasks = await listRes.json();

		        // 3. 과제 데이터 렌더링 시작
		        tasks.forEach(task => {
		        	   if (task.obj_check === 1) return;
		            // 기본 정보 추출
		            const {
		                obj_id,
		                obj_title,
		                obj_check,
		                obj_sdate,
		                obj_edate
		            } = task;
		
		         // 안전한 텍스트 처리
		            const safeTitle = escapeHtml(obj_title?.trim() || "제목 없음");
		         
		            // 날짜 방어적 처리
		            const sTrimmed = typeof obj_sdate === "string" ? obj_sdate.trim() : "";
		            const eTrimmed = typeof obj_edate === "string" ? obj_edate.trim() : "";
		
		            // 4. 과제 DOM 요소 생성
		            const taskItem = document.createElement("div");
		            taskItem.className = "obj-task-item";
		            taskItem.dataset.objId = obj_id;
		
		            taskItem.innerHTML = `
		                <div class="obj-task-left">
		                    <input type="checkbox" class="task-check">
		                    <input type="text" class="pf-font" placeholder="과제 제목 입력" value="${safeTitle}">
		                </div>
		                <div class="obj-task-buttons">
		                    <button class="calendar-btn">📅</button>
		                    <button class="delete-task">X</button>
		                </div>
		            `;
						
		            const titleInput = taskItem.querySelector("input[type='text']");
		            titleInput.value = task.obj_title || "";
		            
		            // 5. 날짜 라벨 추가
		            const dateLabel = document.createElement("span");
		            dateLabel.className = "obj-created-date";
		
		            if (obj_sdate && obj_edate) {
		            	  const s = obj_sdate.trim();
		            	  const e = obj_edate.trim();
		            	  dateLabel.textContent = s + " ~ " + e;
		            	  dateLabel.title = `마감일: ${e}`;
		            	} else {
		            	  dateLabel.textContent = "기간을 설정해주세요";
		            	  dateLabel.title = "마감일이 지정되지 않았습니다.";
		            	}
		
		            // 6. 라벨 DOM에 부착
		            const taskLeft = taskItem.querySelector(".obj-task-left");
		            taskLeft.appendChild(dateLabel);
		
		            // 7. DOM에 과제 추가
		            taskList.appendChild(taskItem);
		           
		
		            // 8. 체크박스 상태 반영
		            const checkbox = taskItem.querySelector(".task-check");
		            checkbox.checked = obj_check === 1;
		
		            checkbox.addEventListener("change", () => {
		                const checked = checkbox.checked ? 1 : 0;
		
		                fetch("objCheckUpdateServlet", {
		                    method: "POST",
		                    headers: { "Content-Type": "application/json" },
		                    body: JSON.stringify({ obj_id, obj_check: checked })
		                })
		                    .then(res => res.json())
		                    .then(data => {
		                        console.log("✅ 체크 상태 업데이트 성공:", data);
		                        
		                        if (checked === 1) {
		                            taskItem.remove(); // 즉시 제거
		                            updateCompleteCount();
		                          }
		                        
		                        updateCompleteCount();
		                    })
		                    .catch(err => console.error("❌ 체크 상태 업데이트 실패:", err));
		            });
		
		            // 9. 제목 실시간 저장
		            titleInput.addEventListener("input", debounce(() => {
		                const updatedTitle = titleInput.value.trim();
		                if (!updatedTitle) return;
		
		                fetch("objUpdateServlet", {
		                    method: "POST",
		                    headers: { "Content-Type": "application/json" },
		                    body: JSON.stringify({
		                        obj_id,
		                        obj_title: updatedTitle,
		                        obj_sdate,
		                        obj_edate,
		                        obj_check: checkbox.checked ? 1 : 0
		                    })
		                });
		            }, 300));
		            
		            // 10. 삭제 버튼
		            attachDeleteListener(taskItem, obj_id, titleInput);
		
		            // 11. 달력 버튼
		            const calendarBtn = taskItem.querySelector(".calendar-btn");
		            taskItem.querySelector(".calendar-btn").addEventListener("click", () => {
		                
		            	currentTargetTask = taskItem;
		                
		            	calendarTitle.textContent = `기간 설정: ${titleInput.value}`;
		            	document.getElementById("startDatePicker").value = "";
		                document.getElementById("endDatePicker").value = "";
		            	
		            	calendarModal.style.display = "block";
		                cardWrapper.style.display = "none";
		            });
		        });
		       
		        // 12. 완료 체크 수 업데이트
		        updateCompleteCount();
		        isRendering = false;

		    } catch (err) {
		        console.error("❌ 과제 목록 불러오기 실패:", err);
		        isRendering = false;
		    }
		}
    </script>
</body>
</html>