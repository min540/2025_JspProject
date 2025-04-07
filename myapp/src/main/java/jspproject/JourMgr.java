package jspproject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

public class JourMgr {
	private DBConnectionMgr pool;
	public static final String  SAVEFOLDER = "C:/Users/dita_810/git/2025_JspProject/myapp/src/main/webapp/jspproject/img";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 5*1024*1024;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy'년'  M'월' d'일' (E)");
	public JourMgr() {
		
		pool = DBConnectionMgr.getInstance();
	}
	//일지 리스트
	public Vector<JourBean> listJour(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<JourBean> vlist = new Vector<JourBean>();
		try {
			con = pool.getConnection();
			sql = "select * from jour where user_id = ? order by jour_id desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
			JourBean bean = new JourBean();
			bean.setJour_id(rs.getInt("jour_id"));
			bean.setUser_id(rs.getString("user_id"));
			bean.setJour_title(rs.getString("jour_title"));
			bean.setJour_cnt(rs.getString("jour_cnt"));
			bean.setJour_regdate(SDF_DATE.format(rs.getDate("jour_regDate")));
			vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 일지 작성 후 생성된 ID 반환
	public int insertJour(JourBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int generatedId = -1;

		try {
			con = pool.getConnection();
			sql = "INSERT INTO jour(user_id, jour_title, jour_cnt, jour_regDate) VALUES(?, ?, ?, NOW())";
			pstmt = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, bean.getUser_id());
			pstmt.setString(2, bean.getJour_title());
			pstmt.setString(3, bean.getJour_cnt());
			pstmt.executeUpdate();

			rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				generatedId = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return generatedId;
	}

	
	//일지 수정
	public void updateJour(JourBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update jour set jour_title=?, jour_cnt=? where jour_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getJour_title());
			pstmt.setString(2, bean.getJour_cnt());
			pstmt.setInt(3, bean.getJour_id());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//일지 삭제
	public void deleteJour(int jour_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from jour where jour_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,jour_id);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}

