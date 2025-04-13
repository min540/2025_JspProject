<!-- anc.jsp -->
<%@page import="jspproject.AncBean"%>
<%@page import="java.util.Vector"%>
<%@page import="jspproject.AncMgr"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
/* 	int anc_id = Integer.parseInt(request.getParameter("anc_id")); */
		

	AncMgr amgr = new AncMgr();
	Vector<AncBean> vlist = amgr.listAnc();
	AncBean recent = amgr.viewAnc();

/* 	AncBean pbean = amgr.beforeImg(anc_id); */
%>
<html>
<head>
<title>오늘, 내일</title>
<style>
body, html {
  	margin: 0;
    padding: 0;
    height: 100%;
    background-color:#372358;
}
header{
	display: flex;
	justify-content: center;
    align-items: center; 
  	margin-bottom: 20px;
  	padding-right: 370px; 
}
header h3 {
	color: white;
	margin: 0 12px; /* 좌우 여백만 */
	margin-top: 25px;
	font-family: 'PFStarDust', sans-serif;
	font-size: 25px;
}
header h4 {
	color: white;
	margin: 0 12px; /* 좌우 여백만 */
	margin-top: 25px;
	font-family: 'PFStarDust', sans-serif;
	font-size: 18px;
}
.image-wrapper {
  position: relative;
  width: auto;
  margin: 0 auto;
}
.main-image {
  width: 100%;
  height: 400px;
  object-fit: cover;
  display: block;
}
.blur-left, .blur-right {
  position: absolute;
  top: 0;
  width: 80px;
  height: 100%;
  z-index: 2;
  pointer-events: none;
}
.blur-left {
  left: 0;
  background: linear-gradient(to right, rgba(55, 35, 88, 1), transparent);
}
.blur-right {
  right: 0;
  background: linear-gradient(to left, rgba(55, 35, 88, 1), transparent);
}
.inner-effect {
  box-shadow: inset 0 0 80px rgba(0, 0, 0, 0.5);
  position: absolute;
  top: 0; left: 0;
  width: 100%;
  height: 100%;
  z-index: 2;
  pointer-events: none;
}
.box{
	width: 600px;
    height: auto;
    margin: 0 auto;
    top: -140px;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
    position: relative;
    z-index: 10;
}
.ntitle{
	margin-left: 20px;
	color: white;
	margin-top:20px;
	
	
	}
.container {
  display: flex;
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  align-items: stretch;
}

.box2{
 	width: 415px;
    height: auto;
    background-color: #5C4B85;
    margin-bottom: 20px;
    padding: 0 0 10px 0;
    white-space: pre-line;
  	font-size: 14px;
}

.box2 * {
  color: white !important;
}

.box3 {
  width: 415px;
  height: auto; /* 고정 높이 대신 자동 조정 */
  min-height: 200px; /* 최소 높이 설정 */
  background-color: #5C4B85;
  margin-bottom: 20px;
  position: relative; /* 내부 요소 배치를 위한 기준점 */
  padding-bottom: 50px; /* 하단 여백 추가 */
}

@font-face {
    font-family: 'PFStarDust';
    src: url('fonts/PFStarDust-Bold.ttf') format('truetype');
    font-weight: bold;
    font-style: normal;
}

input[type="checkbox"] {
  appearance: none;      
  width: 15px;
  height: 15px;
  border: 2px solid #ffffff;  
  border-radius: 4px;        
  background-color: white;   
  cursor: pointer;
  position: relative;
}
input[type="checkbox"]:checked {
  background-color: #5C4B85;  
  border: 0.8px solid #ffffff;  
}
input[type="checkbox"]:checked::after {
  content: "✔";
  position: absolute;
  left:3px;
  top:0px;
  font-size: 10px;
  color: white;
}
.dbtn{
	width: 70px;
    height: 30px;
    border-radius: 10px;
    margin-left: 140px;
    font-size: 16px;
    border: 0.8px solid #ffffff;
    background-color: #32225B;
    color: white;
    font-family: 'PFStarDust', sans-serif;
}
.new{
	margin-left: auto;
    margin-right: 80px;
    color: white;
    font-weight: bold;
    line-height: 2;
    font-size: 18px;
}
.container-box {
  	display: flex;
  	position: relative;
  	
}
.left-section {
 	width: 75%;
 	box-sizing: border-box;
 	background-color: #5C4B85;
 	padding: 10px;
}

