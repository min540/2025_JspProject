<!-- teamList2.jsp -->
<%@page import="java.util.Vector"%>
<%@page import="ch09.TeamBean"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
		try{
			String _driver = "com.mysql.cj.jdbc.Driver",
			_url = "jdbc:mysql://localhost:3306/mydb?characterEncoding=UTF-8&serverTimezone=UTC",
			_user = "root",
			_password = "1234";
			Class.forName(_driver);//Driver 객체 생성
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			con = DriverManager.getConnection(_url, _user, _password);
			Vector<TeamBean> vlist = new Vector<TeamBean>();
			String sql = "select * from tblTeam";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vlist.add(new TeamBean(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getInt(4),
						rs.getString(5)));
			}
			//out.print(vlist.size());
%>
<div align="center">
<h3>Team List2</h3>
<table border="1">
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>사는곳</th>
			<th>나이</th>
			<th>팀명</th>
	</tr>
	<!-- Vector에서 TeamBean 리턴하여 for문 사용 출력 -->
	<%
		for(int i=0;i<vlist.size();i++){ 
			TeamBean bean = vlist.get(i);
	%>
	<tr align="center">
		<td><%=i+1%></td>
		<td><%=bean.getName()%></td>
		<td><%=bean.getCity()%></td>
		<td><%=bean.getAge()%></td>
		<td><%=bean.getTeam()%></td>
	</tr>	
	<%}//--for%>
</table>	
</div>
<%}catch(Exception e){}%>