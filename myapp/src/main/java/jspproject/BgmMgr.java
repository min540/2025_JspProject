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
	// 세이브 폴더 pull 받을 시 자기 폴더에 맞게 주소 변경할 것
	public static final String SAVEFOLDER = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/img";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 10 * 1024 * 1024;

	public BgmMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	// 배경음악 리스트
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
			while (rs.next()) {
				BgmBean bean = new BgmBean();
				bean.setBgm_id(rs.getInt("bgm_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setBgm_name(rs.getString("bgm_name"));
				bean.setBgm_cnt(rs.getString("bgm_cnt"));
				bean.setBgm_music(rs.getString("bgm_music"));
				bean.setBgm_onoff(rs.getInt("bgm_onoff"));
				bean.setBgm_image(rs.getString("bgm_image"));
				bean.setMplist_id(rs.getInt("mplist_id"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// bgm 이름 검색
	public Vector<BgmBean> searchBgm(int bgm_id, String bgm_name) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BgmBean> vlist = new Vector<BgmBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM bgm where bgm_id = ? and bgm_name like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bgm_id);
			pstmt.setString(2, "%" + bgm_name + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BgmBean bean = new BgmBean();
				bean.setBgm_id(rs.getInt("bgm_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setBgm_name(rs.getString("bgm_name"));
				bean.setBgm_cnt(rs.getString("bgm_cnt"));
				bean.setBgm_music(rs.getString("bgm_music"));
				bean.setBgm_onoff(rs.getInt("bgm_onoff"));
				bean.setBgm_image(rs.getString("bgm_image"));
				bean.setMplist_id(rs.getInt("mplist_id"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// bgm 이름순으로 나열
	public Vector<BgmBean> sortBgm(int bgm_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BgmBean> vlist = new Vector<BgmBean>();
		try {
			con = pool.getConnection();
			sql = "select * from bgm order by bgm_name";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bgm_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BgmBean bean = new BgmBean();
				bean.setBgm_id(rs.getInt("bgm_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setBgm_name(rs.getString("bgm_name"));
				bean.setBgm_cnt(rs.getString("bgm_cnt"));
				bean.setBgm_music(rs.getString("bgm_music"));
				bean.setBgm_onoff(rs.getInt("bgm_onoff"));
				bean.setBgm_image(rs.getString("bgm_image"));
				bean.setMplist_id(rs.getInt("mplist_id"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 배경음악 추가
	public boolean insertBgm(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		MultipartRequest multi = null;

		String imagePath = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/img";
		String musicPath = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/music";
		int maxSize = 10 * 1024 * 1024; // 10MB

		try {
			multi = new MultipartRequest(req, imagePath, maxSize, ENCTYPE, new DefaultFileRenamePolicy());
			String user_id = multi.getParameter("user_id");
			String bgm_name = multi.getParameter("bgm_name");
			String bgm_cnt = multi.getParameter("bgm_cnt");
			int bgm_onoff = Integer.parseInt(multi.getParameter("bgm_onoff"));
			int mplist_id = Integer.parseInt(multi.getParameter("mplist_id"));
			// 이미지 파일 명
			String bgm_image = multi.getFilesystemName("image");
			// 음악 파일 처리(수동 복사)
			String bgm_music = null;
			File musicFile = multi.getFile("music");
			if (musicFile != null) {
				bgm_music = musicFile.getName();
				File dest = new File(musicPath + "/" + bgm_music);
				Files.copy(musicFile.toPath(), dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
			}
			con = pool.getConnection();
			sql = "INSERT INTO bgm VALUES (null, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, bgm_name);
			pstmt.setString(3, bgm_music);
			pstmt.setString(4, bgm_cnt);
			pstmt.setInt(5, bgm_onoff);
			pstmt.setString(6, bgm_image);
			pstmt.setInt(7, mplist_id);
			pstmt.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 배경음악 수정(음악, 사진, 설명만 변경)
	public boolean updateBgm(HttpServletRequest req) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    MultipartRequest multi = null;

	    String imagePath = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/img";
	    String musicPath = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/music";
	    int maxSize = 100 * 1024 * 1024;

	    try {
	        multi = new MultipartRequest(req, imagePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());

	        int bgm_id = Integer.parseInt(multi.getParameter("bgm_id"));
	        String bgm_cnt = multi.getParameter("bgm_cnt");
	        int mplist_id = Integer.parseInt(multi.getParameter("mplist_id")); // ✅ 추가

	        String original_music = multi.getParameter("original_music");
	        String original_image = multi.getParameter("original_image");

	        String bgm_music = multi.getFilesystemName("bgm_music");
	        if (bgm_music == null) {
	            bgm_music = original_music;
	        } else {
	            File musicFile = multi.getFile("bgm_music");
	            File dest = new File(musicPath + "/" + bgm_music);
	            Files.copy(musicFile.toPath(), dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
	        }

	        String bgm_image = multi.getFilesystemName("bgm_image");
	        if (bgm_image == null) {
	            bgm_image = original_image;
	        }

	        //DB 업데이트
	        con = pool.getConnection();
	        sql = "UPDATE bgm SET bgm_cnt = ?, bgm_music = ?, bgm_image = ?, mplist_id = ? WHERE bgm_id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, bgm_cnt);
	        pstmt.setString(2, bgm_music);
	        pstmt.setString(3, bgm_image);
	        pstmt.setInt(4, mplist_id);
	        pstmt.setInt(5, bgm_id);
	        pstmt.executeUpdate();
	        return true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}

	// 배경음악 삭제
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
	
	//bgm을 mplist에 넣기
	public boolean assignBgmToMplist(int bgm_id, int mplist_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    try {
	        con = pool.getConnection();
	        sql = "UPDATE bgm SET mplist_id = ? WHERE bgm_id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, mplist_id);
	        pstmt.setInt(2, bgm_id);
	        pstmt.executeUpdate();
	        return true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}

	// mplist 리스트 불러오기
	public Vector<MplistBean> getMplist(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MplistBean> vlist = new Vector<MplistBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM mplist WHERE user_id = ? ORDER BY mplist_id DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MplistBean bean = new MplistBean();
				bean.setMplist_id(rs.getInt("mplist_id"));
				bean.setMplist_name(rs.getString("mplist_name"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setMplist_cnt(rs.getString("mplist_cnt"));
				bean.setMplist_img(rs.getString("mplist_img"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	//mplist 검색
	public Vector<MplistBean> searchMplist(int mplist_id, String mplist_name) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MplistBean> vlist = new Vector<MplistBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM mplist where mplist_id = ? and mplist_name like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mplist_id);
			pstmt.setString(2, mplist_name);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MplistBean bean = new MplistBean();
				bean.setMplist_id(rs.getInt("mplist_id"));
				bean.setMplist_name(rs.getString("mplist_name"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setMplist_cnt(rs.getString("mplist_cnt"));
				bean.setMplist_img(rs.getString("mplist_img"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//mplist 이름 순 정렬
	public Vector<MplistBean> sortMplist(int mplist_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MplistBean> vlist = new Vector<MplistBean>();
		try {
			con = pool.getConnection();
			sql = "select * from mplist order by mplist_name";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mplist_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MplistBean bean = new MplistBean();
				bean.setMplist_id(rs.getInt("mplist_id"));
				bean.setMplist_name(rs.getString("mplist_name"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setMplist_cnt(rs.getString("mplist_cnt"));
				bean.setMplist_img(rs.getString("mplist_img"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// mplist 추가
	public boolean insertMplist(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		MultipartRequest multi = null;
		String imagePath = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/img";
		int maxSize = 10 * 1024 * 1024;

		try {
			System.out.println("insertMplist() 호출됨");

			multi = new MultipartRequest(req, imagePath, maxSize, ENCTYPE, new DefaultFileRenamePolicy());

			String mplist_name = multi.getParameter("mplist_name");
			String user_id = multi.getParameter("user_id");
			String mplist_cnt = multi.getParameter("mplist_cnt");
			String mplist_img = multi.getFilesystemName("mplist_img");

			System.out.println("mplist_name: " + mplist_name);
			System.out.println("user_id: " + user_id);
			System.out.println("mplist_cnt: " + mplist_cnt);
			System.out.println("mplist_img: " + mplist_img);

			con = pool.getConnection();
			sql = "INSERT INTO mplist (mplist_name, user_id, mplist_cnt, mplist_img) VALUES (?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mplist_name);
			pstmt.setString(2, user_id);
			pstmt.setString(3, mplist_cnt);
			pstmt.setString(4, mplist_img);
			pstmt.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// mplist 수정
	public void updateMplist(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		MultipartRequest multi = null;
		String mplist_img = null;
		try {
			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
			mplist_img = multi.getFilesystemName("mplist_img");
			con = pool.getConnection();
			if (mplist_img != null && !mplist_img.equals("")) {
				sql = "UPDATE mplist SET mplist_name = ?, mplist_cnt = ?, mplist_img = ? WHERE mplist_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("mplist_name"));
				pstmt.setString(2, multi.getParameter("mplist_cnt"));
				pstmt.setString(3, mplist_img);
				pstmt.setInt(4, Integer.parseInt(multi.getParameter("mplist_id")));
			} else {
				sql = "UPDATE mplist SET mplist_name = ?, mplist_cnt = ? WHERE mplist_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("mplist_name"));
				pstmt.setString(2, multi.getParameter("mplist_cnt"));
				pstmt.setInt(3, Integer.parseInt(multi.getParameter("mplist_id")));
			}
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// mplist 삭제
	public void deleteMplist(int mplist_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM mplist WHERE mplist_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mplist_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// mplistmgr 리스트
	public Vector<BgmBean> MplistMgrList(int mplist_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BgmBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "SELECT b.* FROM mplistmgr m " + "JOIN bgm b ON m.bgm_id = b.bgm_id " + "WHERE m.mplist_id = ? "
					+ "ORDER BY m.mplistmgr_id ASC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mplist_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BgmBean bean = new BgmBean();
				bean.setBgm_id(rs.getInt("bgm_id"));
				bean.setBgm_name(rs.getString("bgm_name"));
				bean.setBgm_music(rs.getString("bgm_music"));
				bean.setBgm_image(rs.getString("bgm_image"));
				bean.setBgm_cnt(rs.getString("bgm_cnt"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// mplistmgr 삭제
	public void deletemplistmgr(int mplistmgr_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM mplistmgr WHERE mplistmgr_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mplistmgr_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//mplistmgr 검색
	public Vector<MplistMgrBean> searchMplistMgr(int mplistmgr_id, String mplistmgr_name) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MplistMgrBean> vlist = new Vector<MplistMgrBean>();
		try {
			con = pool.getConnection();
			sql = "select * from mplistmgr where mplistmgr_id = ? and mplistmgr_name like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mplistmgr_id);
			pstmt.setString(2, "%" + mplistmgr_name + "%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MplistMgrBean bean = new MplistMgrBean();
				bean.setMplistmgr_id(rs.getInt("mplistmgr_id"));
				bean.setMplist_id(rs.getInt("mplistmgr_id"));
				bean.setBgm_id(rs.getInt("bgm_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setMplistmgr_name(rs.getString("mplistmgr_name"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//mplistmgr 이름 순 정렬
	public Vector<MplistMgrBean> sortMplistmgr(int mplistmgr_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MplistMgrBean> vlist = new Vector<MplistMgrBean>();
		try {
			con = pool.getConnection();
			sql = "select * from mplistmgr order by mplistmgr_name";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mplistmgr_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MplistMgrBean bean = new MplistMgrBean();
				bean.setMplistmgr_id(rs.getInt("mplistmgr_id"));
				bean.setMplist_id(rs.getInt("mplistmgr_id"));
				bean.setBgm_id(rs.getInt("bgm_id"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setMplistmgr_name(rs.getString("mplistmgr_name"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// 배경음악 재생 여부 토글
	public void updateBgmOnoff(int bgm_id, int onoff) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    try {
	        con = pool.getConnection();
	        sql = "UPDATE bgm SET bgm_onoff = ? WHERE bgm_id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, onoff);
	        pstmt.setInt(2, bgm_id);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}
	
}
