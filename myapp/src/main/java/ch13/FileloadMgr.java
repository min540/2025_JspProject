package ch13;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.Vector;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import javax.servlet.http.HttpServletRequest;

public class FileloadMgr {

	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/myapp/src/main/webapp/ch13/storage/";
	public static final String ENCODING = "UTF-8";
	final int MAXSIZE = 1024*1024*50; //50mb
	
	public FileloadMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// file upload
	public void uploadFile(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			// 파일 업로드 //////////////////
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER, 
														MAXSIZE, ENCODING,
														new DefaultFileRenamePolicy());	
			String upFile = multi.getFilesystemName("upFile");
			File f = multi.getFile("upFile");
			long size = f.length(); // 파일 크기
			// 테이블 저장 /////////////////
			con = pool.getConnection();
			sql = "insert tblFileLoad(upFile, size) values (?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, upFile);
			pstmt.setLong(2, size);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// file list
	public Vector<FileloadBean> listFile(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<FileloadBean> vlist = new Vector<FileloadBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblFileLoad";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FileloadBean bean = new FileloadBean();
				bean.setNum(rs.getInt(1));
				bean.setUpFile(rs.getString(2));
				bean.setSize(rs.getInt(3));
				vlist.addElement(bean);
				/*
				 * vlist.addElement(new FileloadBean( rs.getInt(1), rs.getString(2),
				 * rs.getInt(3)));
				 */
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// file delete : 파일 삭제, 레코드 삭제
	public void deleteFile(int num[]) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			// 파일 삭제 ///////
			for (int i = 0; i < num.length; i++) {
				String upFile = getFile(num[i]); // 파일명 리턴
				File f = new File(SAVEFOLDER+upFile);
				if(f.exists())
					f.delete(); // 파일 삭제
			}
			
			// 레코드 삭제 /////////
			con = pool.getConnection();
			sql = "delete from tblFileload where num = ?";
			pstmt = con.prepareStatement(sql);
			for (int i : num) {
				pstmt.setInt(1, i);
				pstmt.addBatch(); // 배치에 추가
			}
			pstmt.executeBatch(); // delete 명령어 한번에 실행
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// file name
	public String getFile(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String upFile = null;
		try {
			con = pool.getConnection();
			sql = "select upFile from tblFileload where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				upFile = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return upFile;
	}
	
}
