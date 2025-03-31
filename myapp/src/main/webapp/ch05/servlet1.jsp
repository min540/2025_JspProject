<!-- servlet1.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<%!
		int one; // 필드는 JVM이 초기화
		int two;
		public int plus(){
			return one+two;
		}
		
%>
plus 메소드 호출 : <%=plus()  %>