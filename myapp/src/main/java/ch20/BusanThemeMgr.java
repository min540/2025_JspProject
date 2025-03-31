package ch20;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class BusanThemeMgr {

	private DBConnectionMgr pool;
	
	public BusanThemeMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 페이징 처리된 목록 조회
	// 
	public Vector<BusanThemeBean> listBusanTheme(int page, int perPage){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BusanThemeBean> vlist = new Vector<BusanThemeBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM tblBusanTheme LIMIT ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, (page - 1) * perPage);
			pstmt.setInt(2, perPage);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BusanThemeBean theme = new BusanThemeBean();
                theme.setUcSeq(rs.getInt("uc_seq"));
                theme.setMainTitle(rs.getString("main_title"));
                theme.setGugunNm(rs.getString("gugun_nm"));
                theme.setCate2Nm(rs.getString("cate2_nm"));
                theme.setPlace(rs.getString("place"));
                theme.setMainImgThumb(rs.getString("main_img_thumb"));
                vlist.addElement(theme);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 총 게시물 수
	public int getTotalCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCnt = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM tblBusanTheme";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) totalCnt = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCnt;
	}
	
	
	// 부산테마정보  한 개 가져오기
	// SELECT * FROM tblBusanTheme WHERE uc_seq = ?
	public BusanThemeBean getBusanThemeDetail(int ucSeq) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BusanThemeBean bean = null;
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM tblBusanTheme WHERE uc_seq = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ucSeq);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean = new BusanThemeBean();
				bean.setUcSeq(rs.getInt("uc_seq"));
                bean.setMainTitle(rs.getString("main_title"));
                bean.setGugunNm(rs.getString("gugun_nm"));
                bean.setCate2Nm(rs.getString("cate2_nm"));
                bean.setPlace(rs.getString("place"));
                bean.setMainImgThumb(rs.getString("main_img_thumb"));
                bean.setSubtitle(rs.getString("subtitle")); 
                bean.setAddr1(rs.getString("addr1"));
                bean.setHomepageUrl(rs.getString("homepage_url"));
                bean.setTrfcInfo(rs.getString("trfc_info"));
                bean.setMainImgNormal(rs.getString("main_img_normal")); // 상세 이미지
                bean.setItemcntnts(rs.getString("itemcntnts")); // 상세 설명
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
}
