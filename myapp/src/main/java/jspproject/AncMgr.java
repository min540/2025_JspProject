package jspproject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

public class AncMgr {
		
	private DBConnectionMgr pool;
	public static final String  SAVEFOLDER = "C:/Users/dita_810/git/2025_JspProject/myapp/src/main/webapp/jspproject/img";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 5*1024*1024;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy'년'  M'월' d'일' (E)");
	private final SimpleDateFormat SDF_TIME = new SimpleDateFormat("H:mm:ss");
	
	
	public AncMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//공지사항 리스트
	public Vector<AncBean> listAnc() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AncBean> vlist = new Vector<AncBean>();
		try {
			con = pool.getConnection();
			sql = "select * from anc order by anc_id desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				AncBean bean = new AncBean();
				bean.setAnc_id(rs.getInt("anc_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setAnc_title(rs.getString("anc_title"));
				bean.setAnc_cnt(rs.getString("anc_cnt"));
				bean.setAnc_regdate(rs.getString("anc_regdate"));
				bean.setAnc_image(rs.getString("anc_image"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//공지사항 작성(관리자만사용)
	public void insertAnc(AncBean bean, String grade) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			if(grade !=null && grade.equals("1")) {
			con = pool.getConnection();
			sql = "insert anc values(null, ?, ?, ?, now(), ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUser_id());
			pstmt.setString(2, bean.getAnc_title());
			pstmt.setString(3, bean.getAnc_cnt());
			pstmt.setString(4, bean.getAnc_image());
			pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	//공지사항 수정
	public void updateAnc(AncBean bean, String grade) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			if(grade !=null && grade.equals("1")) {
			con = pool.getConnection();
			sql = "update anc set anc_title=?, anc_cnt=?, anc_image=? where anc_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getAnc_title());
			pstmt.setString(2, bean.getAnc_cnt());
			pstmt.setString(3, bean.getAnc_image());
			pstmt.setInt(4, bean.getAnc_id());
			pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	//공지사항 삭제
	public void deleteAnc(int anc_id, String grade) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			if(grade !=null && grade.equals("1")) {
			con = pool.getConnection();
			sql = "delete from anc where anc_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, anc_id);
			pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}

