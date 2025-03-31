<!-- script2.jsp -->
<%@ page  contentType="text/html; charset=UTF-8"%>
<!--  스크립트 요소를 액션 태그로 제공 : 거의 사용 안함 <!-- 너무 불편함 -->
<jsp:declaration>
	String str1 = "선언문 변수";
</jsp:declaration>

<jsp:scriptlet>
	String str2 = "스크립트릿 변수";
</jsp:scriptlet>

<jsp:expression>
	str1 + " : " +str2
</jsp:expression>
