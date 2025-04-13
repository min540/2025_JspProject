 package jspproject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Vector;

import jspproject.DBConnectionMgr;

public class ObjMgr {
	
	private DBConnectionMgr pool;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy'년'  M'월' d'일' (E)");
	
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
			sql = "insert obj values (null, ?, ?, ?, now(), ?, ?, ?)";// 시작시간 추가시 now()가아니라 ?로 받을지 고려
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUser_id());
			pstmt.setString(2, bean.getObj_title());
			pstmt.setInt(3, bean.getObj_check());
			pstmt.setString(4, bean.getObj_sdate());
			pstmt.setString(5, bean.getObj_edate());
			pstmt.setInt(6, bean.getObjgroup_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//insert+키(obj_id)값받아오는 매서드
	public int insertObjAndReturnId(ObjBean bean) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    int obj_id = -1;

	    try {
	        con = pool.getConnection();
	        sql = "INSERT INTO obj (user_id, obj_title, obj_check, obj_regdate, obj_sdate, obj_edate, objgroup_id) VALUES (?, ?, ?, NOW(), NOW(), ?, ?)";
	        pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	        pstmt.setString(1, bean.getUser_id());
	        pstmt.setString(2, bean.getObj_title());
	        pstmt.setInt(3, bean.getObj_check());

	        String edate = bean.getObj_edate();
	        if (edate == null || edate.trim().isEmpty()) {
	            pstmt.setNull(4, java.sql.Types.DATE);
	        } else {
	            pstmt.setString(4, edate);
	        }

	        pstmt.setInt(5, bean.getObjgroup_id());

	        pstmt.executeUpdate();

	        // 생성된 자동 키 받아오기
	        rs = pstmt.getGeneratedKeys();
	        if (rs.next()) {
	            obj_id = rs.getInt(1); // 자동 생성된 obj_id
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return obj_id;
	}

	
	//작업 목록 수정
	public void updateObj(ObjBean bean) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = "UPDATE obj SET obj_title = ?, obj_sdate = ?, obj_edate = ? WHERE obj_id = ?";
	    
	    try {
	        con = pool.getConnection();
	        pstmt = con.prepareStatement(sql);

	        // null-safe title
	        String title = bean.getObj_title();
	        if (title == null) title = "";
	        pstmt.setString(1, title);
	        
	        // sdate
	        String sdate = bean.getObj_sdate();
	        if (sdate == null || sdate.trim().isEmpty()) {
	            pstmt.setNull(2, java.sql.Types.DATE);
	        } else {
	            pstmt.setString(2, sdate);
	        }
	        
	        // null-safe edate
	        String edate = bean.getObj_edate();
	        if (edate == null || edate.trim().isEmpty()) {
	            pstmt.setNull(3, java.sql.Types.DATE);
	        } else {
	            pstmt.setString(3, edate);
	        }
	        // ID 체크
	        pstmt.setInt(4, bean.getObj_id());
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}
	
	//체크박스 전용
	public void updateCheckOnly(int objId, int objCheck) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = "UPDATE obj SET obj_check = ? WHERE obj_id = ?";

	    try {
	        con = pool.getConnection();
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, objCheck);
	        pstmt.setInt(2, objId);
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
			sql = "insert objgroup values (null, ?, ?)";
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
	
	// insert + 자동 생성된 objgroup_id 반환
	public int insertObjGroupAndReturnId(ObjGroupBean bean) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    int objgroup_id = -1;

	    try {
	        con = pool.getConnection();
	        sql = "INSERT INTO objgroup (objgroup_name, user_id) VALUES (?, ?)";
	        pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	        pstmt.setString(1, bean.getObjgroup_name());
	        pstmt.setString(2, bean.getUser_id());
	        pstmt.executeUpdate();

	        // 생성된 자동 키 받아오기
	        rs = pstmt.getGeneratedKeys();
	        if (rs.next()) {
	            objgroup_id = rs.getInt(1); // 자동 생성된 objgroup_id
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }

	    return objgroup_id;
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
			pstmt.setInt(2, bean.getObjgroup_id());
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
			pstmt.setInt(2, bean.getObj_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	//작업 목록 리스트 받아오기(objgroup_id로 구분하도록 만듦), user_id
	public Vector<ObjBean> getObjList(int objgroup_id, String user_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    Vector<ObjBean> vlist = new Vector<>();
	    try {
	        con = pool.getConnection();
	        String sql = "SELECT obj_id, obj_title, obj_check,obj_sdate ,obj_edate FROM obj WHERE objgroup_id = ? and user_id=? ";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, objgroup_id);
	        pstmt.setString(2, user_id);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            ObjBean bean = new ObjBean();
	            bean.setObj_id(rs.getInt("obj_id"));
	            bean.setObj_title(rs.getString("obj_title"));
	            bean.setObj_check(rs.getInt("obj_check"));
	            bean.setObj_sdate(rs.getString("obj_sdate"));
	            System.out.println("✅ DB sdate: " + rs.getString("obj_sdate"));
	            System.out.println("✅ DB edate: " + rs.getString("obj_edate"));
	            System.out.println("📦 Bean sdate 저장 후: " + bean.getObj_sdate());
	            bean.setObj_edate(rs.getString("obj_edate"));  // 형식 변환 필요 시 여기도 SDF_DATE 가능
	            vlist.add(bean);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return vlist;
	}
	
	// 전체 완료된 작업 목표 받아오기 (obj_check = 1인 것만)
	public Vector<ObjBean> getTotalObjList(String user_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    Vector<ObjBean> vlist = new Vector<>();
	    try {
	        con = pool.getConnection();
	        String sql = "SELECT obj_id, obj_title, obj_check, obj_regdate, obj_edate " +
	                     "FROM obj WHERE user_id = ? AND obj_check = 1";
	        pstmt = con.prepareStatement(sql);      
	        pstmt.setString(1, user_id);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            ObjBean bean = new ObjBean();
	            bean.setObj_id(rs.getInt("obj_id"));
	            bean.setObj_title(rs.getString("obj_title"));
	            bean.setObj_check(rs.getInt("obj_check"));
	            bean.setObj_regdate(rs.getString("obj_regdate"));
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
			sql = "SELECT * FROM objgroup WHERE user_id = ? ORDER BY objgroup_id DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ObjGroupBean bean = new ObjGroupBean();
				bean.setObjgroup_id(rs.getInt("objgroup_id"));
				bean.setObjgroup_name(rs.getString("objgroup_name"));
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