.right-section {
	width: 200px;
	background-color: #3f235a;
}
.newtext{
  	margin-left: 0px;
  	color: white;
  	font-size: 10px;
  	 line-height: 2;
  	
}
.newtext h4 {
	margin: 0;
    padding: 0;
    margin-left: 10px;
    font-size: 14px;
}

.newtext h4 a:hover {
  color: white;              /* 마우스를 올린 상태에서도 계속 흰색 유지 */
  text-decoration: underline;    /* 마우스를 올렸을 때 밑줄 제거 */
}

 ul {
  list-style: none;
  padding: 0;
  margin: 0;
  background-color: var(--back_02);
  width: 30px;
  height: 30px;
  text-align: center;
  border-radius: 3px;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 18px;
  font-weight: bold;
  margin-right: 8px;
  cursor: pointer;
}
.pagination-wrapper {
  display: flex;
  justify-content: center;
  width: 100%;
  position: absolute; /* 절대 위치 설정 */
  left: 0;
}
.pagination-wrapper ul {
  justify-content: center;
    list-style: none;
    padding: 0;
    margin: 0;
    margin-left: 180px;
}
.pagination-wrapper li {
  width: 30px;
    height: 30px;
    text-align: center;
    border-radius: 3px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 18px;
    font-weight: bold;
    color: white;
    margin-right: 7px;
    cursor: pointer;
}

 a {
  color: white;           
  text-decoration: none; 
} 
a:hover {
  color: #32225B;        
  text-decoration: underline; /* 또는 none 유지 가능 */
}

ul, ol {
  margin: 0;
  padding: 0;
  list-style-position: inside;
}

ol {
  /* list-style-position: inside; 로 하면 숫자 앞 공백이 줄어듭니다. */
  list-style-position: inside; 
  /* 혹은 필요에 따라 padding-left 값을 직접 0 또는 적게 조정하기 */
  padding-left: 0;
  margin-left: 0;
}

</style>
<script>
function allChk() {
	  const all = document.querySelector('input[name="allCh"]');
	  const items = document.querySelectorAll('input[name="ancIds"]');
	  items.forEach(i => i.checked = all.checked);
	}
function confirmDelete() {
	const checked = document.querySelectorAll('input[name="ancIds"]:checked');
	if(checked.length===0){
		alert("삭제할 항목을 선택하세요.");
		return false;
	}
	return confirm("정말 삭제하시겠습니까?");
}
document.addEventListener('DOMContentLoaded', function(){
	 const ancElements = document.querySelectorAll('.box2 *');
	 ancElements.forEach(el => {
	   el.removeAttribute('style');
	 });
});
</script>
</head> 
<body>
	<header>
	<h3>오늘, 내일</h3>
	<a href="anc.jsp"><h4>공지사항</h4></a>
	<a href="ancPost.jsp"><h4>글쓰기</h4></a>
	</header>
<div class="image-wrapper">
  <img src="http://localhost/2025_JspProject/jspproject/images/loginimg.jpg" class="main-image" />
  <div class="blur-left"></div>
  <div class="blur-right"></div>
  <div class="inner-effect"></div>
