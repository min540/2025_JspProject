<%@page import="jspproject.JourBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jspproject.UserBean" %>
<jsp:useBean id="jmgr" class="jspproject.JourMgr"/>
<jsp:useBean id="lmgr" class="jspproject.LoginMgr"/>
<jsp:useBean id="bean" class = "jspproject.JourBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
String user_id = (String) session.getAttribute("id");  // ✅ 이제 문자열로 바로 받아도 안전함
if (user_id == null) {
    response.sendRedirect("login.jsp");
    return;
}
UserBean user = lmgr.getUser(user_id); 
Vector<JourBean> jour = jmgr.listJour(user_id);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>다이어리</title>
<<<<<<< HEAD
  <link href="css/diary.css?v=2" rel="stylesheet" type="text/css">
  <style>
    /* 스크롤바 스타일 */
    .input-field::-webkit-scrollbar { width: 8px; }
    .input-field::-webkit-scrollbar-track { background: transparent; }
    .input-field::-webkit-scrollbar-thumb { background-color: #663399; border-radius: 4px; }
    .input-field::-webkit-scrollbar-thumb:hover { background-color: #8A2BE2; }
=======
  <!-- 외부 CSS 연결 -->
<link href="css/diary.css" rel="stylesheet" type="text/css">
<style>
  .input-field::-webkit-scrollbar {
    width: 8px;
  }

  .input-field::-webkit-scrollbar-track {
    background: transparent;
  }

  .input-field::-webkit-scrollbar-thumb {
    background-color: #663399;
    border-radius: 4px;
  }

  .input-field::-webkit-scrollbar-thumb:hover {
    background-color: #8A2BE2;
  }
</style>

  <script>
    // 현재 선택된 일지와 편집 상태 추적
    let currentDiary = null;
    let isEditing = false;

    // 페이지 로드 시 초기 메시지와 드래그 기능 활성화
    window.onload = function () {
      showInitialMessage();
      makeDraggable(document.querySelector(".container"));
    };

    // 일지가 없을 때 기본 표시
    function showInitialMessage() {
      document.querySelector(".diary-list").innerHTML = '<div class="placeholder">일지를 추가해보세요</div>';
      document.querySelector(".title-input").value = "일지 없음";
      document.querySelector(".input-field").value = "일지 없음";
      document.querySelector(".title-input").disabled = true;
      document.querySelector(".input-field").disabled = true;
    }
    
    // 새로운 일지 항목 추가
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
        showContentPanel();
      };

      diaryList.appendChild(newEntry);
      selectDiary(newEntry);
      enableInitialEditMode();
    }

    // 최초 생성 시 편집 가능 상태
    function enableInitialEditMode() {
      document.querySelector(".title-input").disabled = false;
      document.querySelector(".input-field").disabled = false;
      isEditing = true;
      removeEditButton();
      removeCompleteButton();
      showCompleteButton();
    }

    // 완료 버튼 생성
    function showCompleteButton() {
      if (document.getElementById("complete-button")) return;
      const btn = document.createElement("button");
      btn.id = "complete-button";
      btn.textContent = "완료";
      btn.classList.add("edit-btn");
      btn.onclick = completeEntry;
      document.querySelector(".content").appendChild(btn);
    }

    // 완료 버튼 클릭 시 편집 종료
    function completeEntry() {
      if (!currentDiary) return;
      const titleInput = document.querySelector(".title-input");
      const contentField = document.querySelector(".input-field");
      currentDiary.setAttribute("data-title", titleInput.value);
      currentDiary.setAttribute("data-content", contentField.value);
      currentDiary.querySelector(".title").textContent = titleInput.value || "제목 없음";
      disableEditing();
      removeCompleteButton();
    }

    function removeCompleteButton() {
      const btn = document.getElementById("complete-button");
      if (btn) btn.remove();
    }

    // 일지 항목 선택
    function selectDiary(entry) {
      currentDiary = entry;
      document.querySelector(".title-input").value = entry.getAttribute("data-title");
      document.querySelector(".input-field").value = entry.getAttribute("data-content");
      disableEditing();
      removeEditButton();
      removeCompleteButton();
    }

    // 수정 아이콘 클릭 시 편집 모드 진입
    function enableEditMode() {
      if (!currentDiary) return;
      document.querySelector(".title-input").disabled = false;
      document.querySelector(".input-field").disabled = false;
      isEditing = true;
      showEditButton();
    }

    function disableEditing() {
      document.querySelector(".title-input").disabled = true;
      document.querySelector(".input-field").disabled = true;
      isEditing = false;
    }

    function showEditButton() {
      if (document.getElementById("edit-button")) return;
      const btn = document.createElement("button");
      btn.id = "edit-button";
      btn.textContent = "수정";
      btn.classList.add("edit-btn");
      btn.onclick = confirmEdit;
      document.querySelector(".content").appendChild(btn);
    }

    function removeEditButton() {
      const btn = document.getElementById("edit-button");
      if (btn) btn.remove();
    }

    // 수정 완료 버튼 클릭 시 내용 업데이트
    function confirmEdit() {
      if (!currentDiary || !isEditing) return;
      const newTitle = document.querySelector(".title-input").value;
      const newContent = document.querySelector(".input-field").value;
      currentDiary.setAttribute("data-title", newTitle);
      currentDiary.setAttribute("data-content", newContent);
      currentDiary.querySelector(".title").textContent = newTitle || "제목 없음";
      document.getElementById("editModalMessage").innerText = `${newTitle} 이(가) 수정되었습니다.`;
      document.getElementById("editModal").style.display = "flex";
      disableEditing();
      removeEditButton();
    }

    function closeEditModal() {
      document.getElementById("editModal").style.display = "none";
    }

    // 전체 선택 체크박스
    function toggleSelectAll(source) {
      const checkboxes = document.querySelectorAll(".entry input[type='checkbox']");
      checkboxes.forEach(checkbox => checkbox.checked = source.checked);
    }

    // 삭제 버튼 클릭 시 삭제 확인 모달 표시
