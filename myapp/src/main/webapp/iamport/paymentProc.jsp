<!-- paymentProc.jsp -->
<%@page import="shop.MUtil"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%
		int apply_num = MUtil.parseInt(request, "apply_num"); // 카드 승인 번호
		int paid_amount = MUtil.parseInt(request, "paid_amount"); // 승인 금액
		String msg = "카드승인번호 및 승인 금액 : " + apply_num + " : " + paid_amount;	
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=request.getContextPath()%>/iamport/payForm.jsp";
</script>