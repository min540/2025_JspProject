package ch19;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class PBlogMgr {

	private DBConnectionMgr pool;
	public static final String  SAVEFOLDER = "C:/Jsp/myapp/src/main/webapp/ch19/photo/";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 5*1024*1024;
	
	public PBlogMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// Random List : 자신을 제외한 랜덤한 5명 리스트
	public Vector<PMemberBean> listPMember(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PMemberBean> vlist = new Vector<PMemberBean>();
		try {
			con = pool.getConnection();
			sql = "select id, name, profile from tblPMember "
					+ "where id != ? order by rand() limit 5";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PMemberBean bean = new PMemberBean();
				bean.setId(rs.getString(1));
				bean.setName(rs.getString(2));
				bean.setProfile(rs.getString(3));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// PBlog Insert
	public void insertPBlog(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER,
							MAXSIZE, ENCTYPE,
							new DefaultFileRenamePolicy());
			String photo = null;
			if(multi.getFilesystemName("photo")!=null)
				photo = multi.getFilesystemName("photo");
			con = pool.getConnection();
			sql = "insert tblPBlog values(null,?,?,now(),?,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("message"));
			pstmt.setString(2, multi.getParameter("id"));
			pstmt.setString(3, photo);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// PBlog List
	public Vector<PBlogBean> listPBlog(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PBlogBean> vlist = new Vector<PBlogBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblPBlog where id = ? order by num desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PBlogBean bean = new PBlogBean();
				bean.setNum(rs.getInt(1));
				bean.setMessage(rs.getString(2));
				bean.setId(rs.getString(3));
				bean.setPdate(rs.getString(4));
				bean.setPhoto(rs.getString(5));
				bean.setHcnt(rs.getInt(6));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// PBlog Get
	public String getPhoto(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String photo = null;
		try {
			con = pool.getConnection();
			sql = "select photo from tblPBlog where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) photo = rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return photo;
	}
	
	// HCnt Up
	public void upHCnt(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblPBlog set hCnt = hCnt+1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// PBlog Delete : 첨부된 사진 삭제, 댓글 모두 삭제
	public void deletePBlog(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			String photo = getPhoto(num);
			if(photo!=null) {
				File f = new File(SAVEFOLDER+photo);
				if(f.exists()) f.delete(); // 파일이 존재한다면 삭제
			}
			con = pool.getConnection();
			sql = "delete from tblPBlog where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			if(pstmt.executeUpdate()==1) {
				// 댓글 전부 삭제
				PReplyMgr rMgr = new PReplyMgr();
				rMgr.deleteAllPReply(num);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
}
