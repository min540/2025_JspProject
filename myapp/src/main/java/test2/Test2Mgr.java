package test2;

import java.sql.Connection;
import java.sql.PreparedStatement;

import guestbook.DBConnectionMgr;

public class Test2Mgr {
	
	private DBConnectionMgr pool;
	
	public Test2Mgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 회원정보 수정 메서드
    public void updateStudentInfo(StudentBean student) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE student SET stName = ?, stTel = ?, stPw = ?, dmId = ? WHERE stId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, student.getStName());
            pstmt.setString(2, student.getStTel());
            pstmt.setString(3, student.getStPw());
            pstmt.setInt(4, student.getDmId());
            pstmt.setInt(5, student.getStId());

            int result = pstmt.executeUpdate();
            if (result > 0) {
                System.out.println("회원정보가 성공적으로 업데이트되었습니다.");
            } else {
                System.out.println("회원정보 업데이트 실패.");
            }
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
    	
    }
	
}
