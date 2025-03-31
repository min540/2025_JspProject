<!-- script.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<!-- 선언문(Declaration -->
<%!
		//필드 선언
		String dec = "선언문 변수";
		//메소드 선언
		public String decMethod(){
			return dec;
		}
%>
<!-- 스크립트릿(Scriptlet) -->
<%
		String scriptlet = "스크립트릿";
		out.print("내장객체를 이용한 출력 : " + dec + "<p>");
		
		String comment = "Comment";
%>
<!-- 표현식(Expression) : 자바코드이지만 뒤에 ; 없음 -->
선언문1 : <%=dec %><p>
선언문2 : <%=decMethod() %><p>
선언문3 : <%=scriptlet %><p>
<!-- JSP 주석 -->
<!-- JSP 주석1 : <%=comment%> -->
<%	
		//한줄주석
		/*부분 또는 여러 줄 주석*/
%>