<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="jmgr" class="jspproject.JourMgr"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>다이어리</title>
  <style>
    body {
            font-family: Arial, sans-serif;
            background: url('https://lrl.kr/data/editor/2012/1608011704.3617sunset-horizon-scenery-landscape-art-uhdpaper.com-4K-178.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #ffffff;
            margin: 0;
            display: flex;
            height: 100vh;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

		 .container {
		  position: absolute;
		  top: 50px;
		  left: 50px;
		  width: 1100px;
		  height: 716px;
		  display: flex;
		  gap: 12px;
		  border-radius: 10px;
		  border: 3px solid rgba(255, 255, 255, 0.2);
		  background: rgba(47, 9, 84, 0.2); /* 진한 보라색 계열 + 살짝 투명 */
		}

		.sidebar {
		  width: 298px;
		  display: flex;
		  flex-direction: column;
		  justify-content: space-between; /* ✅ 하단 버튼 고정 */
		  background: rgba(47, 9, 84, 0.35);
		  border: 3px solid rgba(255, 255, 255, 0.8);
		  padding: 20px;
		  border-radius: 12px;
		  overflow: hidden;
		}
		
		.top-section {
		  flex-grow: 1;
		  display: flex;
		  flex-direction: column;
		  overflow: hidden;
		}
		
		.diary-list::-webkit-scrollbar {
		  width: 8px; /* 스크롤 너비 */
		}
		
		.diary-list::-webkit-scrollbar-track {
		  background: transparent;
		}
		
		.diary-list::-webkit-scrollbar-thumb {
		  background-color: #663399;  /* ✅ 보라색 */
		  border-radius: 4px;
		}
		
		.diary-list::-webkit-scrollbar-thumb:hover {
		  background-color: #8A2BE2;  /* 마우스 오버 시 더 밝은 보라색 */
		}


	.content {
	  flex-grow: 1;
	  border: 3px solid rgba(255, 255, 255, 0.8);
  	  background: rgba(47, 9, 84, 0.25);
	  padding: 20px;
	  border-radius: 12px;  /* ✅ 전체 둥글게 */
	  display: flex;
	  flex-direction: column;
	}

    .button {
       width: 100%;
  padding: 12px;
  margin-bottom: 15px;
  background: #230B3D;
  border: 3px solid rgba(255, 255, 255, 0.8);  /* ✅ 흰색 테두리 */
  border-radius: 8px;
  color: white;
  font-weight: bold;
  cursor: pointer;
    }

    .diary-list {
      flex-grow: 1;
      overflow-y: auto;
      margin-top: 10px;
    }

    .placeholder {
      text-align: center;
      color: rgba(255, 255, 255, 0.6);
      padding: 10px;
      font-size: 14px;
    }

    .entry {
      display: flex;
      align-items: center;
      justify-content: flex-start;
      gap: 10px;
      background: rgba(255, 255, 255, 0.1);
      border: 3px solid rgba(255, 255, 255, 0.3);
      padding: 10px;
      border-radius: 6px;
      margin-bottom: 8px;
      font-size: 14px;
      cursor: pointer;
    }

    .entry input[type="checkbox"] {
      accent-color: #8A2BE2; /* 체크박스 선택된 색 */
  	margin-right: 10px;
    }
    
    #select-all {
  accent-color: #8A2BE2;
}

    .entry .title {
      color: white;
      font-weight: bold;
      flex-grow: 1;
      overflow: hidden;
      white-space: nowrap;
      text-overflow: ellipsis;
    }

    .entry .date {
      font-size: 12px;
      color: rgba(255, 255, 255, 0.7);
      margin-left: 8px;
    }

    .delete-button {
  width: 100%;
  padding: 12px;
  margin-bottom: 15px;
  background: #230B3D;
  border: 3px solid rgba(255, 255, 255, 0.8);  /* ✅ 흰색 테두리 */
  border-radius: 8px;
  color: white;
  font-weight: bold;
  cursor: pointer;
}

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
    }

	.title-input {
	  width: 100%;
	  padding: 10px 5px;
	  font-size: 16px;
	  border: none;
	  border-bottom: 1px solid white;
	  border-radius: 0;
	  background: transparent;
	  color: white;
	  outline: none;
	}

