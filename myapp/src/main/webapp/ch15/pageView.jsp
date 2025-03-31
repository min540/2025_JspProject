<!-- pageView.jsp -->
<%@page import="ch15.MUtil"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		int totalRecord = MUtil.parseInt(request, "totalRecord"); // 총 게시물 수
		int numPerPage = 10; // 페이지 당 레코드 개수 (5, 10, 20, 30)
		int pagePerBlock = 15; // 한 블럭당 페이지 개수
		int totalPage =0;
		int totalBlock = 0;
		int nowPage = 1;
		int nowBlock = 1;
		
		// 현재 페이지
		if(request.getParameter("nowPage")!=null){
			nowPage = MUtil.parseInt(request, "nowPage");
		}
		
		int start = (nowPage*numPerPage)-numPerPage;
		
		totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
		totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
		nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
		
%>

<!DOCTYPE html>
<html>
<head>
	<title>페이징 & 블럭 처리 테스트</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function pageing(page){
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	
	function block(block){
		// 블럭을 요청 할 때 넘어가는 값은 nowPave. 이유는 page값을 block 계산	
		document.readFrm.nowPage.value = <%=pagePerBlock%>*(block-1)+1;
		document.readFrm.submit();
	}
	
</script>
<body bgcolor="#FFFFCC">
<div align="center"><br/>
<h2>페이징 & 블럭 처리 테스트</h2>
<table>
	<tr>
		<td  width="700" align="center">
		Total : <%=totalRecord%>Articles(
		<font color="red"><%=nowPage+"/"+totalPage%>Pages</font>
		)
		</td>
	</tr>
</table>
<!-- 게시물 번호 Start -->
<table>
<tr>
		<td> 게시물 번호 : &nbsp; </td>
<% 
		int listSize = totalRecord - start;
		for(int i = 0; i < 10; i++){
			if(i == listSize) break;
%>
	<td align = "center"><%=totalRecord-start-i %></td>
<%} // -- for%>
	</tr>
</table>
<!-- 게시물 번호 End -->
<!-- 페이징 및 블럭 Start -->
<table>
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
	</tr>
</table>



<form name="readFrm">
	<input type="hidden" name="totalRecord" value="<%=totalRecord%>">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
</form>
<!-- 페이징 및 블럭 End -->
<hr width="60%"/>
<b>
totalRecord : <%=totalRecord%>&nbsp;
numPerPage : <%=numPerPage%>&nbsp;
pagePerBlock : <%=pagePerBlock%>&nbsp;
totalPage : <%=totalPage%>&nbsp;<br/>
totalBlock : <%=totalBlock%>&nbsp;
nowPage : <%=nowPage%>&nbsp;
nowBlock : <%=nowBlock%>&nbsp;
</b>
<p/>
<input type="button" value="TotalRecord 입력폼"
 onClick="javascript:location.href='pageView.html'">
</div>
</html>

