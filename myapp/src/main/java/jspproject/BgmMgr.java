
package jspproject;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BgmMgr {
    private DBConnectionMgr pool;
    public static final String SAVEFOLDER = "C:/Users/dita_806/git/2025_JspProject_dtada11/myapp/src/main/webapp/jspproject/img";
    public static final String ENCTYPE = "UTF-8";
    public static int MAXSIZE = 10 * 1024 * 1024;

    public BgmMgr() {
        pool = DBConnectionMgr.getInstance();
    }

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
                vlist.add(bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return vlist;
    }

    public Vector<BgmBean> searchBgm(int bgm_id, String bgm_name) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        Vector<BgmBean> vlist = new Vector<BgmBean>();
        try {
            con = pool.getConnection();
            sql = "SELECT * FROM bgm WHERE bgm_id = ? AND bgm_name LIKE ?";
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
                vlist.add(bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return vlist;
    }
    
    // 검색용이 아닌 재생목록 안에 있는 음악 정보 받아오는 거
    public Vector<BgmBean> searchMplistBgm(int bgm_id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        Vector<BgmBean> vlist = new Vector<BgmBean>();
        try {
            con = pool.getConnection();
            sql = "SELECT * FROM bgm WHERE bgm_id = ?";
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
                vlist.add(bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return vlist;
    }

    public Vector<BgmBean> sortBgm() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        Vector<BgmBean> vlist = new Vector<BgmBean>();
        try {
            con = pool.getConnection();
            sql = "SELECT * FROM bgm ORDER BY bgm_name";
            pstmt = con.prepareStatement(sql);
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
                vlist.add(bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return vlist;
    }

    public int insertSimpleBgm(BgmBean bean) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int insertedId = -1;
        String sql = "INSERT INTO bgm (user_id, bgm_name, bgm_music, bgm_cnt, bgm_onoff, bgm_image) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, bean.getUser_id());
            pstmt.setString(2, bean.getBgm_name());
            pstmt.setString(3, bean.getBgm_music());
            pstmt.setString(4, bean.getBgm_cnt());
            pstmt.setInt(5, bean.getBgm_onoff());
            pstmt.setString(6, bean.getBgm_image());
            pstmt.executeUpdate();

            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                insertedId = rs.getInt(1);
                bean.setBgm_id(insertedId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return insertedId;
    }


    public boolean insertBgm(HttpServletRequest req) {
        Connection con = null;
        PreparedStatement pstmt = null;
        MultipartRequest multi = null;

        String imagePath = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/musicImg";
        String musicPath = "C:/Users/dita_810/git/2025_JspProject_Jangton/myapp/src/main/webapp/jspproject/music";
        int maxSize = 10 * 1024 * 1024;

        try {
            multi = new MultipartRequest(req, imagePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());

            String user_id = multi.getParameter("user_id");
            String bgm_name = multi.getParameter("bgm_name");
            String bgm_cnt = multi.getParameter("bgm_cnt");
            int bgm_onoff = 0;
            String bgm_image = multi.getFilesystemName("image");

            String bgm_music = null;
            File musicFile = multi.getFile("music");
            if (musicFile != null) {
                bgm_music = musicFile.getName();
                File origin = new File(imagePath + "/" + bgm_music);
                File dest = new File(musicPath + "/" + bgm_music);
                Files.copy(origin.toPath(), dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
                if (origin.exists()) origin.delete();
            }

            con = pool.getConnection();
            String sql = "INSERT INTO bgm VALUES (null, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, user_id);
            pstmt.setString(2, bgm_name);
            pstmt.setString(3, bgm_music);
            pstmt.setString(4, bgm_cnt);
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

    public boolean updateBgmInfo(int bgm_id, String bgm_name, String bgm_cnt) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE bgm SET bgm_name = ?, bgm_cnt = ? WHERE bgm_id = ?";

        try {
            conn = DBConnectionMgr.getInstance().getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, bgm_name);
            pstmt.setString(2, bgm_cnt);
            pstmt.setInt(3, bgm_id);
            int rows = pstmt.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnectionMgr.getInstance().freeConnection(conn, pstmt);
        }
        return result;
    }

    public void deleteBgm(int bgm_id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            con = pool.getConnection();
            String sql = "DELETE FROM bgm WHERE bgm_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, bgm_id);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
    }

    public void updateBgmOnoff(int bgm_id, int bgm_onoff) {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            con = pool.getConnection();
            String sql = "UPDATE bgm SET bgm_onoff = ? WHERE bgm_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, bgm_onoff);
            pstmt.setInt(2, bgm_id);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
    }
    
    public boolean updateBgmImage(int bgm_id, String imageName) {
    	Connection con = null;
        PreparedStatement pstmt = null;
        boolean result = false;
        try {
        	con = pool.getConnection();
            String sql = "UPDATE bgm SET bgm_image = ? WHERE bgm_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, imageName);
            pstmt.setInt(2, bgm_id);
            result = pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	pool.freeConnection(con, pstmt);
        }
        return result;
    }
    
    public boolean updateBgmOnOff(int bgm_id, int bgm_onoff) {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean result = false;

        try {
            con = pool.getConnection();
            String sql = "UPDATE bgm SET bgm_onoff = ? WHERE bgm_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, bgm_onoff);
            pstmt.setInt(2, bgm_id);
            result = pstmt.executeUpdate() > 0; // ✅ 성공 여부 확인
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }

        return result;
    }
    
    public BgmBean getCurrentBgm(String user_id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BgmBean bean = null;

        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM bgm WHERE user_id = ? AND bgm_onoff = 1 LIMIT 1";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, user_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                bean = new BgmBean();
                bean.setBgm_id(rs.getInt("bgm_id"));
                bean.setUser_id(rs.getString("user_id"));
                bean.setBgm_name(rs.getString("bgm_name"));
                bean.setBgm_cnt(rs.getString("bgm_cnt"));
                bean.setBgm_music(rs.getString("bgm_music"));
                bean.setBgm_onoff(rs.getInt("bgm_onoff"));
                bean.setBgm_image(rs.getString("bgm_image"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }

        return bean;
    }
    
    // BgmMgr.java에 추가
    public void resetAllBgmOnOff() {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            con = pool.getConnection();
            String sql = "UPDATE bgm SET bgm_onoff = 0";
            pstmt = con.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
    }

}
