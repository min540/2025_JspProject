package jspproject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

import jspproject.DBConnectionMgr;

public class ObjMgr {
	
	private DBConnectionMgr pool;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy'년'  M'월' d'일' (E)");
	private final SimpleDateFormat SDF_TIME = new SimpleDateFormat("H:mm:ss");
	
	public ObjMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//작업 목록 추가
	public void insertObj(ObjBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert obj values (null, ?, ?, ?, now(), now(), ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUser_id());
			pstmt.setString(2, bean.getObj_title());
			pstmt.setInt(3, bean.getObj_check());
			pstmt.setString(4, bean.getObj_sdate());
			pstmt.setString(5, bean.getObj_edate());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//작업 목록 수정
	public void updateObj(ObjBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE obj SET obj_title = ?, obj_sdate = ?, obj_edate = ? WHERE obj_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getObj_title());
			pstmt.setString(2, bean.getObj_sdate());
			pstmt.setString(3, bean.getObj_edate());
			pstmt.setInt(4, bean.getObj_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//작업 목록 삭제
	public void deleteObj(int obj_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM obj WHERE obj_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, obj_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//작업 목록 카테고리 추가
	public void insertObjGroup(ObjGroupBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert objgroup values (null, ?, null, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getObjgroup_name());
			pstmt.setString(2, bean.getUser_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//작업 목록 카테고리 수정
	public void updateObjGroup(ObjGroupBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE objgroup SET objgroup_name = ? WHERE objgroup_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getObjgroup_name());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//작업 목록 카테고리 삭제
	public void deleteObjGroup(int objgroup_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM objgroup WHERE objgroup_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, objgroup_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//작업 목록 성공 여부 확인(체크박스에 체크할 시 1, 체크를 풀면 0)
	public void updateObjCheck(ObjBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE obj SET obj_check = ? WHERE obj_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getObj_check());
			pstmt.setString(2, bean.getUser_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//작업 목록 리스트 받아오기
	public Vector<ObjBean> getObjList(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ObjBean> vlist = new Vector<ObjBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM obj WHERE user_id = ? ORDER BY obj_id DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ObjBean bean = new ObjBean();
				bean.setObj_id(rs.getInt("obj_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setObj_title(rs.getString("obj_title"));
				bean.setObj_check(rs.getInt("obj_check"));
				bean.setObj_regdate(SDF_DATE.format(rs.getDate("obj_regdate")));
				bean.setObj_sdate(SDF_DATE.format(rs.getDate("obj_sdate")));
				bean.setObj_edate(rs.getString("obj_edate"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//작업 목록 카테고리 리스트 받아오기
	public Vector<ObjGroupBean> getObjGroupList(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ObjGroupBean> vlist = new Vector<ObjGroupBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM objgroup WHERE user_id = ? ORDER BY obj_id DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ObjGroupBean bean = new ObjGroupBean();
				bean.setObj_id(rs.getInt("objgroup_id"));
				bean.setObjgroup_name(rs.getString("objgroup_name"));
				bean.setObj_id(rs.getInt("obj_id"));
				bean.setUser_id(rs.getString("user_id"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
}
