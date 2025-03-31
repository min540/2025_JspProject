<!-- productList.jsp -->
<%@page import="shop.MUtil"%>
<%@page import="shop.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="pMgr" class = "shop.ProductMgr"/>
<%
		Vector<ProductBean> pvlist = pMgr.getProductList();
%>

<html>
<head>
<title>Simple Shopping Mall</title>
<script>
    function productDetail(productNo) {
        // productDetail.jsp로 productNo를 전송하면서 이동
        document.detail.no.value = productNo;
        document.detail.submit();
    }
</script>

<script src="script.js"></script>
</head>
<body bgcolor="#996600" topmargin="100">
	<%@ include file="top.jsp" %>
	<table width="75%" align="center" bgcolor="#FFFF99">
	<tr> 
	<td align="center" bgcolor="#FFFFCC">
		<table width="95%" bgcolor="#FFFF99" border="1">
			<tr align="center" bgcolor="#996600"> 
				<td><font color="#FFFFFF">이름</font></td>
				<td><font color="#FFFFFF">가격</font></td>
				<td><font color="#FFFFFF">날짜</font></td>
				<td><font color="#FFFFFF">재고</font></td>
				<td><font color="#FFFFFF">상세보기</font></td>
			</tr>
			<%
				for (int i = 0; i < pvlist.size(); i++){
					ProductBean pbean = pvlist.get(i);
			%>
			<tr align = "center">
				<td><%=pbean.getName()%></td>
				<td><%=MUtil.monFormat(pbean.getPrice())%></td>
				<td><%=pbean.getDate()%></td>
				<td><%=MUtil.monFormat(pbean.getStock()) %></td>
				<td><input type = "button" value = "상세보기" 
				onclick = "productDetail('<%=pbean.getNo()%>')">
			<%} %>
			</tr>
		</table>
	</td>
	</tr>
	</table>
	<form name="detail" method="post" action="productDetail.jsp" >
		<input type="hidden" name="no">
	</form>
	<%@ include file="bottom.jsp" %>
</body>
</html>
