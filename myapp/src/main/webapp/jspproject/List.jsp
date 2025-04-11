<%@ page contentType="text/html; charset=UTF-8"%>

    <style>

        .card-container {
            position: absolute;
            padding: 5px;
            background-color: rgba(29, 16, 45, 0.35);
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(255,255,255,0.4);
            cursor: grab;
        }

        .new-list-card {
            width: 500px;
            height: 500px;
            padding: 20px;
            border-radius: 16px;
            background-color: rgba(29, 16, 45, 0.3);
            position: relative;
            color: white;
            text-align: center;
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
        
        .title-label {
		    font-size: 20px;
		    font-weight: bold;
		    margin-top: 30px;
		    color: white;
		}

        .list-container {
            margin-top: 20px;
            width: 80%;
            max-height: 300px;
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
            font-family: 'PFStarDust', sans-serif !important;
        }

        .view-btn {
            top: 460px;
            width: 350px;
            border: 2px solid white;
            font-family: 'PFStarDust', sans-serif !important;
        }

        .custom-button:hover {
            background-color: #33005a;
        }
    </style>

   		<div class="card-container">
        <div class="new-list-card">
            <div class="top-dots">:::</div>
            <div class="title-label">새로운 목록</div>
            <div class="list-container" id="listContainer"></div>
            <button class="custom-button add-btn">＋ 리스트 추가하기</button>
            <button class="custom-button view-btn">목록 확인</button>
        </div>
    </div>

    <script>
    function reloadCategoryButtons() {
        const listContainer = document.getElementById('listButtonContainer');
        listContainer.innerHTML = ""; // 기존 버튼들 제거

        fetch("getObjGroupList.jsp")
            .then(res => res.json())
            .then(data => {
                data.forEach(group => {
                    const btn = document.createElement('button');
                    btn.className = 'obj-edit-btn';
                    btn.textContent = group.objgroup_name;

                    btn.addEventListener('click', () => {
                        localStorage.setItem("currentList", group.objgroup_id);
                        localStorage.setItem("currentListName", group.objgroup_name);
                        renderTasksForCurrentList(); // 과제 목록 갱신
                    });

                    listContainer.appendChild(btn);
                });

                // 편집 버튼도 다시 추가
                const editBtn = document.createElement('button');
                editBtn.className = 'obj-edit-btn';
                editBtn.textContent = '✎';
                editBtn.addEventListener('click', () => {
                    const rect = document.getElementById('cardWrapper').getBoundingClientRect();
                    localStorage.setItem("cardLeft", Math.floor(rect.left));
                    localStorage.setItem("cardTop", Math.floor(rect.top));
                    document.getElementById("cardWrapper").style.display = "none";
                    document.getElementById("listCardWrapper").style.display = "block";
                });
                listContainer.appendChild(editBtn);
            });
    }
		
    function attachDeleteGroupListener(deleteBtn, itemElement, groupId, input) {
        deleteBtn.addEventListener("click", () => {
            const confirmed = confirm(`"${input.value}" 항목을 정말 삭제하시겠습니까?`);
            if (!confirmed) return;

            itemElement.remove(); // UI에서 제거

            fetch("deleteObjGroup.jsp", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "objgroup_id=" + groupId
            })
            .then(res => res.text())
            .then(msg => console.log("🗑️ 삭제 완료:", msg))
            .catch(err => console.error("❌ 삭제 실패:", err));
        });
    }

    
        // 드래그 기능
        const dragHandle = document.querySelector('.top-dots');
        const card = document.querySelector('.card-container');

        window.isDraggingList = false;
        window.offsetXList = 0;
        window.offsetYList = 0;

        dragHandle.addEventListener('mousedown', function (e) {
            window.isDraggingList = true;
            window.offsetXList = e.clientX - card.offsetLeft;
            window.offsetYList = e.clientY - card.offsetTop;
        });

        document.addEventListener('mousemove', function (e) {
            if (window.isDraggingList) {
                card.style.left = (e.clientX - window.offsetXList) + 'px';
                card.style.top = (e.clientY - window.offsetYList) + 'px';
            }
        });

        document.addEventListener('mouseup', function () {
            window.isDraggingList = false;
        });

        // 리스트 추가 기능
        const addBtnList = document.querySelector('.add-btn');
        const listContainer = document.getElementById('listContainer');

        let count = 1;
        addBtnList.addEventListener('click', function () {
            const newItem = document.createElement('div');
            newItem.className = 'list-item';

            const input = document.createElement('input');
            input.type = 'text';
            input.value = `예제 ${count}`;
            input.style = '...';

            const deleteBtn = document.createElement('span');
            deleteBtn.textContent = '✕';
            deleteBtn.style = '...';
            
            input.style.border = 'none';
            input.style.background = 'transparent';
            input.style.color = 'white';
            input.style.fontSize = '18px';
            input.style.textAlign = 'center';
            input.style.width = '90%';
            input.style.outline = 'none';
            // 우선 DOM에 추가
            newItem.appendChild(input);
            newItem.appendChild(deleteBtn);
            listContainer.appendChild(newItem);
            input.focus();
            count++;

            // DB에 저장하고 id 받아오기
            fetch("insertObjGroup.jsp", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "objgroup_name=" + encodeURIComponent(input.value)
            })
            .then(res => res.text())
            .then(id => {
            	id = id.trim();
                /* console.log("🆔 새로 추가된 objgroup_id:", id); */
                
                attachDeleteGroupListener(deleteBtn, newItem, id, input);

                // 🎯 여기에 디바운스 + 수정 업데이트 연결
                const debounce = (func, delay) => {
                    let timer;
                    return function (...args) {
                        clearTimeout(timer);
                        timer = setTimeout(() => func.apply(this, args), delay);
                    };
                   
                };

                const updateCategoryName = debounce(() => {
                    fetch("updateObjGroup.jsp", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: "objgroup_id=" + id + "&objgroup_name=" + encodeURIComponent(input.value)
                    })
                    .then(res => res.text())
                    .then(msg => console.log("📝 수정 응답:", msg))
                    .catch(err => console.error("❌ 수정 실패:", err));
                }, 500);

                input.addEventListener("input", updateCategoryName);
            })
            .catch(err => {
                console.error("❌ insert 실패:", err);
            });
        });

        //위치 복원
       window.addEventListener("DOMContentLoaded", function () {
    const card = document.querySelector('.card-container');
    const left = localStorage.getItem("cardLeft") || "100";
    const top = localStorage.getItem("cardTop") || "100";

    card.style.left = left + "px";
    card.style.top = top + "px";

    const listContainer = document.getElementById("listContainer");

    // 🔥 DB에서 리스트 불러오기
    fetch("getObjGroupList.jsp")
        .then(response => response.json())
        .then(data => {
            data.forEach(group => {
                const item = document.createElement("div");
                item.className = "list-item";

                const input = document.createElement("input");
                input.type = "text";
                input.value = group.objgroup_name;
                input.style.border = 'none';
                input.style.background = 'transparent';
                input.style.color = 'white';
                input.style.fontSize = '18px';
                input.style.textAlign = 'center';
                input.style.width = '90%';
                input.style.outline = 'none';
                
             // 디바운스 함수 정의 (공통)
                function debounce(func, delay) {
                    let timer;
                    return function (...args) {
                        clearTimeout(timer);
                        timer = setTimeout(() => func.apply(this, args), delay);
                    };
                }
				
                //  수정 내용을 서버에 반영
                const updateCategoryName = debounce(() => {
                    fetch("updateObjGroup.jsp", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: "objgroup_id=" + group.objgroup_id + "&objgroup_name=" + encodeURIComponent(input.value)
                    })
                    .then(res => res.text())
                    .then(msg => console.log("📝 수정 응답:", msg))
                    .catch(err => console.error("❌ 수정 실패:", err));
                }, 800); // 800ms 후에 서버에 요청

                //  input 이벤트 연결
                input.addEventListener("input", updateCategoryName);

                const deleteBtn = document.createElement("span");
                deleteBtn.textContent = "✕";
                deleteBtn.style = 'float: right; margin-right: 10px; cursor: pointer; color: white; font-weight: bold;';
                deleteBtn.addEventListener("click", function () {
                    const confirmed = confirm(`"${input.value}" 항목을 정말 삭제하시겠습니까?`);
                    if (confirmed) {
                        listContainer.removeChild(item);

                        //  DB에서 삭제 요청도 가능!
                        fetch("deleteObjGroup.jsp", {
                             method: "POST",
                             headers: {
                                 "Content-Type": "application/x-www-form-urlencoded"
                             },
                             body: "objgroup_id=" + group.objgroup_id
                         });
                    }
                });

                item.appendChild(input);
                item.appendChild(deleteBtn);
                listContainer.appendChild(item);
            });
        })
        .catch(err => {
            console.error("❌ 리스트 불러오기 실패:", err);
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
        		.filter(name => name.length > 0);

        	const mergedLists = [...new Set([...existingLists, ...newListNames])];
        	localStorage.setItem("userLists", JSON.stringify(mergedLists));

        	// ✅ 화면 전환: 리스트 → 작업목표
        	document.getElementById("listCardWrapper").style.display = "none";
        	document.getElementById("objWrapper").style.display = "block";

        	// ✅ 내부 카드도 강제 표시
        	const cardWrapper = document.getElementById("cardWrapper");
        	if (cardWrapper) {
        		cardWrapper.style.display = "block";
        		cardWrapper.style.left = (localStorage.getItem("cardLeft") || "100") + "px";
        		cardWrapper.style.top = (localStorage.getItem("cardTop") || "100") + "px";
        	}

        	// ✅ 과제 다시 렌더링
        	if (typeof renderTasksForCurrentList === 'function') {
        		renderTasksForCurrentList();
        	}
        	
        	reloadCategoryButtons();  // ✨ 최신 리스트 불러오기
            renderTasksForCurrentList(); // 선택된 리스트 기준으로 과제 보여주기
        });
       
    </script>