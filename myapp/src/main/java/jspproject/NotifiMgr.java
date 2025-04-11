package jspproject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

public class NotifiMgr {
	private DBConnectionMgr pool;
	public static final String  SAVEFOLDER = "C:/Users/dita_810/git/2025_JspProject/myapp/src/main/webapp/jspproject/img";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 5*1024*1024;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy/MM/dd");
	
	public NotifiMgr() {
	pool = DBConnectionMgr.getInstance();
	}
	
	//작업 목표 마감알림
	public void objEnd(String id, String edate) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		Vector<ObjBean> e_date = new Vector<ObjBean>();
		try {
			con = pool.getConnection();
			sql = "select obj_id, obj_edate from obj where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ObjBean bean = new ObjBean();
				bean.setObj_id(rs.getInt(1));
				bean.setObj_edate(SDF_DATE.format(rs.getDate(2)));
				e_date.add(bean);
			}
			
			if(!e_date.isEmpty()) {
			    for (ObjBean bean : e_date) {
			    	  /*==오늘날짜랑 같다라는 코드 if의 조건문*/
						/*
						 * bean.getObj_edate().equals(); bean.getObj_id()에 대한 sql문 쓰기
						 */
			        //bean의 첫번째는 obj_id, 두번째는 e_date가들어있다
			    	//e_date를 현재 날짜와 비교해서 만약 같으면
			    	//그 obj_id를 notifi 테이블에 insert
			    }
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	//
}
