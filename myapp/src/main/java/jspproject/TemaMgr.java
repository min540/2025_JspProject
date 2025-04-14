package jspproject;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class TemaMgr {
	private DBConnectionMgr pool;
	public static final String  SAVEFOLDER = "C:/Users/dita_810/git/2025_JspProject/myapp/src/main/webapp/jspproject/backgroundImg";
	public static final String ENCTYPE = "UTF-8";
	public static final String ENCODING = "UTF-8";
	public static int MAXSIZE = 5*1024*1024;
	
	public TemaMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//테마업로드
	public Map<String, String> uploadFile(HttpServletRequest req, String user_id) {
	    Map<String, String> resultMap = new HashMap<>();
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;

	    try {
	        MultipartRequest multi = new MultipartRequest(
	            req,
	            SAVEFOLDER,
	            MAXSIZE,
	            ENCODING,
	            new DefaultFileRenamePolicy()
	        );

	        String tema_title = multi.getParameter("tema_title");
	        String tema_cnt = multi.getParameter("tema_cnt");
	        String tema_img = multi.getFilesystemName("tema_img");
	        
	        if (tema_img != null) {
	            tema_img = tema_img.replaceAll("\\s+", "_")
	                               .replaceAll("[^a-zA-Z0-9._-]", "")
	                               .toLowerCase();
	        }
	        
	        // 2. 실제 저장된 원본 파일
            File uploadedFile = multi.getFile("tema_img");

            // 3. 정제된 이름으로 저장할 경로
            File renamedFile = new File(uploadedFile.getParent(), tema_img);
            
         // 4. 이름 변경
            if (!uploadedFile.getName().equals(tema_img)) {
                boolean renamed = uploadedFile.renameTo(renamedFile);
                System.out.println("✅ 파일명 변경됨: " + renamed);
            } else {
                System.out.println("⚠️ 이미 동일 이름입니다. rename 생략");
            }
        
	        int tema_dark = 0;
	        int tema_onoff = 0;

	        con = pool.getConnection();
	        sql = "INSERT INTO tema(user_id, tema_title, tema_cnt, tema_img, tema_dark, tema_onoff) VALUES (?, ?, ?, ?, ?, ?)";
	        pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	        pstmt.setString(1, user_id);  // ← 여기!
	        pstmt.setString(2, tema_title);
	        pstmt.setString(3, tema_cnt);
	        pstmt.setString(4, tema_img);
	        pstmt.setInt(5, tema_dark);
	        pstmt.setInt(6, tema_onoff);
	        pstmt.executeUpdate();

	        resultMap.put("tema_title", tema_title);
	        resultMap.put("tema_cnt", tema_cnt);
	        resultMap.put("tema_img", tema_img);

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }

	    return resultMap;
	}
	//파일 집어넣기
	public void insertTema(TemaBean tema) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    try {
	        con = pool.getConnection();
	        String sql = "INSERT INTO tema(user_id, tema_title, tema_bimg, tema_cnt, tema_dark, tema_onoff, tema_img) "
	                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, tema.getUser_id());
	        pstmt.setString(2, tema.getTema_title());
	        pstmt.setString(3, tema.getTema_bimg());
	        pstmt.setString(4, tema.getTema_cnt());
	        pstmt.setInt(5, tema.getTema_dark());
	        pstmt.setInt(6, 0); // ✅ 업로드된 이미지는 적용 상태가 아니므로 항상 0
	        pstmt.setString(7, tema.getTema_img());
	        pstmt.executeUpdate();
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, null);
	    }
	}

	//테마리스트
	public Vector<TemaBean> listTema(String userId) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    Vector<TemaBean> vlist = new Vector<TemaBean>();

	    try {
	        con = pool.getConnection();
	        sql = "SELECT * FROM tema WHERE user_id = ? ORDER BY tema_id DESC";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, userId);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
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
	        int tema_onoff = 0;
	        
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
	
	// 모든 테마 off
	public void setAllTemaOff(String user_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = "UPDATE tema SET tema_onoff = 0 WHERE user_id = ?";

	    try {
	        con = pool.getConnection();
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}

	// 선택한 테마만 on
	public boolean setTemaOn(int tema_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = "UPDATE tema SET tema_onoff = 1 WHERE tema_id = ?";

	    try {
	        con = pool.getConnection();
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, tema_id);
	        int updated = pstmt.executeUpdate();
	        return updated > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}

	// 모든 테마의 onoff 값을 0으로 초기화 (기본 배경 적용용)
	public void resetAllTemaOnOff(String user_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = "UPDATE tema SET tema_onoff = 0 WHERE user_id = ?";

	    try {
	        con = pool.getConnection();
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}

	
	public TemaBean getOnTema(String user_id) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    TemaBean bean = new TemaBean();
	    try {
	        con = pool.getConnection();
	        String sql = "SELECT * FROM tema WHERE user_id = ? AND tema_onoff = 1 LIMIT 1";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
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

	public void insertDefaultTema(TemaBean tema) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    try {
	    	con = pool.getConnection();
	        String sql = "INSERT INTO tema(user_id, tema_title, tema_bimg, tema_cnt, tema_dark, tema_onoff, tema_img) "
	                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, tema.getUser_id());
	        pstmt.setString(2, tema.getTema_title());
	        pstmt.setString(3, tema.getTema_bimg());
	        pstmt.setString(4, tema.getTema_cnt());
	        pstmt.setInt(5, tema.getTema_dark());
	        pstmt.setInt(6, tema.getTema_onoff());
	        pstmt.setString(7, tema.getTema_img());
	        pstmt.executeUpdate();
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	    	pool.freeConnection(con, pstmt, null);
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
			sql = "select * from tema where tema_id=? and tema_title like ?";
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
}
