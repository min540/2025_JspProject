package test1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

public class CommentMgr {

	private DBConnectionMgr pool;
	private final SimpleDateFormat SDF_DATE =
			new SimpleDateFormat("yyyy'년'  M'월' d'일' (E)");
	
    public CommentMgr() {
		pool = DBConnectionMgr.getInstance();
	}
    
    //Comment Insert
    public void insertComment(CommentBean bean) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblComment values(null,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());//어떤 방명록 글
			pstmt.setString(2, bean.getCid());//댓글 쓴사람
			pstmt.setString(3, bean.getComment());//댓글 내용
			pstmt.setString(4, bean.getCip());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
    }
    
    //Comment List
    public Vector<CommentBean> listComment(int num){
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CommentBean> vlist = new Vector<CommentBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblComment where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentBean bean = new CommentBean();
				bean.setCnum(rs.getInt("cnum"));
				bean.setNum(rs.getInt("num"));
				bean.setCid(rs.getString("cid"));
				bean.setComment(rs.getString("comment"));
				bean.setCip(rs.getString("cip"));
				bean.setCregDate(SDF_DATE.format(rs.getDate("cregDate")));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
    }
    
    //Comment Delete
    public void deleteComment(int cnum) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblComment where cnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
    }
    
    //Comment All Delete : 방명록 관련된 모든 댓글 삭제
    public void deleteAllComment(int num) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblComment where num = ?";
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