</div>
<div class="container">
	<div class="box">	
	
	<div class="container-box">
		<!-- 왼쪽 -->
		<div class="left-section">
		<% if (recent.getAnc_title() != null) { %>
			<h2 class="ntitle"><%=recent.getAnc_title()%></h2>
			<% }else{ %>
			<h2 class="ntitle">최신 공지가 없습니다.</h2>
			<% } %>
			<div class="box2" style="color: white;">
			<% if (recent.getAnc_img() != null) { %>
				<img src="<%= request.getContextPath() %>/jspproject/upload/<%= recent.getAnc_img() %>" width="415" height="200">
			<% } %>
			<br>
			<% if (recent.getAnc_cnt() != null) { %>
			<%= recent.getAnc_cnt().trim() %>
			<% }else{ %>
			<h3>최신 공지가 없습니다.</h3>
			<% } %>
			</div>
			<h2 class="ntitle">공지사항 목록</h2>
			<form action="ancDeleteProc.jsp" method="post" onsubmit="return confirmDelete();">
			<div class="box3">
			<table  cellspacing="0" style="color: white;">
				<tr align="center" bgcolor="#32225B" >
					<td><input type="checkbox" name="allCh" onclick="allChk()"></td>
					<td width="100">번호</td>
					<td width="250">제 목</td>
					<td width="100">작성자</td>
					<td width="150">작성날짜</td>
				</tr>
				
				<%
				String pageStr = request.getParameter("page");
                int currentPage = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
                int perPage= 5;
				Vector<AncBean> slist = amgr.listPageAnc(currentPage, perPage);
				
				for(int i=0; i<slist.size();i++){
					AncBean bean = slist.get(i);
				%>
				<!-- db에서 받아올 내용 -->
				<tr align="center" style="font-size: 10px;">
					<td><input type="checkbox" name="ancIds" value="<%=bean.getAnc_id()%>"></td>
					<td><%=bean.getAnc_id()%></td>
					<td>
					<a href="ancDetail.jsp?anc_id=<%=bean.getAnc_id()%>" style="color:white;"><%=bean.getAnc_title() %></a>
					</td>
					<td><%=bean.getUser_id() %></td>
					<td><%=bean.getAnc_regdate() %></td>
				</tr>
				<%} %>
			</table>
			<!-- 동적 페이징 처리 시작-->
                       <%

                        int pageBlock = 5;
						int totalRecord = amgr.getTotalCount();
                        int totalPage = (int)Math.ceil((double)totalRecord / perPage);
                        int nowBlock = (int)Math.ceil((double)currentPage / pageBlock);
                        int pageStart = (nowBlock - 1) * pageBlock + 1;
                        int pageEnd = pageStart + pageBlock - 1;
                        if(pageEnd > totalPage) {
                            pageEnd = totalPage;
                        }
                    %>
                      <div class="pagination-wrapper" style="text-align:center; margin-top: 10px;">
                    <ul>
                        <% if(currentPage > 1) { %>
                        <li>
                            <a href="anc.jsp?page=<%= currentPage - 1 %>">◀</a>
                        </li>
                        <% } else { %>
                        <li >◀</li>
                        <% } %>
                        <% for(int j = pageStart; j <= pageEnd; j++) {
                               if(j == currentPage) { %>
                        <li >
                            <span><%= j %></span>
                        </li>
                        <% } else { %>
                        <li >
                            <a href="anc.jsp?page=<%= j %>"><%= j %></a>
                        </li>
                        <%     }
                           } %>
                        <% if(currentPage < totalPage) { %>
                        <li >
                            <a href="anc.jsp?page=<%= currentPage + 1 %>">▶</a>
                        </li>
                        <% } else { %>
                        <li>▶</li>
                        <% } %>
						</ul>
						<div>
							<button type="submit" class="dbtn" style="z-index:9999; position:relative; pointer-events:auto;" onclick="return confirmDelete();">삭제</button>
						</div>
						</div>
			<!-- 동적 페이징 처리 끝-->
			</div>
			</form>
		</div>
		
	
			 <div class="divider"></div>	
			 <div class="right-section">
				<div style="display: flex; flex-direction: column; align-items: flex-start;">
					<div class=" ntitle new ">주요 공지</div><!-- 특정공지 선택 컬럼을 만들어서 특정공지만띄 우게하기 if if (recent.get주요공지컬럼() == 1 or 스트링값이라면) {-->
				<%
    				Vector<AncBean> hlist = amgr.getHighlightAncList();
    				if (hlist != null && hlist.size() > 0) {
        				for (int i = 0; i < hlist.size(); i++) {
            					AncBean hbean = hlist.get(i);
				%>
            		<div class="newtext">
                		<h4><a href="ancDetail.jsp?anc_id=<%=hbean.getAnc_id()%>"><%=hbean.getAnc_title()%></a></h4>
            		</div>
				<% }
        		} else {%>
					<div class="newtext">하이라이트 공지가 없습니다.</div>
				<%}%>
				</div>
			 </div>
			 </div>
		</div>
	</div>
</body>
</html>