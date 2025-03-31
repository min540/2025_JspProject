<!-- list.jsp -->
<%@page import="ch15.BCommentBean"%>
<%@page import="ch15.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@page import="ch15.MUtil"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class = "ch15.BoardMgr"/>
<jsp:useBean id="cmgr" class = "ch15.BCommentMgr"/>
<%
		int totalRecord = 0; // 총 게시물 수
		int numPerPage = 10; // 페이지 당 레코드 개수 (5, 10, 20, 30)
		int pagePerBlock = 15; // 한 블럭당 페이지 개수
		int totalPage =0;
		int totalBlock = 0;
		int nowPage = 1;
		int nowBlock = 1;
		
		// numPerPage
		if(request.getParameter("numPerPage")!=null){
			numPerPage = MUtil.parseInt(request, "numPerPage");
		}
		
		
		//검색에 필요한 처피
		String keyField = "", keyWord = "";
		if(request.getParameter("keyWord") != null){
		    keyField = request.getParameter("keyField");
		    keyWord = request.getParameter("keyWord"); 
		}
		
		totalRecord = mgr.getTotalCount(keyField, keyWord);
		// out.print(totalRecord);
		
		// 현재 페이지
		if(request.getParameter("nowPage")!=null){
			nowPage = MUtil.parseInt(request, "nowPage");
		}
		
		int start = (nowPage*numPerPage)-numPerPage;
		int cnt = numPerPage; // (5, 10, 20, 30)
		
		totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
		totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
		nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
		
%>

<!DOCTYPE html>
<html>
<head>
	<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function pageing(page){
		document.readFrm.action = "list.jsp";
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	
	function block(block){
		// 블럭을 요청 할 때 넘어가는 값은 nowPave. 이유는 page값을 block 계산	
		document.readFrm.action = "list.jsp";
		document.readFrm.nowPage.value = <%=pagePerBlock%>*(block-1)+1;
		document.readFrm.submit();
	}
	
	function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
	
	function numPerFn(numPerPage){
		// alert(numPerPage);
		document.readFrm.action = "list.jsp";
		document.readFrm.numPerPage.value = numPerPage;
		document.readFrm.submit();
	}
	
	function read(num){
		document.readFrm.num.value = num;
		document.readFrm.action = "read.jsp";
		document.readFrm.submit();
	}
	
</script>
</head>
<body bgcolor="#FFFFCC" >
<div align="center"><br/>
<h2>JSP Board</h2><br/>
<table>
	<tr>
		<td width="600">
		Total : <%=totalRecord%>Article(<font color="red">
		<%=nowPage+"/"+totalPage %>Pages</font>)
		</td>
		<td align="right">
			<form name="npFrm" method="post">
				<select name="numPerPage" size="1" 
				onchange = "javascript:numPerFn(this.form.numPerPage.value)">
    				<option value="5">5개 보기</option>
    				<option value="10" selected>10개 보기</option>
    				<option value="15">15개 보기</option>
    				<option value="30">30개 보기</option>
   				</select>
   				<script type = "text/javascript">
   					document.npFrm.numPerPage.value = <%=numPerPage%>;
   				</script>
   			</form>
		</td>
	</tr>
</table>
<table>
 <tr>
 	<td align="center" colspan="2">
		<%
				Vector<BoardBean>vlist = mgr.getBoardList(keyField, keyWord, start, cnt);
				int listSize = vlist.size();
				if(vlist.isEmpty()){
					out.println("등록된 게시글이 없습니다");
				} else{
		%>
		<table cellspacing="0">
				<tr align="center" bgcolor="#D0D0D0">
					<td width="100">번 호</td>
					<td width="250">제 목</td>
					<td width="100">이 름</td>
					<td width="150">날 짜</td>
					<td width="100">조회수</td>
				</tr>
				<%
						for(int i = 0; i < numPerPage; i++){
							if(i == listSize) break; // 제일 마지막 페이지 사용
							BoardBean bean = vlist.get(i);
							int num = bean.getNum();
							String subject = bean.getSubject();
							String name = bean.getName();
							String regdate = bean.getRegdate();
							int depth = bean.getDepth(); // 답변의 길이, 원글은 0
							int count = bean.getCount();
							String filename = bean.getFilename();
							// 댓글 count							
							int bcount = cmgr.getBCommentCount(num);
				%>
				<tr align = "center">
					<td><%=totalRecord-start-i %></td>
					<td align = "left">
						<% for(int j = 0; j < depth; j++) { out.print("&nbsp; &nbsp;");}%>
						<a href="javascript:read('<%=num%>')"><%=subject %></a>
						<% if(filename != null && !filename.equals("")) {%>
							<img alt = "첨부파일" src = "img/icon.gif" align = "middle">
						<% } // --if문 %>
						<% if(bcount > 0) { %>
							<font color = "red">(<%=bcount %>)</font>
						<% } // if문  %>
					</td>
					<td><%=name%></td>
					<td><%=regdate%></td>
					<td><%=count%></td>
				</tr>
				
				<% } // -- for %>
			</table>
		<%} // -- if문%>
 	</td>
 </tr>
 <tr>
 	<td colspan="2"><br><br></td>
 </tr>
 <tr>
 	<td>
		<!-- 이전 블럭 -->
		<% if(nowBlock > 1){ %>
			<a href = "javascript:block('<%=nowBlock-1 %>')" >prev...</a>
		<%} %>
		<!-- 페이징 블럭 -->
		<%
				int pageStart = (nowBlock -1) * pagePerBlock +1;
				int pageEnd = (pageStart + pagePerBlock)<totalPage?
						pageStart + pagePerBlock:totalPage+1;
				for(;pageStart<pageEnd; pageStart++){
		%>
		<a href= "javascript:pageing('<%=pageStart%>')">
		<%if(nowPage == pageStart){ %><font color = "blue"><b><%} %>
		[<%=pageStart %>]
		<%if(nowPage == pageStart){ %></b></font><%}%>
		</a>
		<% } // --for %>
		<!-- 다음 블럭 -->
		<% if(totalBlock > nowBlock){ %>
			<a href = "javascript:block('<%=nowBlock+1 %>')" >...next</a>
		<%} %>
			
 	</td>
 	<td align="right">
 		<a href="post.jsp">[글쓰기]</a>
 		<a href="list.jsp">[처음으로]</a>
 	</td>
 </tr>
</table>
<hr width="750">
<!-- 검색 form -->
<form name="searchFrm">
	<table  width="600" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
   				<select name="keyField" size="1" >
    				<option value="name"> 이 름</option>
    				<option value="subject"> 제 목</option>
    				<option value="content"> 내 용</option>
   				</select>
   				<input size="16" name="keyWord">
   				<input type="button"  value="찾기" onClick="javascript:check()">
   				<input type="hidden" name="nowPage" value="1">
   				<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
  			</td>
 		</tr>
	</table>
</form>
<form name="listFrm" method="post">
	<input type="hidden" name="reload" value="true">
	<input type="hidden" name="nowPage" value="1">
</form>

<form name="readFrm">
	<input type="hidden" name="num">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
</form>
</div>
</body>
</html>
