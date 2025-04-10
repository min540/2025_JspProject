
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

    // 특정 플레이리스트의 BGM 목록 조회
    public Vector<BgmBean> getBgmsInMplist(int mplist_id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Vector<BgmBean> vlist = new Vector<>();
        String sql = "SELECT b.* FROM mplistmgr m JOIN bgm b ON m.bgm_id = b.bgm_id WHERE m.mplist_id = ?";
        try {
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, mplist_id);
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
}
