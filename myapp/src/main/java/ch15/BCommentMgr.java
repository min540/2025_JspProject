package ch15;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

import ch15.DBConnectionMgr;

public class BCommentMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = 
			"C:/Jsp/myapp/src/main/webapp/ch15/fileupload/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*50; //50mb
	
	
	public BCommentMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	 public void insertBComment(BCommentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblBComment(name,comment,regdate,num) "
					+ "values(?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getComment());
			pstmt.setInt(3, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	 }
	 
	 public Vector<BCommentBean> getBComment(int num){
		 Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BCommentBean> vlist = new Vector<BCommentBean>();
		
		try {
			con = pool.getConnection();
			sql = "select * from tblBcomment where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BCommentBean bean = new BCommentBean();
				bean.setCnum(rs.getInt("cnum"));
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setComment(rs.getString("comment"));
				bean.setRegdate(rs.getString("regdate"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		 return vlist;
	 }
	 
	 // Comment Count (list.jsp)
	 public int getBCommentCount(int num) { // <- 댓글의 개수
		 Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from tblBcomment where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) 
				count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		 return count;
	 }
	 
	 public void deleteBComment(int cnum) {
		 Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblBcomment where cnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		 
	 }
	 
	 // Comment All Delete
	 public void deleteAllBComment(int num) {
		 Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblBcomment where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		 
	 }
	 
}
