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

import ch19.DBConnectionMgr;

public class JspMgr {
	
	private DBConnectionMgr pool;
	//세이브 폴더 pull 받을 시 자기 폴더에 맞게 주소 변경할 것
	public static final String  SAVEFOLDER = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/img";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 5*1024*1024;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy'년'  M'월' d'일' (E)");
	private final SimpleDateFormat SDF_TIME = new SimpleDateFormat("H:mm:ss");
	
	public JspMgr() {
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
			sql = "insert user values(?, ?, ?, ?, ?, null, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("user_id"));
			pstmt.setString(2, multi.getParameter("user_pwd"));
			pstmt.setString(3, multi.getParameter("user_name"));
			pstmt.setString(4, multi.getParameter("user_email"));
			pstmt.setString(5, multi.getParameter("user_phone"));
			pstmt.setString(6, User_icon);
			pstmt.executeUpdate();
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
			sql = "select id from user where id = ? and pwd = ?";
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
	
}
