<%-- getBgmIdByMplistId.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Vector" %>
<%@ page import="jspproject.MplistBgmView" %>
<%@ page import="jspproject.MplistMgrMgr" %>
<%@ page import="jspproject.BgmBean" %>
<%
String param = request.getParameter("bgm_id");
if (param == null) {
    out.print("<div style='color:white;'>잘못된 요청입니다.</div>");
    return;
}

int bgm_id = Integer.parseInt(param);
MplistMgrMgr mgr = new MplistMgrMgr();
MplistBgmView view = mgr.getViewByBgmId(bgm_id);
%>

<% if (view != null && view.getBgm() != null) {
     BgmBean b = view.getBgm();
%>
<div class="preview-icons2">
    <img class="iconMusicList2 delete-bgm" src="icon/아이콘_삭제_1.png" alt="삭제"
         data-mplistmgr-id="<%= view.getMplistmgr_id() %>">
</div>

<div class="music-preview3">
    <img class="musicImg2" src="img/<%= b.getBgm_image() != null ? b.getBgm_image() : "default.png" %>" alt="음악 이미지">
    <h2 class="editable-title"><%= b.getBgm_name() %></h2>
</div>

<div class="music-controls3">
    <span><img class="iconMusic2 prev-btn" src="icon/아이콘_이전음악_1.png" alt="이전 음악"></span>
    <span>
        <img id="playToggleBtn2"
	     class="iconMusic2"
	     src="icon/아이콘_재생_1.png"
	     data-state="paused"
	     data-bgm-id="<%= b.getBgm_id() %>"
	     data-bgm-name="<%= b.getBgm_name() %>"> <!-- ✅ 요거 추가 -->
	<audio id="playListAudioPlayer" src="music/<%= b.getBgm_music() %>"></audio>
    </span>
    <span><img class="iconMusic2 next-btn" src="icon/아이콘_다음음악_1.png" alt="다음 음악"></span>
</div>

<div class="music-description3">
    <textarea readonly><%= b.getBgm_cnt() %></textarea>
</div>

<div class="music-cancel-button3">
    <button class="btn-purple">음악 취소</button>
</div>

<script>
  setTimeout(() => {
    const playBtn = document.getElementById("playToggleBtn2");
    const audio = document.getElementById("playListAudioPlayer");
    const bgmId = playBtn ? parseInt(playBtn.dataset.bgmId) : null;

    if (!playBtn || !audio || !bgmId) return;

    playBtn.onclick = () => {
      const isPaused = playBtn.getAttribute("data-state") === "paused";
      const newOnoff = isPaused ? 1 : 0;

      fetch('<%= request.getContextPath() %>/jspproject/bgmOnOff', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ bgm_id: bgmId, bgm_onoff: newOnoff })
      });

      if (isPaused) {
        audio.play();
        playBtn.src = 'icon/playBtn.src = 'icon/아이콘_일시정지_1.png';
        playBtn.setAttribute('data-state', 'playing');
      } else {
        audio.pause();
        playBtn.src = 'icon/playBtn.src = 'icon/아이콘_재생_1.png';
        playBtn.setAttribute('data-state', 'paused');
      }
    };

    audio.onended = () => {
      fetch('<%= request.getContextPath() %>/jspproject/bgmOnOff', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ bgm_id: bgmId, bgm_onoff: 0 })
      }).then(() => {
        if (window.playNextMusicInPlaylist) window.playNextMusicInPlaylist();
      });
    };

    document.querySelector('.next-btn')?.addEventListener('click', () => {
      if (window.playNextMusicInPlaylist) window.playNextMusicInPlaylist();
    });

    document.querySelector('.prev-btn')?.addEventListener('click', () => {
      if (window.playPrevMusicInPlaylist) window.playPrevMusicInPlaylist();
    });
  }, 100);
</script>

<% } else { %>
  <div style='color:white;'>음악 정보를 보내오지 못했습니다.</div>
<% } %>
