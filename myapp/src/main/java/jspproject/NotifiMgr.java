package jspproject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;

public class NotifiMgr {
	private DBConnectionMgr pool;
	public static final String  SAVEFOLDER = "C:/Users/dita_806/git/2025_JspProject_dtada11/myapp/src/main/webapp/jspproject/Img";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 5*1024*1024;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy-MM-dd");
	
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
	        sql = "select obj_id, obj_edate from obj where user_id = ? and obj_check = 0";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, id);
	        rs = pstmt.executeQuery();
			/* 이게 원본
			 * while(rs.next()) { ObjBean bean = new ObjBean();
			 * bean.setObj_id(rs.getInt(1));
			 * bean.setObj_edate(SDF_DATE.format(rs.getDate(2))); e_date.add(bean); }
			 * 
			 */ 
	        
	        while (rs.next()) {
	            ObjBean bean = new ObjBean();
	            bean.setObj_id(rs.getInt(1));
	            java.sql.Date sqlDate = rs.getDate(2);
	            if (sqlDate != null) {
	                bean.setObj_edate(SDF_DATE.format(sqlDate));
	            } else {
	                bean.setObj_edate("");  // null일 경우 빈 문자열이나 "미정" 등의 기본값을 할당
	            }
	            e_date.add(bean);
	        }
        
	        if(!e_date.isEmpty()) {
	            // 현재 날짜 가져오기
	            String currentDate = SDF_DATE.format(new java.util.Date());
	            
	            // 어제 날짜 계산하기
	            java.util.Calendar calendar = java.util.Calendar.getInstance();
	            calendar.add(java.util.Calendar.DATE, -1);
	            String yesterdayDate = SDF_DATE.format(calendar.getTime());
	            
	            for (ObjBean bean : e_date) {
	                // 마감일과 현재 날짜 비교
	                String beanEdate = bean.getObj_edate();
	                int objId = bean.getObj_id();
	                
	                // 마감 당일인 경우
	                if (beanEdate.equals(currentDate)) {
	                    // notifi 테이블에 마감 당일 알림 추가
	                    sql = "INSERT INTO notifi (user_id, notifi_title, notifi_cnt, notifi_regdate, notifi_check, obj_id) VALUES (?, ?, ?, NOW(), 0, ?)";
	                    pstmt = con.prepareStatement(sql);
	                    pstmt.setString(1, id);
	                    pstmt.setString(2, "작업 목표 마감일 알림");
	                    pstmt.setString(3, "작업 목표의 마감일이 오늘입니다.");
	                    pstmt.setInt(4, objId);
	                    pstmt.executeUpdate();
	                } 
	                // 마감일 다음 날인 경우
	                else if (beanEdate.equals(yesterdayDate)) {
	                    // notifi 테이블에 마감 다음날 알림 추가
	                    sql = "INSERT INTO notifi (user_id, notifi_title, notifi_cnt, notifi_regdate, notifi_check, obj_id) VALUES (?, ?, ?, NOW(), 0, ?)";
	                    pstmt = con.prepareStatement(sql);
	                    pstmt.setString(1, id);
	                    pstmt.setString(2, "작업 목표 마감일 지남 알림");
	                    pstmt.setString(3, "작업 목표의 마감일이 지났습니다.");
	                    pstmt.setInt(4, objId);
	                    pstmt.executeUpdate();
	                }
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	}
}