function deleteSelectedEntries() {
  const checkboxes = document.querySelectorAll(".entry input[type='checkbox']:checked");

  // 아무 것도 선택 안 됐을 때
  if (checkboxes.length === 0) {
    document.getElementById("noSelectionModal").style.display = "flex";
    return;
  }

  // "전체 선택"이 체크되어 있고, 선택된 개수와 전체 개수가 같다면
  const selectAllChecked = document.getElementById("select-all").checked;
  const allEntries = document.querySelectorAll(".entry input[type='checkbox']");
  const isAllSelected = selectAllChecked && checkboxes.length === allEntries.length;

  const message = isAllSelected
    ? `전체 삭제하시겠습니까?`
    : (() => {
        const firstEntry = checkboxes[0].closest(".entry");
        const rawTitle = firstEntry?.getAttribute("data-title") || "";
        const title = rawTitle.trim();
        const safeTitle = title !== "" ? `"${title}"` : `"제목 없음"`;
        return `${safeTitle}을(를) 삭제하시겠습니까?`;
      })();

  document.getElementById("modalMessage").textContent = message;
  document.getElementById("deleteModal").style.display = "flex";
}

>>>>>>> branch 'main' of https://github.com/min540/2025_JspProject.git
    
    /* 모달 기본 스타일 */
    .modal {
      display: none;
      position: fixed;
      top: 0; left: 0; width: 100%; height: 100%;
      background: rgba(0, 0, 0, 0.6);
      justify-content: center;
      align-items: center;
      z-index: 1000;
    }
    .modal-content {
      background: #1d0934;
      border: 1px solid white;
      border-radius: 8px;
      width: 230px;
      padding: 20px;
      text-align: center;
      color: white;
      position: relative;
      font-family: Arial, sans-serif;
    }
    .modal-content img.modal-close {
      position: absolute;
      top: 8px;
      right: 8px;
      width: 16px;
      height: 16px;
      cursor: pointer;
      filter: brightness(0) invert(1);
    }
    .modal-actions {
      display: flex;
      justify-content: space-around;
      margin-top: 15px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="sidebar">
      <div class="top-section">
        <!-- 일지 추가 버튼 -->
        <button id="addDiaryBtn" class="button">+ 일지 추가</button>
        <div style="margin:10px 0;">
          <input type="checkbox" id="select-all">
          <label for="select-all">전체 선택</label>
        </div>
        <div class="diary-list">
<<<<<<< HEAD
          <!-- 항목이 없으면 플레이스홀더 표시 -->
          <div class="placeholder">일지를 추가해보세요</div>
=======
>>>>>>> branch 'main' of https://github.com/min540/2025_JspProject.git
        </div>
      </div>
      <button id="deleteDiaryBtn" class="delete-button">삭제</button>
    </div>
    <div class="content" id="contentPanel">
      <div class="header">
        <input class="title-input" placeholder="제목을 입력하세요" disabled />
        <div class="diary-icon-container">
<<<<<<< HEAD
          <img src="<%= request.getContextPath() %>/jspproject/img/setting.png" class="diary-icon" id="editDiaryIcon">
          <img src="<%= request.getContextPath() %>/jspproject/img/delete.png" class="diary-icon" id="hideContentIcon">
=======
          <img src="icon/아이콘_수정_1.png" class="diary-icon" onclick="enableEditMode()" />
          <img src="icon/아이콘_삭제_1.png" class="diary-icon" onclick="hideContentPanel()" />
>>>>>>> branch 'main' of https://github.com/min540/2025_JspProject.git
        </div>
      </div>
      <textarea class="input-field" placeholder="내용을 입력하세요..." disabled></textarea>
    </div>
  </div>

<<<<<<< HEAD
  <!-- 삭제 확인 모달 -->
  <div id="deleteModal" class="modal">
    <div class="modal-content">
      <img src="<%= request.getContextPath() %>/jspproject/img/transparent.png" class="modal-close" id="closeDeleteModal">
      <div id="modalMessage" style="font-size:15px;">삭제하시겠습니까?</div>
      <div class="modal-actions">
        <button id="cancelDeleteBtn" style="background: transparent; border: none; color: white; cursor: pointer;">취소</button>
        <button id="confirmDeleteBtn" style="background: transparent; border: none; color: white; cursor: pointer;">삭제</button>
      </div>
=======
 <!-- 삭제 확인 모달 -->
<div id="deleteModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); justify-content: center; align-items: center; z-index: 1000;">
  <div style="background: #1d0934; border: 1px solid white; border-radius: 8px; width: 230px; padding: 20px; text-align: center; color: white; position: relative; font-family: Arial, sans-serif;">
    <img src="/jspproject/img/transparent.png" onclick="closeModal()" style="position: absolute; top: 8px; right: 8px; width: 16px; height: 16px; cursor: pointer; filter: brightness(0) invert(1);" />
    <div id="modalMessage" style="font-size: 15px; margin-bottom: 20px;">삭제하시겠습니까?</div>
    <div style="display: flex; justify-content: space-around;">
      <button onclick="closeModal()" style="background: transparent; border: none; color: white; font-size: 14px; cursor: pointer;">취소</button>
      <button onclick="confirmDelete()" style="background: transparent; border: none; color: white; font-size: 14px; cursor: pointer;">삭제</button>
>>>>>>> branch 'main' of https://github.com/min540/2025_JspProject.git
    </div>
  </div>

  <!-- 수정 완료 모달 -->
<<<<<<< HEAD
  <div id="editModal" class="modal">
    <div class="modal-content">
      <img src="<%= request.getContextPath() %>/jspproject/img/transparent.png" class="modal-close" id="closeEditModal">
      <div id="editModalMessage" style="font-size:15px;">수정되었습니다.</div>
=======
  <div id="editModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); justify-content: center; align-items: center; z-index: 1000;">
    <div style="background: #1d0934; border: 1px solid white; border-radius: 8px; width: 230px; padding: 20px; text-align: center; color: white; position: relative; font-family: Arial, sans-serif;">
      <img src="<% %>/jspproject/img/transparent.png" onclick="closeEditModal()" style="position: absolute; top: 8px; right: 8px; width: 16px; height: 16px; cursor: pointer; filter: brightness(0) invert(1);" />
      <div id="editModalMessage" style="font-size: 15px;">수정되었습니다.</div>
>>>>>>> branch 'main' of https://github.com/min540/2025_JspProject.git
    </div>
  </div>

  <!-- 선택 없음 모달 -->
<<<<<<< HEAD
  <div id="noSelectionModal" class="modal">
    <div class="modal-content">
      <img src="<%= request.getContextPath() %>/jspproject/img/transparent.png" class="modal-close" id="closeNoSelectionModal">
      <div id="noSelectionMessage" style="font-size:15px;">삭제할 일지를 선택하세요.</div>
    </div>
=======
<div id="noSelectionModal" style="display: none; position: fixed; top: 0; left: 0;
  width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); 
  justify-content: center; align-items: center; z-index: 1000;">
  <div style="background: #1d0934; border: 1px solid white; border-radius: 8px;
    width: 230px; padding: 20px; text-align: center; color: white; position: relative; font-family: Arial, sans-serif;">
    <img src="<% %>/jspproject/img/transparent.png"
      onclick="closeNoSelectionModal()" 
      style="position: absolute; top: 8px; right: 8px; width: 16px; height: 16px; cursor: pointer; filter: brightness(0) invert(1);" />
    <div style="font-size: 15px;" id="noSelectionMessage">삭제할 일지를 선택하세요.</div>