.title-input::placeholder {
  color: rgba(255, 255, 255, 0.7);
}


    .icon-container {
      display: flex;
      gap: 12px;
      margin-left: 10px;
    }

	.icon {
	  width: 36px;
	  height: 36px;
	  cursor: pointer;
	  filter: brightness(0) invert(1); /* 흰색처럼 보이게 */
	}


  .input-field {
  flex-grow: 1;
  width: 95%;
  height: 300px; /* ✅ 원하는 고정 높이 설정 */
  padding: 16px;
  font-size: 15px;
  border: none;
  border-radius: 0;
  background: transparent;
  color: white;
  outline: none;
  margin-top: 10px;
  resize: none; /* ✅ 크기 조절 막기 */
}

.input-field::placeholder {
  color: rgba(255, 255, 255, 0.6);
}


    /* 모달 스타일 */
    #deleteModal {
      display: none;
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background: rgba(0, 0, 0, 0.6);
      justify-content: center;
      align-items: center;
      z-index: 1000;
    }

    #deleteModal .modal-box {
      background: white;
      padding: 30px;
      border-radius: 10px;
      width: 350px;
      text-align: center;
      color: black;
    }

    #deleteModal img {
      width: 40px;
      height: 40px;
      margin-bottom: 15px;
    }

    #deleteModal button {
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    #deleteModal .cancel {
      background: #ccc;
    }

    #deleteModal .confirm {
      background: #d33;
      color: white;
    }
  </style>

  <script>
    let currentDiary = null;

    window.onload = function () {
      showInitialMessage();
      makeDraggable(document.querySelector(".container"));
    };

    function showInitialMessage() {
      document.querySelector(".diary-list").innerHTML = '<div class="placeholder">일지를 추가해보세요</div>';
      document.querySelector(".title-input").value = "아직 일지가 없음";
      document.querySelector(".input-field").value = "아직 일지가 없음";
      document.querySelector(".title-input").disabled = true;
      document.querySelector(".input-field").disabled = true;
    }

    function addDiaryEntry(title = "새 일지", content = "") {
      const diaryList = document.querySelector(".diary-list");
      const placeholder = diaryList.querySelector(".placeholder");
      if (placeholder) placeholder.remove();

      const newEntry = document.createElement("div");
      newEntry.className = "entry";
      const today = new Date().toISOString().split("T")[0].replace(/-/g, "/");

      const checkbox = document.createElement("input");
      checkbox.type = "checkbox";

      const titleSpan = document.createElement("span");
      titleSpan.className = "title";
      titleSpan.textContent = title;

      const dateSpan = document.createElement("span");
      dateSpan.className = "date";
      dateSpan.textContent = today;

      newEntry.appendChild(checkbox);
      newEntry.appendChild(titleSpan);
      newEntry.appendChild(dateSpan);

      newEntry.setAttribute("data-title", title);
      newEntry.setAttribute("data-content", content);
      newEntry.setAttribute("data-date", today);

      newEntry.onclick = function (e) {
        if (e.target.tagName.toLowerCase() === "input") return;
        selectDiary(this);
      };

      diaryList.appendChild(newEntry);

      const titleInput = document.querySelector(".title-input");
      const contentField = document.querySelector(".input-field");
      titleInput.disabled = false;
      contentField.disabled = false;
      titleInput.value = title;
      contentField.value = content;

      currentDiary = newEntry;

      titleInput.oninput = function () {
        newEntry.setAttribute("data-title", this.value);
        newEntry.querySelector(".title").textContent = this.value || "제목 없음";
      };
    }

    function selectDiary(entry) {
    	  currentDiary = entry;
    	  const titleInput = document.querySelector(".title-input");
    	  const contentField = document.querySelector(".input-field");

    	  titleInput.disabled = false;
    	  contentField.disabled = false;

    	  titleInput.value = entry.getAttribute("data-title");
    	  contentField.value = entry.getAttribute("data-content");

    	  titleInput.oninput = function () {
    	    currentDiary.setAttribute("data-title", this.value);
    	    currentDiary.querySelector(".title").textContent = this.value || "제목 없음";
    	  };

    	  contentField.oninput = function () {
    	    currentDiary.setAttribute("data-content", this.value);
    	  };
    	}
    
    function toggleSelectAll(source) {
    	  const checkboxes = document.querySelectorAll(".entry input[type='checkbox']");
    	  checkboxes.forEach(checkbox => {
    	    checkbox.checked = source.checked;
    	  });
    	}



    // ✅ 수정된 삭제 함수: 팝업 열기
   function deleteSelectedEntries() {
  const checkboxes = document.querySelectorAll(".entry input[type='checkbox']:checked");
  if (checkboxes.length === 0) {
    alert("삭제할 일지를 선택하세요.");
    return;
  }

  const firstEntry = checkboxes[0].closest(".entry");
  const title = firstEntry?.getAttribute("data-title")?.trim();

  const safeTitle = title && title.length > 0 ? `"${title}"` : "이 항목";

  document.getElementById("modalMessage").textContent = `${safeTitle}을(를) 삭제하시겠습니까?`;
  document.getElementById("deleteModal").style.display = "flex";
}


    function closeModal() {
      document.getElementById("deleteModal").style.display = "none";
    }

    function confirmDelete() {
      const diaryList = document.querySelector(".diary-list");
      const entries = diaryList.querySelectorAll(".entry");

      let anyDeleted = false;

      entries.forEach(entry => {
        const checkbox = entry.querySelector("input[type='checkbox']");
        if (checkbox && checkbox.checked) {
          if (currentDiary === entry) currentDiary = null;
          diaryList.removeChild(entry);
          anyDeleted = true;
        }
      });

      if (!diaryList.querySelector(".entry")) {
        showInitialMessage();
      }

      if (anyDeleted) {
        document.querySelector(".title-input").value = "";
        document.querySelector(".input-field").value = "";
        document.querySelector(".title-input").disabled = true;
        document.querySelector(".input-field").disabled = true;
        document.getElementById("select-all").checked = false;
      }

      closeModal();
    }

    function makeDraggable(elmnt) {
      let pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;

      elmnt.onmousedown = function (e) {
        if (["TEXTAREA", "INPUT", "BUTTON"].includes(e.target.tagName)) return;
        e.preventDefault();
        pos3 = e.clientX;
        pos4 = e.clientY;
        document.onmouseup = closeDragElement;
        document.onmousemove = elementDrag;
      };

      function elementDrag(e) {
        e.preventDefault();
        pos1 = pos3 - e.clientX;
        pos2 = pos4 - e.clientY;
        pos3 = e.clientX;
        pos4 = e.clientY;
        elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
        elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
      }

      function closeDragElement() {
        document.onmouseup = null;
        document.onmousemove = null;
      }
    }
    
    function toggleSelectAll(source) {
    	  const checkboxes = document.querySelectorAll(".entry input[type='checkbox']");
    	  checkboxes.forEach(checkbox => {
    	    checkbox.checked = source.checked;
    	  });
    	}
  </script>
