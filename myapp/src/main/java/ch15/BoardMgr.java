package ch15;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = 
			"C:/Jsp/myapp/src/main/webapp/ch15/fileupload/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*50; //50mb
	
	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// Borad Insert
	// 파일 업로드 기능 HttpServletRequest
	public void insertBoard(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()) {
				dir.mkdirs(); // 상위 폴더가 없어도 생성
				// dir.mkdir();  <- 상위 폴더가 없으면 생성 안 됨
			}
			MultipartRequest multi = 
					new MultipartRequest(req,  SAVEFOLDER, MAXSIZE, ENCODING, 
							new DefaultFileRenamePolicy());
			String filename = null;
			int filesize = 0;
			// 파일 업로드가 되었다면
			if(multi.getFilesystemName("filename")!=null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			String content = multi.getParameter("content");
			// HTML vs TEXT
			String contentType = multi.getParameter("contentType");
			if(contentType.equals("TEXT")) {
				// <h1> -> &ltjh1>
				content = MUtil.replace(content, "<", "&lt;");
			}
			int ref = getMaxNum() + 1; // 답변의 정렬을 위한 기능
			con = pool.getConnection();
			sql = "insert tblBoard(name,content,subject,ref,pos,depth,";
			sql += "regdate,pass,count,ip,filename,filesize)";
			sql += "values(?, ?, ?, ?, 0, 0, now(), ?, 0, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setString(2,  content);
			pstmt.setString(3, multi.getParameter("subject"));
			pstmt.setInt(4, ref);
			pstmt.setString(5, multi.getParameter("pass"));
			pstmt.setString(6, multi.getParameter("ip"));
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// Board Max Num
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum = 0;
		try {
			con = pool.getConnection();
			sql = "select max(num) from tblBoard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) maxNum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
	
	
	// Board List
	public Vector<BoardBean> getBoardList(String keyField, String keyWord,
			int start, int cnt){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) {
				sql = "select * from tblBoard "
						+ "order by ref desc, pos limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			} else {
				sql = "select * from tblBoard "
						+ "where " + keyField + " like ? "
						+ "order by ref desc, pos limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+ keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
				
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				bean.setFilename(rs.getString("filename"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	// Board Total Count : 총 게시물 수
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) {
				// 검색이 아님
				sql = "select count(*) from tblBoard";
				pstmt = con.prepareStatement(sql);
			} else {
				sql = "select count(*) from tblBoard "
						+ "where " + keyField + " like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+ keyWord + "%");
			}
			rs = pstmt.executeQuery();
			if(rs.next()) totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	// Board Read 13개
	public BoardBean getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BoardBean bean = new BoardBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblBoard where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setPass(rs.getString("pass"));
				bean.setIp(rs.getString("ip"));
				bean.setCount(rs.getInt("count"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	
	// Count Up
	// update tblBoard set count=count+1 where num = ?
	public void upCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblBoard set count=count+1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	// Board Delete
	public void deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			// 게시글 삭제 전에 파일 먼저 삭제
			BoardBean bean = getBoard(num);
			String filename = bean.getFilename();
			if(filename != null && !filename.equals("")) {
				File f = new File(SAVEFOLDER+filename);
				if(f.exists())
					f.delete(); // 파일 삭제
			}
			
			con = pool.getConnection();
			sql = "delete from tblBoard where num = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	// Board Update
	public void updateBoard(MultipartRequest multi) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    try {
	        con = pool.getConnection();
	        int num = Integer.parseInt(multi.getParameter("num"));
	        String name = multi.getParameter("name");
	        String subject = multi.getParameter("subject");
	        String content = multi.getParameter("content");
	        String filename = multi.getFilesystemName("filename");

	        if (filename != null && !filename.equals("")) {
	            // 파일 업로드 수정 : 기존 파일을 삭제
	            BoardBean bean = getBoard(num);
	            String dbFile = bean.getFilename();
	            if (dbFile != null && !dbFile.equals("")) {
	                // 기존에 업로드 파일이 있다면
	                File f = new File(SAVEFOLDER + dbFile);
	                if (f.exists()) {
	                    f.delete();
	                }
	            }
	            int filesize = (int) multi.getFile("filename").length();

	            // 파일이 업로드된 경우, 파일 이름과 파일 크기를 함께 업데이트
	            sql = "update tblBoard set name = ?, subject = ?, content = ?, filename = ?, filesize = ? where num = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, name);
	            pstmt.setString(2, subject);
	            pstmt.setString(3, content);
	            pstmt.setString(4, filename);
	            pstmt.setInt(5, filesize);
	            pstmt.setInt(6, num);
	        } else {
	            // 파일 업로드가 아닌 경우
	            sql = "update tblBoard set name = ?, subject = ?, content = ? where num = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, name);
	            pstmt.setString(2, subject);
	            pstmt.setString(3, content);
	            pstmt.setInt(4, num);  // 여기서 인덱스를 4로 수정
	        }

	        pstmt.executeUpdate();  // 쿼리 실행

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}

	
	
	
	// Board Reply
	public void replyBoard(BoardBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblBoard(name,content,subject,ref,pos,depth,regdate,"
					+"pass,count,ip)values(?, ?, ?, ?, ?, ?, now(), ?, 0, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getContent());
			pstmt.setString(3, bean.getSubject());
			////////////////////////////////////
			pstmt.setInt(4, bean.getRef()); //원글과 동일한 ref (그룹)
			pstmt.setInt(5, bean.getPos()+1); //원글 pos+1
			pstmt.setInt(6, bean.getDepth()+1); //원글 depth+1
			////////////////////////////////////
			pstmt.setString(7, bean.getPass());
			pstmt.setString(8, bean.getIp());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// Board Reply Up : 답변글 위치값 수정 (답변하고자 하는 원글 밑에 있는 게시물 1씩 증가)
	public void replyUpBoard(int ref, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblBoard set pos = pos + 1 where ref = ? and pos > ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, pos);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	// 게시물 1000개 입력
	public void post1000(){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblBoard(name,content,subject,ref,pos,depth,regdate,pass,count,ip,filename,filesize)";
			sql+="values('aaa', 'bbb', 'ccc', 0, 0, 0, now(), '1234',0, '127.0.0.1', null, 0);";
			pstmt = con.prepareStatement(sql);
			for (int i = 0; i < 1000; i++) {
					pstmt.addBatch(); // 배치에 추가
				if (i % 100 == 0) { // 100개마다 실행하여 메모리 사용 최적화
					pstmt.executeBatch();
					pstmt.clearBatch();
				}
			}
			 pstmt.executeBatch(); // 남은 데이터 실행
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public static void main(String[] args) {
		// BoardMgr mgr = new BoardMgr();
		// mgr.post1000();
		// System.out.println("End~~~~~~~~~~~~~~~");
	}

}
