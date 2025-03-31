package ch16;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class PollMgr {

	private DBConnectionMgr pool;
	
	public PollMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Max Num : 가장 큰 num값 리턴
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum = 0;
		try {
			con = pool.getConnection();
			sql = "select max(num) from tblPollList";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) maxNum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
	
	//Poll Insert : 설문과 item을 같이 저장
	public boolean insertPoll(PollListBean plBean, PollItemBean piBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblPollList values(null, ?, ?, ?, now(), ?, 1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, plBean.getQuestion());
			pstmt.setString(2, plBean.getSdate());
			pstmt.setString(3, plBean.getEdate());
			pstmt.setInt(4, plBean.getType());
			int cnt = pstmt.executeUpdate();
			pstmt.close();
			if(cnt==1) {
				sql = "insert tblPollItem values (?, ?, ?, 0)";
				pstmt = con.prepareStatement(sql);
				int listNum = getMaxNum();//방금 저장한 num값 리턴
				String item[] = piBean.getItem();
				for (int i = 0; i < item.length; i++) {
					if(item[i]==null||item[i].trim().equals("")) {
						break;
					}
					pstmt.setInt(1, listNum);
					pstmt.setInt(2, i);
					pstmt.setString(3, item[i]);
					pstmt.addBatch();//배치추가
				}
				int[] results = pstmt.executeBatch();
				for (int result : results) {
					if(result==1) {
						flag = true;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Poll List
	public Vector<PollListBean> getPollList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PollListBean> vlist = new Vector<PollListBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblPollList order by num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vlist.addElement(new PollListBean(rs.getInt("num"),
						                                                  rs.getString("question"),
						                                                  rs.getString("sdate"),
						                                                  rs.getString("edate"),
						                                                  rs.getString("wdate"),
						                                                  rs.getInt("type"),
						                                                  rs.getInt("active")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Poll Read
	public PollListBean getPoll(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PollListBean plBean = new PollListBean();
		try {
			con = pool.getConnection();
			sql = "select num, question, type, active from tblPollList where num = ?";
			pstmt = con.prepareStatement(sql);
			if(num==0) num = getMaxNum();
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				plBean.setNum(rs.getInt(1));
				plBean.setQuestion(rs.getString(2));
				plBean.setType(rs.getInt(3));
				plBean.setActive(rs.getInt(4));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return plBean;
	}
	
	//Poll Item List
	public Vector<String> getItemList(int listNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<String> vlist = new Vector<String>();
		try {
			con = pool.getConnection();
			sql = "select item from tblPollItem where listNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, listNum==0?getMaxNum():listNum);
			rs = pstmt.executeQuery();
			while(rs.next())
				vlist.addElement(rs.getString(1));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Count Sum
	public int sumCount(int listNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int sumCnt = 0;
		try {
			con = pool.getConnection();
			sql = "select sum(count) from tblPollItem where listNum= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, listNum==0?getMaxNum():listNum);
			rs = pstmt.executeQuery();
			if(rs.next()) sumCnt = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return sumCnt;
	}
	
	//Poll Update : 투표실행
	public boolean updatePoll(int listNum, String itemNum[]) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblPollItem set count=count+1 where listNum = ? and itemNum = ?";
			pstmt = con.prepareStatement(sql);
			if(listNum==0) listNum = getMaxNum();
			for (String item : itemNum) {
				pstmt.setInt(1, listNum);
				pstmt.setInt(2, Integer.parseInt(item));
				pstmt.addBatch();
			}
			int results[] = pstmt.executeBatch();
			for (int result : results) {
				if(result > 0)
					flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Poll View
	public Vector<PollItemBean> getView(int listNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PollItemBean> vlist = new Vector<PollItemBean>();
		try {
			con = pool.getConnection();
			sql = "select item, count from tblPollItem where listNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, listNum==0?getMaxNum():listNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PollItemBean piBean = new PollItemBean();
				String item[] = new String[1];
				item[0] = rs.getString(1);
				piBean.setItem(item);
				piBean.setCount(rs.getInt(2));
				vlist.addElement(piBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Max Item Count : 아이템 중에 가장 높은 투표값
	public int getMaxCount(int listNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxCnt = 0;
		try {
			con = pool.getConnection();
			sql = "select max(count) from tblPollItem where listNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, listNum==0?getMaxNum():listNum);
			rs = pstmt.executeQuery();
			if(rs.next()) maxCnt = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxCnt;
	}
}




















