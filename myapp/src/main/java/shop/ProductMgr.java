package shop;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import ch15.BoardBean;

public class ProductMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/myapp/src/main/webapp/shop/data/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1202*1024*50;//50mb
	
	public ProductMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// Product List
	public Vector<ProductBean> getProductList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			con = pool.getConnection();
			sql = "select no, stock, price, name, date from tblProduct order by no desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setNo(rs.getInt(1));
				bean.setStock(rs.getInt(2));
				bean.setPrice(rs.getInt(3));
				bean.setName(rs.getString(4));
				bean.setDate(rs.getString(5));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// Product Detail
	public ProductBean getProduct(int no/*상품번호*/) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ProductBean bean = null;
		try {
			con = pool.getConnection();
			sql = "select * from tblProduct where no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean = new ProductBean(rs.getInt(1), rs.getString(2), rs.getInt(3), 
						rs.getString(4), rs.getString(5), rs.getInt(6), rs.getString(7));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// Product Stock Reduce (구매 -> 재고 수정)
	public void reduceProduct(OrderBean order) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblProduct set stock = stock - ? where no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, order.getQuantity());
			pstmt.setInt(2, order.getProductNo());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//// admin mode ////
	
	// Product Insert : 업로드 이미지가 없다면 ready.gif 저장
	// hint : getFilesystemName("image")값이 null이면
	public boolean insertProduct(HttpServletRequest req) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    boolean flag = false;
	    try {
	        MultipartRequest multi = 
	        		new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCODING,
	        				new DefaultFileRenamePolicy());
	        con = pool.getConnection();
	        sql = "insert tblProduct values(null, ?, ?, ?, ?, ?, ?)";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, multi.getParameter("name"));
			pstmt.setInt(2, MUtil.parseInt(multi, "price"));
			pstmt.setString(3, multi.getParameter("detail"));
			pstmt.setString(4, MUtil.getDay());
			pstmt.setInt(5, MUtil.parseInt(multi, "stock"));
			if(multi.getFilesystemName("image")!=null)
				pstmt.setString(6, multi.getFilesystemName("image"));
			else
				pstmt.setString(6, "ready.gif");
			if(pstmt.executeUpdate()==1) flag = true;
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	    return flag;  // 삽입 성공 여부 반환
	}

	
	// Product Update
	// 상품 이미지를 수정할 수도 있고, 안 할 수도 있음
	public boolean updateProduct(HttpServletRequest req) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    boolean flag = false;
	    try {
	        MultipartRequest multi =
	        		new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCODING, 
	        				new DefaultFileRenamePolicy());
	        con = pool.getConnection();
	        if(multi.getFilesystemName("image")!=null) {
	        	// 이미지도 수정
	        	sql = "update tblProduct set name=?, price=?, detail=?, stock=?, image=? where no = ?";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, multi.getParameter("name"));
				pstmt.setInt(2, MUtil.parseInt(multi, "price"));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setInt(4, MUtil.parseInt(multi, "stock"));
				pstmt.setString(5, multi.getFilesystemName("image"));
				pstmt.setInt(6, MUtil.parseInt(multi, "no"));
	        } else {
	        	// 이미지는 수정 아님
	        	sql = "update tblProduct set name=?, price=?, detail=?, stock=? where no = ?"; 
	        	pstmt = con.prepareStatement(sql);
	        	pstmt.setString(1, multi.getParameter("name"));
				pstmt.setInt(2, MUtil.parseInt(multi, "price"));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setInt(4, MUtil.parseInt(multi, "stock"));
				pstmt.setInt(5, MUtil.parseInt(multi, "no"));
	        }
	        if(pstmt.executeUpdate()==1) flag = true;
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	    return flag;
	}
	
	// Product Delete : 상품 이미지는 삭제하지 않는다.
	public boolean deleteProduct(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from tblProduct where no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			//no가 pk이기 때문에 적용되는 레코드 개수가 0, 1
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
}
