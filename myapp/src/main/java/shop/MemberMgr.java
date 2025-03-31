package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import ch14.DBConnectionMgr;

public class MemberMgr {

	private DBConnectionMgr pool;

	public MemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	// 로그인 : 성공 -> true
	public int loginMember(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int mode = 0;
		// 0-id false, 1-id true pwd-false, 2-id&pwd true
		try {
			if (!checkId(id))
				return mode;
			con = pool.getConnection();
			sql = "select id, pwd from tblMember where id = ? and pwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if (rs.next())
				mode = 2;
			else
				mode = 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return mode;
	}

	// id 중복 체크 : 중복 -> true
	public boolean checkId(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from tblMember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	// 우편번호 및 주소 검색
	public Vector<ZipcodeBean> searchZipcode(String area3) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblZipcode where area3 like ?"; // '%강남대로%'
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + area3 + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vlist.addElement(new ZipcodeBean(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4)));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 회원가입
	public boolean insertMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblMember values (?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPwd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getGender());
			pstmt.setString(5, bean.getBirthday());
			pstmt.setString(6, bean.getEmail());
			pstmt.setString(7, bean.getZipcode());
			pstmt.setString(8, bean.getAddress());
			/////////////////////////////////////////
			String hobby[] = bean.getHobby(); // {"인터넷", "영화"}
			char hb[] = { '0', '0', '0', '0', '0' };
			if (hobby != null) {
				String lists[] = { "인터넷", "여행", "게임", "영화", "운동" };
				for (int i = 0; i < hobby.length; i++) {
					for (int j = 0; j < lists.length; j++) {
						if (hobby[i].equals(lists[j])) {
							hb[j] = '1';
							break;
						}
					}
				}
			}
			pstmt.setString(9, new String(hb)); // 10010
			/////////////////////////////////////////
			pstmt.setString(10, bean.getJob());
			if (pstmt.executeUpdate() == 1) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	// 회원정보 가져오기
	public MemberBean getMember(String id) {
		// hobby => 10101 => {"1","0","1","0","1"}
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblMember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setId(rs.getString("id"));
				bean.setPwd(rs.getString("pwd"));
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				bean.setBirthday(rs.getString("birthday"));
				bean.setEmail(rs.getString("email"));
				bean.setZipcode(rs.getString("zipcode"));
				bean.setAddress(rs.getString("address"));
				// hobby => 10101 => {"1","0","1","0","1"}
				// table에서 hobby을 가져옴.
				String hobby = rs.getString("hobby");
				// 빈즈에 저장할 배열을 선언 ->
				String hobbys[] = new String[5];
				for (int i = 0; i < hobbys.length; i++) {
					// hobbys[0] =
					hobbys[i] = hobby.substring(i, i + 1);
				}
				bean.setHobby(hobbys);
				bean.setJob(rs.getString("job"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	// 회원 수정
	// update tblMember set pwd=?, name=?, gender=?, birthday=?, email=?,
	// zipcode=?, address=?, hobby=?, job=? where id=?";
	public boolean updateMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblMember set pwd=?, name=?, gender=?, birthday=?, email=?,  zipcode=?, address=?, hobby=?, job=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getPwd());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getGender());
			pstmt.setString(4, bean.getBirthday());
			pstmt.setString(5, bean.getEmail());
			pstmt.setString(6, bean.getZipcode());
			pstmt.setString(7, bean.getAddress());
			/////////////////////////////////////////
			String hobby[] = bean.getHobby(); // {"인터넷", "영화"}
			char hb[] = { '0', '0', '0', '0', '0' };
			if (hobby != null) {
				String lists[] = { "인터넷", "여행", "게임", "영화", "운동" };
				for (int i = 0; i < hobby.length; i++) {
					for (int j = 0; j < lists.length; j++) {
						if (hobby[i].equals(lists[j])) {
							hb[j] = '1';
							break;
						}
					}
				}
			}
			pstmt.setString(8, new String(hb)); // 10010
			/////////////////////////////////////////
			pstmt.setString(9, bean.getJob());
			pstmt.setString(10, bean.getId());
			if (pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	// Admin Login
	public Vector<MemberBean> getMemberList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from tblMember";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setPwd(rs.getString("pwd"));
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				bean.setBirthday(rs.getString("birthday"));
				bean.setEmail(rs.getString("email"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Admin Login
	public boolean adminCheck(String admin_id, String admin_pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select admin_id, admin_pwd from tblAdmin where admin_id = ? and admin_pwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, admin_id);
			pstmt.setString(2, admin_pwd);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return flag;
	}
	
	// Send id, pwd
	public void sendAcount(String id) {
		MemberBean bean = getMember(id);
		String pwd = bean.getPwd();
		String title = "OOO.com 에서 아이디와 비밀번호를 전송합니다";
		String content = "<font color = 'red'><b> id : " + id;
		content += " / pwd : " + pwd + "</b></font>";
		String toEmail = bean.getEmail();
		MailSend.send(title, content, toEmail);
	}

}
