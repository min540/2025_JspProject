package jspproject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserTimerMgr {
	private DBConnectionMgr pool;
	
	public UserTimerMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//회원가입 했을 때 기본 타이머 넣기
	public void insertDefaultUserTimer(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql ="insert into user_timer(user_id, timer_id, timer_session, timer_break, timer_loc) values (?, 1, 600, 300, '1693,247')";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//유저가 타이머 디자인 변경
	public void updateUserTimerId(String user_id, int timer_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update user_timer set timer_id=? where user_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, timer_id);
			pstmt.setString(2, user_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//유저가 타이머 설정 변경(session, break, loc)
	public void updateUserTimerSetting(UserTimerBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update user_timer set timer_session=?, timer_break=?, timer_loc=? where user_timer_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getTimer_session());
			pstmt.setInt(2, bean.getTimer_break());
			pstmt.setString(3, bean.getTimer_loc());
			pstmt.setInt(4, bean.getUser_timer_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 유저가 세션, 브레이크 시간변경
	public void updateUserTimerSessionBreak(String user_id, int timer_session, int timer_break) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    try {
	        con = pool.getConnection();
	        sql = "update user_timer set timer_session=?, timer_break=? where user_id=?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, timer_session);
	        pstmt.setInt(2, timer_break);
	        pstmt.setString(3, user_id);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}

	//유저 타이머 전체 정보 가져오기
	public UserTimerBean getUserTimer(String user_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    UserTimerBean bean = null;
	    try {
	        con = pool.getConnection();
	        sql = "SELECT * FROM user_timer WHERE user_id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            bean = new UserTimerBean();
	            bean.setUser_timer_id(rs.getInt("user_timer_id"));
	            bean.setUser_id(rs.getString("user_id"));
	            bean.setTimer_id(rs.getInt("timer_id"));
	            bean.setTimer_session(rs.getInt("timer_session"));
	            bean.setTimer_break(rs.getInt("timer_break"));
	            bean.setTimer_loc(rs.getString("timer_loc"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return bean;
	}

	// 유저 session, break 값만 가져오기
	public UserTimerBean getUserTimerInfo(String user_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    UserTimerBean bean = null;
	    try {
	        con = pool.getConnection();
	        sql = "SELECT * FROM user_timer WHERE user_id=?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id);
	        rs = pstmt.executeQuery();
	        if(rs.next()) {
	            bean = new UserTimerBean();
	            bean.setTimer_session(rs.getInt("timer_session"));
	            bean.setTimer_break(rs.getInt("timer_break"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return bean;
	}
	
	// 타이머 위치 변경
	public void updateUserTimerLoc(String user_id, String timer_loc) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update user_timer set timer_loc=? where user_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, timer_loc);
			pstmt.setString(2, user_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 타이머 아이디 업데이트
	public boolean updateTimerId(String user_id, int timer_id){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE user_timer SET timer_id=? WHERE user_id=?";

		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, timer_id);
			pstmt.setString(2, user_id);

			int count = pstmt.executeUpdate();
			return count > 0; // 성공하면 true

		} catch(Exception e){
			e.printStackTrace();
			return false;
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}


}