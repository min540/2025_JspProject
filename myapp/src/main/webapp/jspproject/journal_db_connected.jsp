
<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="jmgr" class="jspproject.JourMgr"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>다이어리</title>
  <link href="css/diary.css?v=2" rel="stylesheet" type="text/css">
</head>
<body>
  <div class="container">
    <div class="sidebar">
      <div class="top-section">
        <button id="addDiaryBtn" class="button">+ 일지 추가</button>
        <div id="select-all-container">
          <input type="checkbox" id="select-all">
          <label for="select-all">전체 선택</label>
        </div>
        <div class="diary-list">
          <div class="placeholder">일지를 추가해보세요</div>
        </div>
      </div>
      <button id="deleteDiaryBtn" class="delete-button">삭제</button>
    </div>
    <div class="content" id="contentPanel">
      <div class="header">
        <input class="title-input" placeholder="제목을 입력하세요" disabled />
        <div class="diary-icon-container">
          <img src="<%= request.getContextPath() %>/jspproject/img/setting.png" class="diary-icon" id="editDiaryIcon">
          <img src="<%= request.getContextPath() %>/jspproject/img/delete.png" class="diary-icon" id="hideContentIcon">
        </div>
      </div>
      <textarea class="input-field" placeholder="내용을 입력하세요..." disabled></textarea>
    </div>
  </div>

  <!-- 모달 생략 (위에서 제공된 모달들 그대로 유지) -->

  <script>
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
        this.loadDiaryEntries();
      }

      async loadDiaryEntries() {
        const response = await fetch('getJourList.jsp');
        const list = await response.json();
        list.forEach(d => this.addDiaryEntry(d.jour_title, d.jour_cnt, d.jour_id));
      }

      addDiaryEntry(title = '새 일지', content = '', jour_id = null) {
        const diaryList = document.querySelector('.diary-list');
        const placeholder = diaryList.querySelector('.placeholder');
        if (placeholder) placeholder.remove();

        const entry = document.createElement('div');
        entry.className = 'entry';
        entry.setAttribute('data-id', jour_id);

        const checkbox = document.createElement('input');
        checkbox.type = 'checkbox';

        const titleSpan = document.createElement('span');
        titleSpan.className = 'title';
        titleSpan.textContent = title;

        const dateSpan = document.createElement('span');
        dateSpan.className = 'date';
        dateSpan.textContent = new Date().toISOString().split('T')[0];

        entry.appendChild(checkbox);
        entry.appendChild(titleSpan);
        entry.appendChild(dateSpan);

        entry.setAttribute('data-title', title);
        entry.setAttribute('data-content', content);
        entry.addEventListener('click', (e) => {
          if (e.target.tagName.toLowerCase() === 'input') return;
          this.selectDiary(entry);
          this.showContentPanel();
        });

        diaryList.appendChild(entry);
        this.selectDiary(entry);
        this.enableInitialEditMode();
      }

      async completeEntry() {
        const title = document.querySelector('.title-input').value;
        const content = document.querySelector('.input-field').value;

        const response = await fetch('jourAdd', {
          method: 'POST',
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          body: `jour_title=${encodeURIComponent(title)}&jour_cnt=${encodeURIComponent(content)}`
        });

        const data = await response.json();
        this.currentDiary.setAttribute('data-id', data.jour_id);
      }

      async confirmEdit() {
        const title = document.querySelector('.title-input').value;
        const content = document.querySelector('.input-field').value;
        const id = this.currentDiary.getAttribute('data-id');

        await fetch('jourUpdate', {
          method: 'POST',
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          body: `jour_id=${id}&jour_title=${encodeURIComponent(title)}&jour_cnt=${encodeURIComponent(content)}`
        });

        document.getElementById('editModal').style.display = 'flex';
        this.disableEditing();
        this.removeEditButton();
      }

      async confirmDelete() {
        const entries = document.querySelectorAll('.entry input[type="checkbox"]:checked');

        for (const cb of entries) {
          const entry = cb.closest('.entry');
          const id = entry.getAttribute('data-id');

          await fetch('jourDelete', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `rnum=${id}`
          });

          entry.remove();
        }

        if (!document.querySelector('.entry')) this.showInitialMessage();
        this.closeModal('deleteModal');
      }

      // 나머지 메서드 생략...
    }

    const diaryManager = new DiaryManager();
  </script>
</body>
</html>
