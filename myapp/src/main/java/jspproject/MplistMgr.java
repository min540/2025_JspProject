
package jspproject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import java.io.File;

public class MplistMgr {
    private DBConnectionMgr pool;
    public static final String SAVEFOLDER = "C:/Users/dita_810/git/2025_JspProject/myapp/src/main/webapp/jspproject/img";
    public static final String ENCTYPE = "UTF-8";
    public static int MAXSIZE = 10 * 1024 * 1024;

    public MplistMgr() {
        pool = DBConnectionMgr.getInstance();
    }

    // mplist 리스트 가져오기
    public Vector<MplistBean> getMplist(String user_id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Vector<MplistBean> vlist = new Vector<>();
        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM mplist WHERE user_id = ? ORDER BY mplist_id DESC";
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

    // mplist 추가
    public boolean insertMplist(HttpServletRequest req) {
        Connection con = null;
        PreparedStatement pstmt = null;
        MultipartRequest multi = null;
        try {
            multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
            String mplist_name = multi.getParameter("mplist_name");
            String user_id = multi.getParameter("user_id");
            String mplist_cnt = multi.getParameter("mplist_cnt");
            String mplist_img = multi.getFilesystemName("mplist_img");

            con = pool.getConnection();
            String sql = "INSERT INTO mplist (mplist_name, user_id, mplist_cnt, mplist_img) VALUES (?, ?, ?, ?)";
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
        MultipartRequest multi = null;
        try {
            multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
            int mplist_id = Integer.parseInt(multi.getParameter("mplist_id"));
            String mplist_name = multi.getParameter("mplist_name");
            String mplist_cnt = multi.getParameter("mplist_cnt");
            String original_img = multi.getParameter("original_img");
            String mplist_img = multi.getFilesystemName("mplist_img");
            if (mplist_img == null) {
                mplist_img = original_img;
            }

            con = pool.getConnection();
            String sql = "UPDATE mplist SET mplist_name = ?, mplist_cnt = ?, mplist_img = ? WHERE mplist_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, mplist_name);
            pstmt.setString(2, mplist_cnt);
            pstmt.setString(3, mplist_img);
            pstmt.setInt(4, mplist_id);
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
        try {
            con = pool.getConnection();
            String sql = "DELETE FROM mplist WHERE mplist_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, mplist_id);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
    }

    // mplist 검색
    public Vector<MplistBean> searchMplist(int mplist_id, String mplist_name) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Vector<MplistBean> vlist = new Vector<>();
        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM mplist WHERE mplist_id = ? AND mplist_name LIKE ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, mplist_id);
            pstmt.setString(2, "%" + mplist_name + "%");
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

    // mplist 이름 순 정렬
    public Vector<MplistBean> sortMplist() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Vector<MplistBean> vlist = new Vector<>();
        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM mplist ORDER BY mplist_name";
            pstmt = con.prepareStatement(sql);
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
}
