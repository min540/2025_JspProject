package jspproject;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class TemaMgr {
	private DBConnectionMgr pool;
	public static final String  SAVEFOLDER = "C:/Users/dita_810/git/2025_JspProject/myapp/src/main/webapp/jspproject/img";
	public static final String ENCTYPE = "UTF-8";
	public static final String ENCODING = "UTF-8";
	public static int MAXSIZE = 5*1024*1024;
	
	public TemaMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 테마 업로드
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
				sql = "insert tema(upFile, size) values (?, ?)";
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
	//테마리스트
	public Vector<TemaBean> listTema(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TemaBean> vlist = new Vector<TemaBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tema order by tema_id desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TemaBean bean = new TemaBean();
				bean.setTema_id(rs.getInt("tema_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setTema_title(rs.getString("tema_title"));
				bean.setTema_bimg(rs.getString("tema_bimg"));
				bean.setTema_cnt(rs.getString("tema_cnt"));
				bean.setTema_dark(rs.getInt("tema_dark"));
				bean.setTema_onoff(rs.getInt("tema_onoff"));
				bean.setTema_img(rs.getString("tema_img"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//테마 선택
	public TemaBean selectTema(int tema_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		TemaBean bean = new TemaBean();
		try {
			con = pool.getConnection();
			sql = "select * from tema where tema_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, tema_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setTema_id(rs.getInt("tema_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setTema_title(rs.getString("tema_title"));
				bean.setTema_bimg(rs.getString("tema_bimg"));
				bean.setTema_cnt(rs.getString("tema_cnt"));
				bean.setTema_dark(rs.getInt("tema_dark"));
				bean.setTema_onoff(rs.getInt("tema_onoff"));
				bean.setTema_img(rs.getString("tema_img"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;	
	}
	// 테마수정
	public void updateTema(HttpServletRequest req) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    
	    try {
	        con = pool.getConnection();
	        
	        // 디렉토리 확인 및 생성 추가
	        File dir = new File(SAVEFOLDER);
	        if (!dir.exists()) {
	            dir.mkdirs(); // 디렉토리가 없으면 생성
	        }
	        
	        // MultipartRequest를 사용하여 파일 업로드 처리
	        // 경로를 SAVEFOLDER 상수로 변경
	        MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, 
	                            MAXSIZE, ENCODING, new DefaultFileRenamePolicy());
	        
	        int tema_id = Integer.parseInt(multi.getParameter("tema_id"));
	        String tema_title = multi.getParameter("tema_title");
	        String tema_cnt = multi.getParameter("tema_cnt");
	        int tema_dark = 0;
	        int tema_onoff = 1;
	        
	        // 다크모드와 활성화 상태 파라미터 처리
	        try {
	            tema_dark = Integer.parseInt(multi.getParameter("tema_dark"));
	        } catch (Exception e) {}
	        
	        try {
	            tema_onoff = Integer.parseInt(multi.getParameter("tema_onoff"));
	        } catch (Exception e) {}
	        
	        // 업로드된 파일 객체
	        File uploadedFile = multi.getFile("tema_img");
	        
	        // 이미지를 업로드했는지 확인
	        if(uploadedFile != null) {
	            // 이미지 업로드된 경우 - 제목, 설명, 이미지 모두 업데이트
	            String tema_img = multi.getFilesystemName("tema_img");
	            
	            sql = "update tema set tema_title=?, tema_cnt=?, tema_img=?, tema_dark=?, tema_onoff=? where tema_id=?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, tema_title);
	            pstmt.setString(2, tema_cnt);
	            pstmt.setString(3, tema_img);
	            pstmt.setInt(4, tema_dark);
	            pstmt.setInt(5, tema_onoff);
	            pstmt.setInt(6, tema_id);
	            
	        } else {
	            // 이미지가 업로드되지 않은 경우 - 제목, 설명만 업데이트
	            sql = "update tema set tema_title=?, tema_cnt=?, tema_dark=?, tema_onoff=? where tema_id=?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, tema_title);
	            pstmt.setString(2, tema_cnt);
	            pstmt.setInt(3, tema_dark);
	            pstmt.setInt(4, tema_onoff);
	            pstmt.setInt(5, tema_id);
	        }
	        
	        pstmt.executeUpdate();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}
	
	//테마삭제
	public void deleteTema(int tema_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tema where tema_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, tema_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	//테마 글자순으로 정렬
	public Vector<TemaBean> turnTema(int tema_id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TemaBean> vlist = new Vector<TemaBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tema ORDER BY tema_title";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, tema_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TemaBean bean = new TemaBean();
				bean.setTema_id(rs.getInt("tema_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setTema_title(rs.getString("tema_title"));
				bean.setTema_bimg(rs.getString("tema_bimg"));
				bean.setTema_cnt(rs.getString("team_cnt"));
				bean.setTema_dark(rs.getInt("tema_dark"));
				bean.setTema_onoff(rs.getInt("tema_onoff"));
				bean.setTema_img(rs.getString("tema_img"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//테마 배경제목 검색
	public Vector<TemaBean> searchTema(int tema_id, String title){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TemaBean> vlist = new Vector<TemaBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tema where tema_id=? and tema_tile like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, tema_id);
			pstmt.setString(2, "%"+ title +"%" );
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TemaBean bean = new TemaBean();
				bean.setTema_id(rs.getInt("tema_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setTema_title(rs.getString("tema_title"));
				bean.setTema_bimg(rs.getString("tema_bimg"));
				bean.setTema_cnt(rs.getString("team_cnt"));
				bean.setTema_dark(rs.getInt("tema_dark"));
				bean.setTema_onoff(rs.getInt("tema_onoff"));
				bean.setTema_img(rs.getString("tema_img"));
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
