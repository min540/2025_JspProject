<!-- cartProc.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="cMgr" class = "shop.CartMgr" scope = "session"/>
<jsp:useBean id = "order" class = "shop.OrderBean"/>
<jsp:setProperty property="*" name="order"/>
<%
		String id = (String)session.getAttribute("idKey");
		if(id == null){
			response.sendRedirect("login.jsp");
			return; // 이후에 코드 무력화
		}
		order.setId(id); // 로그인 id 주문자
		String flag = request.getParameter("flag");
		String msg = "";
		if(flag.equals("insert")){
			msg = "장바구니에 저장하였습니다.";
			cMgr.addCart(order);
		} else if(flag.equals("update")){
			msg = "장바구니에 수정하였습니다.";
			cMgr.updateCart(order);
			
		}else if(flag.equals("delete")){
			msg = "장바구니에 삭제하였습니다.";
			cMgr.deleteCart(order);
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "cartList.jsp";
</script>