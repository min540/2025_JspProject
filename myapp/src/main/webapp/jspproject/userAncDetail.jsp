<!-- userAncDetail.jsp -->
<%@page import="java.util.Vector"%>
<%@page import="jspproject.AncBean"%>
<%@page import="jspproject.AncMgr"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
	int anc_id = Integer.parseInt(request.getParameter("anc_id"));
	AncMgr amgr = new AncMgr();
	AncBean bean = amgr.getAnc(anc_id);
	AncBean pbean = amgr.beforeImg(anc_id);
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
header h3, header h4 {
	color: white;
	margin: 0 12px; /* 좌우 여백만 */
	margin-top: 25px;

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
	height: 1000px;
	background-color: #4A3C6E;
	margin: 0 auto;
	top: -140px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
	position: relative;
	z-index: 10;
	/* padding: 20px; */
}
.ntitle{
	margin-left: 20px;
	color: white;
	/* margin-bottom: 0px;*/
	margin-top: 5px; 
}
.container {
  display: flex;
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  align-items: stretch;
}
.container-box {
  	display: flex;
  	align-items: stretch;
  	min-height: 500px;
}
.ntitle{
	margin-left: 20px;
	color: white;
}
.left-section, .right-section {
 	width: 50%;
 	box-sizing: border-box;
}
.divider {
  position: absolute;
  top:70px;
  bottom:0px;
  left:400px;
  width: 1px;
  height: auto;
  background-color: #888;
  margin: 0 16px;
}
.box1 {
  	width: 130px;
  	height: 130px;
  	background-color: #372358;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 선택: 그림자 효과 */
  	margin-left: auto;
	margin-right: 45px;
	margin-top: 70px;
	color: white;
}
.rtext{
	color: white;
	margin-top: 5px;
	margin-left: 125;
	font-size: 10px; 
	font-weight: bold;
}
.rdtext{
	color: white;
	margin-top: 5px;
	margin-left: 130px;
	font-size: 12px;
}
.image-overlay-text {
  position: absolute;
  top: 0px;
  width: 130px;
  height: 130px;
  display: flex;
  color: black;
  font-weight: bold;
  font-size: 13px;
  text-align: center;
  padding: 10px;
  box-sizing: border-box;
  margin-left: auto;
  margin-right: 45px;
  margin-top: 70px;
  pointer-events: none;
}
.newtext{
  	margin-left: 125px;
  	color: white;
  	font-size: 10px;
  	 line-height: 2;
}
.new{
	margin-left: auto;
	margin-right: 110px;
	margin-top: 70px;
	color: white;
	font-weight: bold;
	 line-height: 2;
}
.newtext h4 {
	margin: 0;
  	padding: 0;
}
 a {
  color: white;           
  text-decoration: none;   
} 
a:hover {
  color: #32225B;        
  text-decoration: underline; /* 또는 none 유지 가능 */
}
</style>
<script>
</script>
</head> 
<body>
	<header>
	<h3>오늘, 내일</h3>
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
			<div class="left-section">	
				<h2 class="ntitle" style="font-size:30px;"><%=bean.getAnc_title() %></h2>
			<!-- 공지사항 내용 -->
			<% if (bean.getAnc_img() != null) { %>
				<img src="<%= request.getContextPath() %>/jspproject/upload/<%= bean.getAnc_img() %>" width="415" height="200">
			<% } %>
			<div class="ntitle"><%=bean.getAnc_cnt() %></div>
			</div>
			
			<div class="divider"></div>	
			
			<div class="right-section">
			<!-- 이전공지 업데이트-->
			<div class="box1">
			
			<% if (pbean.getAnc_img() != null) { %>
		
			<div class="image-overlay-text">
			
      			<%=pbean.getAnc_title()%>
    		</div>
			<a href="ancDetail.jsp?anc_id=<%= pbean.getAnc_id() %>">
			<img src="<%= request.getContextPath() %>/jspproject/upload/<%= pbean.getAnc_img() %>" width="130" height="130"></img>
			</a>
			
				<% }else{ %>
					<p>이전 공지가 없습니다.<p>
				<% } %>
			</div>
			<div style="margin-bottom: 70px;">
			<div class="rtext"">게시일시</div>
			<div class="rdtext"><%=bean.getAnc_regdate()%></div>
			</div>
			<div class="rtext">작성자</div>
			<div class="rdtext"><%=bean.getUser_id()%></div>
			
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