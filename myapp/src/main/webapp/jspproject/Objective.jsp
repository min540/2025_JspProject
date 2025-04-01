<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오늘, 내일</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            background-color: white;
            font-family: "Noto Sans KR", sans-serif;
            overflow: hidden;
        }
        .card-wrapper {
            background-color: rgba(147, 102, 192, 0.2);
            padding: 5px;
            border-radius: 22px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            position: absolute;
            top: 100px;
            left: 100px;
            cursor: grab;
            border: 2px solid white;
        }
        .todo-card {
            width: 500px;
            height: 500px;
            padding: 20px;
            border-radius: 16px;
            background-color: rgba(147, 102, 192, 0.2);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            position: relative;
            color: white;
            text-align: center;
            border: 2px solid white;
        }
        .top-dots {
            position: absolute;
            top: 5px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 50px;
            color: white;
            cursor: grab;
            user-select: none;
        }
        .todo-header {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 60px;
        }
        .todo-title {
            background: none;
            border: 1px solid white;
            border-radius: 10px;
            color: white;
            font-size: 16px;
            padding: 10px 15px;
            width: 350px;
        }
        .edit-btn {
            background: none;
            border: 1px solid white;
            border-radius: 10px;
            color: white;
            font-size: 18px;
            padding: 10px 15px;
            cursor: pointer;
        }
        .completed {
            position: absolute;
            top: 130px;
            left: 50px;
            font-size: 20px;
            color: black;
            
        }
		#taskList {
		    margin-top: 65px;
		    margin-left: 20px;
		    padding: 0 10px;
		    display: flex;
		    flex-direction: column;
		    gap: 5px;
		    
		    height: 270px; /* ✅ 높이 고정 */
		    overflow-y: auto; /* ✅ 스크롤 가능 */
		}
        .task-item {
            width: 419px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: rgba(186,133,238);
            border-radius: 10px;
            padding: 10px;
            border: 2px solid white;
            position: relative;
        }
        .task-left {
            display: flex;
            align-items: center;
            gap: 10px;
            flex: 1;
        }
        .task-left input[type="text"] {
            background: none;
            border: none;
            color: white;
            font-size: 16px;
        }
        .task-left input[type="checkbox"] {
            width: 20px;
            height: 20px;
        }
        .created-date {
            display: inline-block;
            font-size: 14px;
            color: white;
        }
        .task-buttons {
            display: none;
            gap: 5px;
        }
        .task-buttons button {
            background: none;
            border: none;
            color: white;
            font-size: 18px;
            cursor: pointer;
        }
        .task-item:hover .task-buttons {
            display: flex;
        }
        .task-item:hover .created-date {
            display: none;
        }
        .add-task-btn {
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            bottom: 15px;
            width: 400px;
            height: 60px;
            padding: 10px;
            border-radius: 10px;
            background-color: rgba(255, 255, 255, 0.1);
            border: 1px solid white;
            color: white;
            cursor: pointer;
            font-size: 18px;
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
    <div class="card-wrapper" id="cardWrapper">
        <div class="todo-card">
            <div class="top-dots" id="dragHandle">:::</div>
            <div class="todo-header">
                <input type="text" class="todo-title" placeholder="새로운 목록" readonly />
                <button class="edit-btn">✎</button>
            </div>
           <p class="completed">
  완료된 항목 : <span id="completedNum">0</span>/<span id="totalNum">0</span>
</p>
            <div id="taskList"></div>
            <button class="add-task-btn">과제 추가하기</button>
        </div>
    </div>

    <div id="calendarModal">
        <div class="calendar-content" id="calendarContent">
            <p id="calendarTitle" style="font-size: 20px; margin-bottom: 20px;">마감일 설정: </p>
            <input type="date" id="calendarPicker" style="padding: 10px; border-radius: 10px; border: none;"><br><br>
            <button id="confirmDateBtn" style="padding: 10px 20px; font-size: 16px; border-radius: 10px; background-color: rgba(255,255,255,0.1); border: 1px solid white; color: white; cursor: pointer;">날짜 확인</button>
        </div>
    </div>

	<div id="newListCard" style="display: none;">
    <div class="calendar-content" style="text-align: center;">
        <input type="text" placeholder="새로운 목록" style="width: 80%; padding: 10px; border-radius: 10px; border: none; margin-bottom: 20px;"><br>
        <button style="margin-bottom: 10px; width: 80%; padding: 10px; border-radius: 10px; border: 1px solid white; background: none; color: white;">+ 리스트 추가하기</button><br>
        <button style="width: 80%; padding: 10px; border-radius: 10px; border: 1px solid white; background: none; color: white;">목록 확인</button>
    </div>
</div>

    <script>
        const handle = document.getElementById('dragHandle');
        const cardWrapper = document.getElementById('cardWrapper');
        const calendarContent = document.getElementById('calendarContent');
        const taskList = document.getElementById('taskList');
        const addBtn = document.querySelector('.add-task-btn');
        const calendarModal = document.getElementById('calendarModal');
        const calendarTitle = document.getElementById('calendarTitle');
        const calendarPicker = document.getElementById('calendarPicker');
        const confirmDateBtn = document.getElementById('confirmDateBtn');
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
            const allTasks = document.querySelectorAll('#taskList .task-item');
            const total = allTasks.length;
            let completed = 0;

            allTasks.forEach(task => {
                const checkbox = task.querySelector('input[type="checkbox"]');
                if (checkbox && checkbox.checked) completed++;
            });

            document.getElementById('completedNum').textContent = completed;
            document.getElementById('totalNum').textContent = total;
        }


        addBtn.addEventListener('click', () => {
            const taskItem = document.createElement('div');
            taskItem.className = 'task-item';
            const today = getFormattedDate();

            taskItem.innerHTML = `
                <div class="task-left">
                    <input type="checkbox" class="task-check">
                    <input type="text" placeholder="과제 제목 입력" value="">
                    <span class="created-date">${today}</span>
                </div>
                <div class="task-buttons">
                    <button class="calendar-btn">📅</button>
                    <button class="delete-task">X</button>
                </div>
            `;

            taskList.appendChild(taskItem);

            // 제목 input에 포커스 주기
            const titleInput = taskItem.querySelector('input[type="text"]');
            titleInput.focus();

            const checkbox = taskItem.querySelector('.task-check');
            checkbox.addEventListener('change', updateCompleteCount);

            taskItem.querySelector('.delete-task').addEventListener('click', () => {
                const title = titleInput.value.trim();
                if (title.length > 0) {
                    const confirmed = confirm(`"${title}"을(를) 정말 삭제하시겠습니까?`);
                    if (confirmed) {
                        taskItem.remove();
                        updateCompleteCount();
                    }
                } else {
                    const confirmed = confirm(`이 항목을 정말 삭제하시겠습니까?`);
                    if (confirmed) {
                        taskItem.remove();
                        updateCompleteCount();
                    }
                }
            });

            taskItem.querySelector('.calendar-btn').addEventListener('click', () => {
                currentTargetTask = taskItem;
                const title = taskItem.querySelector('input[type="text"]').value;
                calendarTitle.textContent = `마감일 설정: ${title}`;
                calendarContent.style.left = cardWrapper.offsetLeft + 'px';
                calendarContent.style.top = cardWrapper.offsetTop + 'px';
                cardWrapper.style.display = 'none';
                calendarModal.style.display = 'block';
            });

            updateCompleteCount();
        });


        confirmDateBtn.addEventListener('click', () => {
            const selectedDate = calendarPicker.value;
            if (selectedDate && currentTargetTask) {
                const dateSpan = currentTargetTask.querySelector('.created-date');
                dateSpan.textContent = selectedDate.replace(/-/g, '/');
                calendarModal.style.display = 'none';
                cardWrapper.style.display = 'block';
            }
        });

        window.addEventListener('click', (e) => {
            if (e.target === calendarModal) {
                calendarModal.style.display = 'none';
                cardWrapper.style.display = 'block';
            }
        });

        // ✅ 페이지 로드시 초기 항목 체크 갱신 및 이벤트 연결
        updateCompleteCount();
        document.querySelectorAll('#taskList input[type="checkbox"]').forEach(cb => {
            cb.addEventListener('change', updateCompleteCount);
        });
        const editBtn = document.querySelector('.edit-btn');
        const newListCard = document.getElementById('newListCard');

        editBtn.addEventListener('click', () => {
            cardWrapper.style.display = 'none';   // 기존 카드 숨기기
            newListCard.style.display = 'block';  // 새로운 카드 보이기
        });
    </script>
    
</body>
</html>
