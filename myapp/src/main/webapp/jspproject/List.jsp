<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>목록 추가</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: "Noto Sans KR", sans-serif;
            background: url('your-background.jpg') no-repeat center center fixed;
            background-size: cover;
            overflow: hidden;
        }

        .card-container {
            position: absolute;
            padding: 5px;
            background-color: rgba(147, 102, 192, 0.2); 
            border: 2px solid white;
            border-radius: 22px;
            box-shadow: 0 0 10px rgba(0,0,0,0.3);
            cursor: grab;
        }

        .new-list-card {
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
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .top-dots {
            position: absolute;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 28px;
            color: white;
            cursor: grab;
            user-select: none;
        }

        .title-input {
            width: 80%;
            margin-top: 50px;
            padding: 10px;
            font-size: 18px;
            border: none;
            border-bottom: 1px solid white;
            background: transparent;
            color: white;
            text-align: center;
        }

        .list-container {
            margin-top: 20px;
            width: 80%;
            max-height: 200px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        
        .list-container::-webkit-scrollbar {
			    display: none;            
			}

		.list-item {
		    padding: 10px 0;
		    width: 100%;
		    border-bottom: 2px solid white;  
		    color: white;
		    font-size: 18px;
		    text-align: center;
		    background: transparent;         
		    border-radius: 0;                
        
		}

        .custom-button {
            position: absolute;
            width: 80%;
            padding: 12px;
            font-size: 16px;
            border-radius: 10px;
            background-color: #1c0035;
            color: white;
            border: 1px solid white;
            margin-bottom: 15px;
            cursor: pointer;
        }

        .add-btn {
            top: 400px;
            width: 350px;
            border: 2px solid white;
        }

        .view-btn {
            top: 460px;
            width: 350px;
            border: 2px solid white;
        }

        .custom-button:hover {
            background-color: #33005a;
        }
    </style>
</head>
<body>

   		<div class="card-container">
        <div class="new-list-card">
            <div class="top-dots">:::</div>
            <input type="text" class="title-input" placeholder="새로운 목록" readonly />
            <div class="list-container" id="listContainer"></div>
            <button class="custom-button add-btn">＋ 리스트 추가하기</button>
            <button class="custom-button view-btn">목록 확인</button>
        </div>
    </div>

    <script>
        // 드래그 기능
        const dragHandle = document.querySelector('.top-dots');
        const card = document.querySelector('.card-container');

        let isDragging = false;
        let offsetX = 0;
        let offsetY = 0;

        dragHandle.addEventListener('mousedown', function (e) {
            isDragging = true;
            offsetX = e.clientX - card.offsetLeft;
            offsetY = e.clientY - card.offsetTop;
        });

        document.addEventListener('mousemove', function (e) {
            if (isDragging) {
                card.style.left = (e.clientX - offsetX) + 'px';
                card.style.top = (e.clientY - offsetY) + 'px';
            }
        });

        document.addEventListener('mouseup', function () {
            isDragging = false;
        });

        // 리스트 추가 기능
        const addBtn = document.querySelector('.add-btn');
        const listContainer = document.getElementById('listContainer');

        let count = 1;
        addBtn.addEventListener('click', function () {
            const newItem = document.createElement('div');
            newItem.className = 'list-item';

            // ✅ 리스트 이름을 입력 가능한 텍스트박스로
            const input = document.createElement('input');
            input.type = 'text';
            input.value = `예제 ${count}`;
            input.style.border = 'none';
            input.style.background = 'transparent';
            input.style.color = 'black';
            input.style.fontSize = '18px';
            input.style.textAlign = 'center';
            input.style.width = '90%';
            input.style.outline = 'none';

            // 삭제 버튼
            const deleteBtn = document.createElement('span');
            deleteBtn.textContent = '✕';
            deleteBtn.style.float = 'right';
            deleteBtn.style.marginRight = '10px';
            deleteBtn.style.cursor = 'pointer';
            deleteBtn.style.color = 'white';
            deleteBtn.style.fontWeight = 'bold';

            deleteBtn.addEventListener('click', function () {
                const confirmed = confirm(`"${input.value}" 항목을 정말 삭제하시겠습니까?`);
                if (confirmed) {
                    listContainer.removeChild(newItem);
                    
                    let currentLists = JSON.parse(localStorage.getItem("userLists") || "[]");
                    currentLists = currentLists.filter(name => name !== input.value);
                    localStorage.setItem("userLists", JSON.stringify(currentLists));
                }
            });

            newItem.appendChild(input);
            newItem.appendChild(deleteBtn);
            listContainer.appendChild(newItem);
            input.focus();
            count++;
        });
        //위치 복원
        window.addEventListener("DOMContentLoaded", function () {
            const card = document.querySelector('.card-container');
            const left = localStorage.getItem("cardLeft") || "100";
            const top = localStorage.getItem("cardTop") || "100";

            card.style.left = left + "px";
            card.style.top = top + "px";
            
            const storedLists = JSON.parse(localStorage.getItem("userLists") || "[]");
            const listContainer = document.getElementById("listContainer");

            storedLists.forEach(name => {
                const item = document.createElement('div');
                item.className = 'list-item';

                const input = document.createElement('input');
                input.type = 'text';
                input.value = name;
                input.style.border = 'none';
                input.style.background = 'transparent';
                input.style.color = 'black';
                input.style.fontSize = '18px';
                input.style.textAlign = 'center';
                input.style.width = '90%';
                input.style.outline = 'none';

                const deleteBtn = document.createElement('span');
                deleteBtn.textContent = '✕';
                deleteBtn.style.float = 'right';
                deleteBtn.style.marginRight = '10px';
                deleteBtn.style.cursor = 'pointer';
                deleteBtn.style.color = 'white';
                deleteBtn.style.fontWeight = 'bold';

                deleteBtn.addEventListener('click', () => {
                    const confirmed = confirm(`"${input.value}" 항목을 정말 삭제하시겠습니까?`);
                    if (confirmed) {
                        listContainer.removeChild(item);
                        
                        let currentLists = JSON.parse(localStorage.getItem("userLists") || "[]");
                        currentLists = currentLists.filter(name => name !== input.value);
                        localStorage.setItem("userLists", JSON.stringify(currentLists));
                    }
                });

                item.appendChild(input);
                item.appendChild(deleteBtn);
                listContainer.appendChild(item);
            });
        });
        //Objective.jsp로 이동
        const viewBtn = document.querySelector('.view-btn');
        const cardContainer = document.querySelector('.card-container');

        viewBtn.addEventListener('click', function () {
            const rect = cardContainer.getBoundingClientRect();
            const left = Math.floor(rect.left + window.scrollX);
            const top = Math.floor(rect.top + window.scrollY);

            localStorage.setItem("cardLeft", left);
            localStorage.setItem("cardTop", top);
            
            const existingLists = JSON.parse(localStorage.getItem("userLists") || "[]");

            const listItems = document.querySelectorAll(".list-item input[type='text']");
            const newListNames = Array.from(listItems)
                .map(input => input.value.trim())
                .filter(name => name.length > 0);  // 빈 값 제거

            const mergedLists = [...new Set([...existingLists, ...newListNames])];

            localStorage.setItem("userLists", JSON.stringify(mergedLists));

            window.location.href = "Objective.jsp";
        });

    </script>
</body>
</html>
