package jspproject;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BgmMgr {
	private DBConnectionMgr pool;
	//세이브 폴더 pull 받을 시 자기 폴더에 맞게 주소 변경할 것
	public static final String  SAVEFOLDER = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/img";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 5*1024*1024;
	
	public BgmMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//배경음악 리스트
	public Vector<BgmBean> getBgmList(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BgmBean> vlist = new Vector<BgmBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM bgm WHERE user_id = ? ORDER BY bgm_id DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BgmBean bean = new BgmBean();
				bean.setBgm_id(rs.getInt("bgm_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setBgm_name(rs.getString("bgm_name"));
				bean.setBgm_cnt(rs.getString("bgm_cnt"));
				bean.setBgm_music(rs.getString("bgm_music"));
				bean.setBgm_onoff(rs.getInt("bgm_onoff"));
				bean.setBgm_image(rs.getString("bgm_image"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//배경음악 추가
	public boolean insertBgm(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		MultipartRequest multi = null;
		
		String imagePath = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/img";
		String musicPath = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/music";
		int maxSize = 100*1024*1024; //100MB
		
		try {
			multi = new MultipartRequest(req, imagePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
			String user_id = multi.getParameter("user_id");
			String bgm_name = multi.getParameter("bgm_name");
			String bgm_cnt = multi.getParameter("bgm_cnt");
			int bgm_onoff = (multi.getParameter("bgm_onoff") != null) ? 1 : 0;
			//이미지 파일 명
			String bgm_image = multi.getFilesystemName("bgm_image");
			//음악 파일 처리(수동 복사)
			String bgm_music = null;
			File musicFile = multi.getFile("bgm_music");
			if(musicFile != null) {
				bgm_music = musicFile.getName();
				File dest = new File(musicPath + "/" + bgm_music);
				Files.copy(musicFile.toPath(), dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
			}
			
			con = pool.getConnection();
			sql = "INSERT INTO bgm VALUES (null, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, bgm_name);
			pstmt.setString(3, bgm_cnt);
			pstmt.setString(4, bgm_music);
			pstmt.setInt(5, bgm_onoff);
			pstmt.setString(6, bgm_image);
			pstmt.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//배경음악 수정(음악, 사진, 설명만 변경)
	public boolean updateBgm(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		MultipartRequest multi = null;
		
		String imagePath = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/img";
		String musicPath = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/music";
		int maxSize = 100*1024*1024;
		
		try {
			multi = new MultipartRequest(req, imagePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
			
			int bgm_id = Integer.parseInt(multi.getParameter("bgm_id"));
			String bgm_cnt = multi.getParameter("bgm_cnt");
			
			String original_music = multi.getParameter("original_music");
			String original_image = multi.getParameter("original_image");
			
			String bgm_music = multi.getFilesystemName("bgm_music");
			if(bgm_music == null) {
				bgm_music = original_music;
			}else {
				File musicFile = multi.getFile("bgm_music");
				File dest = new File(musicPath + "/" + bgm_music);
				Files.copy(musicFile.toPath(), dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
			}
			
			String bgm_image = multi.getFilesystemName("bgm_image");
			if(bgm_image == null) {
				bgm_image = original_image;
			}
			
			//DB 업데이트
			con = pool.getConnection();
			sql = "UPDATE bgm SET bgm_cnt = ?, bgm_music = ?, bgm_image = ? WHERE bgm_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bgm_cnt);
			pstmt.setString(2, bgm_music);
			pstmt.setString(3, bgm_image);
			pstmt.setInt(4, bgm_id);
			pstmt.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public void deleteBgm(int bgm_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM bgm WHERE bgm_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bgm_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
}
