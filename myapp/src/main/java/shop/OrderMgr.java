package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class OrderMgr {
	
	private DBConnectionMgr pool;
	
	public OrderMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// Order Insert : state -> 접수중(1), 접수(2), 입금확인(3), 배송준비(4), 배송중(5), 완료(6)
	public void insertOrder(OrderBean order) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblOrder values(null, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, order.getProductNo()); // 어떤 상품
			pstmt.setInt(2, order.getQuantity()); // 몇개
			pstmt.setString(3, MUtil.getDay()); // 언제
			pstmt.setString(4, "1"); // 접수중
			pstmt.setString(5, order.getId()); // 누가
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// Order List
	public Vector<OrderBean> getOrderList(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblOrder where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vlist.addElement(new OrderBean(
									rs.getInt(1), 
									rs.getInt(2), 
									rs.getInt(3), 
									rs.getString(4), 
									rs.getString(5), 
									rs.getString(6)));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	
	
	
	///// admin Mode /////
	
	// Order All List
	//select * from tblOrder order by no desc
	public Vector<OrderBean> getAllOrderList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblOrder order by no desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vlist.addElement(
						new OrderBean(rs.getInt(1), 
												rs.getInt(2), 
												rs.getInt(3), 
												rs.getString(4), 
												rs.getString(5), 
												rs.getString(6)));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// Order Detail
	// select * from tblOrder where no = ?
	public OrderBean getOrderDetail(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		OrderBean order = null;
		try {
			con = pool.getConnection();
			sql = "select * from tblOrder where no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				order = new OrderBean(rs.getInt(1), rs.getInt(2), rs.getInt(3), 
						rs.getString(4), rs.getString(5), rs.getString(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return order;
	}
	
	
	// Order Update
	// update tblOrder set state = ? where no = ?
	public boolean updateOrder(int no, String state) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblOrder set state = ? where no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, state);
			pstmt.setInt(2, no);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// Order Delete
	// delete from tblOrder where no = ?
	public boolean deleteOrder(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from tblOrder where no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
}
