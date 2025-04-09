package jspproject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class TimerMgr {
	private DBConnectionMgr pool;
	public static final String  SAVEFOLDER = "C:/Users/dita_810/git/2025_JspProject/myapp/src/main/webapp/jspproject/img";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 5*1024*1024;
	public TimerMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//타이머 리스트
	public Vector<TimerBean> listTimer(int timer_id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TimerBean> vlist = new Vector<TimerBean>();
		try {
			con = pool.getConnection();
			sql = "select * from timer order by timer_id desc";
			pstmt = con.prepareStatement(sql);
			/* pstmt.setInt(1, timer_id); */
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TimerBean bean = new TimerBean();
				bean.setTimer_id(rs.getInt("timer_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setTimer_session(rs.getInt("timer_session"));
				bean.setTimer_break(rs.getInt("timer_break"));
				bean.setTimer_design(rs.getInt("timer_design"));
				bean.setTimer_title(rs.getString("timer_title"));
				bean.setTimer_cnt(rs.getString("timer_cnt"));
				bean.setTimer_loc(rs.getInt("timer_loc"));
				bean.setTimer_onoff(rs.getInt("timer_onoff"));
				bean.setTimer_img(rs.getString("timer_img"));
				vlist.addElement(bean);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//타이머 종류이름 검색
	public Vector<TimerBean> searchTimer(int timer_id, String title){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TimerBean> vlist = new Vector<TimerBean>();
		try {
			con = pool.getConnection();
			sql = "select * from timer where timer_id=? and timer_title like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, timer_id);
			pstmt.setString(2, "%"+title+"%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TimerBean bean = new TimerBean();
				bean.setTimer_id(rs.getInt("timer_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setTimer_session(rs.getInt("timer_session"));
				bean.setTimer_break(rs.getInt("timer_break"));
				bean.setTimer_design(rs.getInt("timer_design"));
				bean.setTimer_title(rs.getString("timer_title"));
				bean.setTimer_cnt(rs.getString("timer_cnt"));
				bean.setTimer_loc(rs.getInt("timer_loc"));
				bean.setTimer_onoff(rs.getInt("timer_onoff"));
				bean.setTimer_img(rs.getString("timer_img"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//타이머  이름순으로 나열
	public Vector<TimerBean> turnTimer(int timer_id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TimerBean> vlist = new Vector<TimerBean>();
		try {
			con = pool.getConnection();
			sql = "select * from timer order by timer_title";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, timer_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TimerBean bean = new TimerBean();
				bean.setTimer_id(rs.getInt("timer_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setTimer_session(rs.getInt("timer_session"));
				bean.setTimer_break(rs.getInt("timer_break"));
				bean.setTimer_design(rs.getInt("timer_design"));
				bean.setTimer_title(rs.getString("timer_title"));
				bean.setTimer_cnt(rs.getString("timer_cnt"));
				bean.setTimer_loc(rs.getInt("timer_loc"));
				bean.setTimer_onoff(rs.getInt("timer_onoff"));
				bean.setTimer_img(rs.getString("timer_img"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
}
