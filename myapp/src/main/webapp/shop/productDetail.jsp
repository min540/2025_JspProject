<%@page import="java.util.Vector"%>
<%@page import="shop.MUtil"%>
<%@page import="shop.ProductBean"%>
<%@page import="shop.UtilMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="pmgr" class = "shop.ProductMgr"/>
<%

    int no = MUtil.parseInt(request, "no");
	ProductBean  pbean = pmgr.getProduct(no);
    
%>

<html>
<head>
<title>Simple Shopping Mall</title>
<script src="script.js"></script>
</head>
<body bgcolor="#996600" topmargin="100">
<%@ include file="top.jsp" %>
<form name="cart" action="cartProc.jsp">
<table width="75%" align="center" bgcolor="#FFFF99">
	<tr> 
	<td align="center" bgcolor="#FFFFCC">
		<table width="95%" bgcolor="#FFFF99" border="1">
		<tr bgcolor="#996600"> 
		<td colspan="3" align="center">
			<font color="#FFFFFF"></font>
		</td>
		</tr>
		<tr> 
		<td width="20%">
		<img src="data/<%=pbean.getImage() %>" height="150" width="150">
		</td>
		<td width="30%" valign="top">
			<table>
			<tr>
				<td><b>상품이름 : </b><%=pbean.getName() %></td>
			</tr>			
			<tr>
				<td><b>가    격 : </b><%= MUtil.monFormat(pbean.getPrice()) %>원</td>
			</tr>
			<tr>
				<td><b>수    량 : </b><input name="quantity" size="5" value="1">개</td>
			</tr>
			<tr>
			<td align="center">
				<input type="submit" value="장바구니 담기">
			</td>
			</tr>
			</table>
			<input type="hidden" name="productNo" value="<%=pbean.getNo()%>">	
			<input type="hidden" name="flag" value="insert">			
		</td>
		<td width="50%" valign="top">
		<b>상세설명</b><br/>
		<pre><%=pbean.getDetail() %></pre>
		</td>
		</tr>
		</table>
	</td>
	</tr>
</table>
</form>
<%@ include file="bottom.jsp" %>
</body>
</html>