>>>>>>> branch 'main' of https://github.com/min540/2025_JspProject.git
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', () => {
      class DiaryManager {
        constructor() {
          this.currentDiary = null;
          this.isEditing = false;
          this.init();
        }
        
        init() {
          this.showInitialMessage();
          this.attachEventListeners();
          this.makeDraggable(document.querySelector('.container'));
        }
        
        attachEventListeners() {
          // 버튼 및 아이콘 이벤트 등록
          document.getElementById('addDiaryBtn').addEventListener('click', () => this.addDiaryEntry());
          document.getElementById('deleteDiaryBtn').addEventListener('click', () => this.deleteSelectedEntries());
          document.getElementById('select-all').addEventListener('change', (e) => this.toggleSelectAll(e.target));
          document.getElementById('editDiaryIcon').addEventListener('click', () => this.enableEditMode());
          document.getElementById('hideContentIcon').addEventListener('click', () => this.hideContentPanel());
          
          // 모달 닫기 및 확인 이벤트 등록
          document.getElementById('closeDeleteModal').addEventListener('click', () => this.closeModal('deleteModal'));
          document.getElementById('cancelDeleteBtn').addEventListener('click', () => this.closeModal('deleteModal'));
          document.getElementById('confirmDeleteBtn').addEventListener('click', () => this.confirmDelete());
          
          document.getElementById('closeEditModal').addEventListener('click', () => this.closeEditModal());
          document.getElementById('closeNoSelectionModal').addEventListener('click', () => this.closeNoSelectionModal());
        }
        
        showInitialMessage() {
          const diaryList = document.querySelector('.diary-list');
          diaryList.innerHTML = '<div class="placeholder">일지를 추가해보세요</div>';
          const titleInput = document.querySelector('.title-input');
          const inputField = document.querySelector('.input-field');
          titleInput.value = '일지 없음';
          inputField.value = '일지 없음';
          titleInput.disabled = true;
          inputField.disabled = true;
        }
        
        addDiaryEntry(title = '새 일지', content = '') {
          const diaryList = document.querySelector('.diary-list');
          const placeholder = diaryList.querySelector('.placeholder');
          if (placeholder) placeholder.remove();
      
          const entry = document.createElement('div');
          entry.className = 'entry';
          const today = new Date().toISOString().split('T')[0];
      
          const checkbox = document.createElement('input');
          checkbox.type = 'checkbox';
      
          const titleSpan = document.createElement('span');
          titleSpan.className = 'title';
          titleSpan.textContent = title;
      
          const dateSpan = document.createElement('span');
          dateSpan.className = 'date';
          dateSpan.textContent = today;
      
          entry.appendChild(checkbox);
          entry.appendChild(titleSpan);
          entry.appendChild(dateSpan);
      
          entry.setAttribute('data-title', title);
          entry.setAttribute('data-content', content);
          entry.setAttribute('data-date', today);
      
          entry.addEventListener('click', (e) => {
            // 체크박스 클릭 시 이벤트 전파 방지
            if (e.target.tagName.toLowerCase() === 'input') return;
            this.selectDiary(entry);
            this.showContentPanel();
          });
      
          diaryList.appendChild(entry);
          this.selectDiary(entry);
          this.enableInitialEditMode();
        }
        
        enableInitialEditMode() {
          const titleInput = document.querySelector('.title-input');
          const inputField = document.querySelector('.input-field');
          titleInput.disabled = false;
          inputField.disabled = false;
          this.isEditing = true;
          this.showCompleteButton();
        }
        
        showCompleteButton() {
          if (document.getElementById('complete-button')) return;
          const btn = document.createElement('button');
          btn.id = 'complete-button';
          btn.textContent = '완료';
          btn.classList.add('edit-btn');
          btn.addEventListener('click', () => this.completeEntry());
          document.querySelector('.content').appendChild(btn);
        }
        
        completeEntry() {
          if (!this.currentDiary) return;
          const titleInput = document.querySelector('.title-input');
          const inputField = document.querySelector('.input-field');
          this.currentDiary.setAttribute('data-title', titleInput.value);
          this.currentDiary.setAttribute('data-content', inputField.value);
          this.currentDiary.querySelector('.title').textContent = titleInput.value || '제목 없음';
          this.disableEditing();
          this.removeCompleteButton();
        }
        
        removeCompleteButton() {
          const btn = document.getElementById('complete-button');
          if (btn) btn.remove();
        }
        
        selectDiary(entry) {
          this.currentDiary = entry;
          const titleInput = document.querySelector('.title-input');
          const inputField = document.querySelector('.input-field');
          titleInput.value = entry.getAttribute('data-title');
          inputField.value = entry.getAttribute('data-content');
          this.disableEditing();
          this.removeCompleteButton();
        }
        
        enableEditMode() {
          if (!this.currentDiary) return;
          if (document.getElementById('complete-button')) {
            this.removeCompleteButton();
          }
          document.querySelector('.title-input').disabled = false;
          document.querySelector('.input-field').disabled = false;
          this.isEditing = true;
          this.showEditButton();
        }
        
        showEditButton() {
          if (document.getElementById('edit-button')) return;
          const btn = document.createElement('button');
          btn.id = 'edit-button';
          btn.textContent = '수정';
          btn.classList.add('edit-btn');
          btn.addEventListener('click', () => this.confirmEdit());
          document.querySelector('.content').appendChild(btn);
        }
        
        removeEditButton() {
          const btn = document.getElementById('edit-button');
          if (btn) btn.remove();
        }
        
        confirmEdit() {
          if (!this.currentDiary || !this.isEditing) return;
          const titleInput = document.querySelector('.title-input');
          const inputField = document.querySelector('.input-field');
          const newTitle = titleInput.value;
          const newContent = inputField.value;
          this.currentDiary.setAttribute('data-title', newTitle);
          this.currentDiary.setAttribute('data-content', newContent);
          this.currentDiary.querySelector('.title').textContent = newTitle || '제목 없음';
          document.getElementById('editModalMessage').innerText = `일지가 수정되었습니다.`;
          document.getElementById('editModal').style.display = 'flex';
          this.disableEditing();
          this.removeEditButton();
        }
        
        disableEditing() {
          document.querySelector('.title-input').disabled = true;
          document.querySelector('.input-field').disabled = true;
          this.isEditing = false;
        }
        
        toggleSelectAll(source) {
          const checkboxes = document.querySelectorAll('.entry input[type="checkbox"]');
          checkboxes.forEach(cb => cb.checked = source.checked);
        }
        
        deleteSelectedEntries() {
          const checkboxes = document.querySelectorAll('.entry input[type="checkbox"]:checked');
          if (checkboxes.length === 0) {
            document.getElementById('noSelectionModal').style.display = 'flex';
            return;
          }
      
          const selectAllChecked = document.getElementById('select-all').checked;
          const allEntries = document.querySelectorAll('.entry input[type="checkbox"]');
          const isAllSelected = selectAllChecked && checkboxes.length === allEntries.length;
      
          let message = isAllSelected
            ? '전체 삭제하시겠습니까?'
            : (() => {
                const firstEntry = checkboxes[0].closest('.entry');
                const rawTitle = firstEntry?.getAttribute('data-title') || '';
                const title = rawTitle.trim();
                return title !== '' ? `"${title}"을(를) 삭제하시겠습니까?` : `"제목 없음"을(를) 삭제하시겠습니까?`;
              })();
      
          document.getElementById('modalMessage').textContent = message;
          document.getElementById('deleteModal').style.display = 'flex';
        }
        
        confirmDelete() {
          const diaryList = document.querySelector('.diary-list');
          const entries = diaryList.querySelectorAll('.entry');
          let anyDeleted = false;
      
          entries.forEach(entry => {
            const checkbox = entry.querySelector('input[type="checkbox"]');
            if (checkbox && checkbox.checked) {
              if (this.currentDiary === entry) this.currentDiary = null;
              diaryList.removeChild(entry);
              anyDeleted = true;
            }
          });
      
          if (!diaryList.querySelector('.entry')) this.showInitialMessage();
      
          if (anyDeleted) {
            const titleInput = document.querySelector('.title-input');
            const inputField = document.querySelector('.input-field');
            titleInput.value = '';
            inputField.value = '';
            titleInput.disabled = true;
            inputField.disabled = true;
            document.getElementById('select-all').checked = false;
          }
          this.closeModal('deleteModal');
        }
        
        closeModal(modalId) {
          document.getElementById(modalId).style.display = 'none';
        }
        
        closeEditModal() {
          this.closeModal('editModal');
        }
        
        closeNoSelectionModal() {
          this.closeModal('noSelectionModal');
        }
        
        hideContentPanel() {
          document.getElementById('contentPanel').style.display = 'none';
        }
        
        showContentPanel() {
          document.getElementById('contentPanel').style.display = 'flex';
        }
        
        makeDraggable(elmnt) {
          let pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
          elmnt.onmousedown = (e) => {
            if (['TEXTAREA','INPUT','BUTTON'].includes(e.target.tagName)) return;
            e.preventDefault();
            pos3 = e.clientX;
            pos4 = e.clientY;
            document.onmouseup = closeDragElement;
            document.onmousemove = elementDrag;
          };
          const elementDrag = (e) => {
            e.preventDefault();
            pos1 = pos3 - e.clientX;
            pos2 = pos4 - e.clientY;
            pos3 = e.clientX;
            pos4 = e.clientY;
            elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
            elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
          };
          const closeDragElement = () => {
            document.onmouseup = null;
            document.onmousemove = null;
          };
        }
      }
      
      const diaryManager = new DiaryManager();
    });
  </script>
</body>
</html>