</head>
<body>
  <div class="container">
<div class="sidebar">
  <div class="top-section">
    <!-- 일지 추가 버튼, 전체 선택 -->
    <button class="button" onclick="addDiaryEntry()">+ 일지 추가</button>
    <div style="margin-bottom: 10px;">
      <input type="checkbox" id="select-all" onclick="toggleSelectAll(this)"> 전체 선택
    </div>
    <div class="diary-list"></div> <!-- ✅ 스크롤되는 영역 -->
  </div>

  <button class="delete-button" onclick="deleteSelectedEntries()">삭제</button> <!-- ✅ 항상 하단 고정 -->
</div>
    <div class="content">
      <div class="header">
        <input class="title-input" placeholder="제목을 입력하세요" oninput="saveDiaryContent()" />
        <div class="icon-container">
        <img src="<%= request.getContextPath() %>/jspproject/img/setting.png" class="icon" />
          <img src="<%= request.getContextPath() %>/jspproject/img/delete.png" class="icon" />
        </div>
      </div>
      <textarea class="input-field" placeholder="내용을 입력하세요..." oninput="saveDiaryContent()"></textarea>
    </div>
  </div>

 <!-- ✅ 삭제 확인 모달 -->
<div id="deleteModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
  background: rgba(0, 0, 0, 0.6); justify-content: center; align-items: center; z-index: 1000;">

  <div style="background: #1d0934; border: 1px solid white; border-radius: 8px; width: 230px;
    padding: 20px; text-align: center; color: white; position: relative; font-family: Arial, sans-serif;">

    <!-- 닫기 이미지 버튼 -->
<img src="<%= request.getContextPath() %>/jspproject/img/transparent.png"
     onclick="closeModal()"
     style="position: absolute; top: 8px; right: 8px; width: 16px; height: 16px; cursor: pointer; filter: brightness(0) invert(1);" />


    <!-- 텍스트 -->
    <div id="modalMessage" style="font-size: 15px; margin-bottom: 20px;">삭제하시겠습니까?</div>

    <!-- 버튼들 -->
    <div style="display: flex; justify-content: space-around;">
      <button onclick="closeModal()" style="background: transparent; border: none; color: white; font-size: 14px; cursor: pointer;">취소</button>
      <button onclick="confirmDelete()" style="background: transparent; border: none; color: white; font-size: 14px; cursor: pointer;">삭제</button>
    </div>
  </div>
</div>
</body>
</html>
