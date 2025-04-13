
package jspproject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class MplistMgrMgr {
    private DBConnectionMgr pool;

    public MplistMgrMgr() {
        pool = DBConnectionMgr.getInstance();
    }

    // 플레이리스트에 BGM 추가
    public boolean addBgmToMplist(int mplist_id, int bgm_id, String user_id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO mplistmgr (mplist_id, bgm_id, user_id) VALUES (?, ?, ?)";
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, mplist_id);
            pstmt.setInt(2, bgm_id);
            pstmt.setString(3, user_id);
            pstmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            pool.freeConnection(con, pstmt);
        }
    }
    
    // 특정 플레이리스트의 bgm의 음악 정보 받아오기 조회
    public Vector<MplistBgmView> getBgmsInMplist(int mplist_id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Vector<MplistBgmView> vlist = new Vector<>();

        String sql = "SELECT b.*, m.mplistmgr_id, m.mplist_id " +
                     "FROM mplistmgr m JOIN bgm b ON m.bgm_id = b.bgm_id " +
                     "WHERE m.mplist_id = ?";
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, mplist_id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                BgmBean b = new BgmBean();
                b.setBgm_id(rs.getInt("bgm_id"));
                b.setUser_id(rs.getString("user_id"));
                b.setBgm_name(rs.getString("bgm_name"));
                b.setBgm_cnt(rs.getString("bgm_cnt"));
                b.setBgm_music(rs.getString("bgm_music"));
                b.setBgm_onoff(rs.getInt("bgm_onoff"));
                b.setBgm_image(rs.getString("bgm_image"));

                MplistBgmView view = new MplistBgmView();
                view.setMplist_id(rs.getInt("mplist_id"));
                view.setMplistmgr_id(rs.getInt("mplistmgr_id"));
                view.setBgm(b);

                vlist.add(view);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return vlist;
    }

    

    // mplistmgr 항목 삭제
    public void deleteMplistMgr(int mplistmgr_id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM mplistmgr WHERE mplistmgr_id = ?";
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, mplistmgr_id);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
    }
    
    public MplistBgmView getViewByBgmId(int bgm_id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT m.mplistmgr_id, m.mplist_id, b.* " +
                     "FROM mplistmgr m " +
                     "JOIN bgm b ON m.bgm_id = b.bgm_id " +
                     "WHERE m.bgm_id = ? LIMIT 1";

        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, bgm_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                MplistBgmView view = new MplistBgmView();
                view.setMplistmgr_id(rs.getInt("mplistmgr_id"));
                view.setMplist_id(rs.getInt("mplist_id"));

                BgmBean bgm = new BgmBean();
                bgm.setBgm_id(rs.getInt("bgm_id"));
                bgm.setUser_id(rs.getString("user_id"));
                bgm.setBgm_name(rs.getString("bgm_name"));
                bgm.setBgm_cnt(rs.getString("bgm_cnt"));
                bgm.setBgm_music(rs.getString("bgm_music"));
                bgm.setBgm_onoff(rs.getInt("bgm_onoff"));
                bgm.setBgm_image(rs.getString("bgm_image"));

                view.setBgm(bgm);
                return view;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return null;
    }
}
