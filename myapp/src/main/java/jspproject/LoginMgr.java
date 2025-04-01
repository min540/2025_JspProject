package jspproject;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import javax.mail.MultipartDataSource;
import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



public class LoginMgr {
	
	private DBConnectionMgr pool;
	//세이브 폴더 pull 받을 시 자기 폴더에 맞게 주소 변경할 것
	public static final String  SAVEFOLDER = "C:/Users/dita_806/git/2025_JspProject_dtada11/myapp/src/main/webapp/jspproject/img";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 5*1024*1024;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy'년'  M'월' d'일' (E)");
	private final SimpleDateFormat SDF_TIME = new SimpleDateFormat("H:mm:ss");
	
	public LoginMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//회원가입
	public boolean insertUser(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		MultipartRequest multi = null;
		String User_icon = null;
		boolean flag = false;
		try {
			File file = new File(SAVEFOLDER);
			if(!file.exists())
				file.mkdir();
			multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCTYPE,
					new DefaultFileRenamePolicy());
			User_icon = multi.getFilesystemName("User_icon");
			con = pool.getConnection();
			sql = "insert user values(?, ?, ?, ?, ?, 1, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("user_id"));
			pstmt.setString(2, multi.getParameter("user_pwd"));
			pstmt.setString(3, multi.getParameter("user_name"));
			pstmt.setString(4, multi.getParameter("user_email"));
			pstmt.setString(5, multi.getParameter("user_phone"));
			pstmt.setString(6, User_icon);
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
		
	
	//로그인
	public boolean loginJoin(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select user_id from user where user_id = ? and user_pwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, req.getParameter("user_id"));
			pstmt.setString(2, req.getParameter("user_pwd"));
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//회원 정보 수정
	public boolean updateUser(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		MultipartRequest multi = null;
		String User_icon = null;
		boolean flag = false;
		try {
			multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCTYPE,
					new DefaultFileRenamePolicy());
			User_icon = multi.getFilesystemName("profile");
			con = pool.getConnection();
			if(User_icon!=null&&!User_icon.equals("")) {
				sql = "update user set user_pwd = ?, user_name = ?, user_email = ?, user_phone = ?, user_icon = ? where id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("user_pwd"));
				pstmt.setString(2, multi.getParameter("user_name"));
				pstmt.setString(3, multi.getParameter("user_email"));
				pstmt.setString(4, multi.getParameter("user_phone"));
				pstmt.setString(5, User_icon);
				pstmt.setString(6, multi.getParameter("user_id"));
			}else {
				sql = "update user set user_pwd = ?, user_name = ?, user_email = ?, user_phone = ? where id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("user_pwd"));
				pstmt.setString(2, multi.getParameter("user_name"));
				pstmt.setString(3, multi.getParameter("user_email"));
				pstmt.setString(4, multi.getParameter("user_phone"));
				pstmt.setString(5, multi.getParameter("user_id"));
			}
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//회원 탈퇴(삭제)
	public void deleteUser(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//아이디 중복 확인
	public boolean idChk(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select user_id from user where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return !flag; //중복되지 않으면 true 반환, 중복이 있으면 false 반환
	}
	
	//전화번호 중복 체크(이미 저장된 전화번호면 true 반환)
	public boolean phoneChk(String user_phone) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select user_phone from user where user_phone = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_phone);
			rs = pstmt.executeQuery();
			if(rs.next())
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//접속 시작
	public void userIn(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert id_check values(?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//동시 접속 확인(이미 접속해있으면 true)
	public boolean userCheck(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from id_check where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next())
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//접속 종료
	public void userOut(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from id_check where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}
