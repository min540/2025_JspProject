package jspproject;

public class NotifiBean {
	private int notifi_id;
	private String user_id;
	private String notifi_title;
	private String notifi_cnt;
	private String notifi_regdate;
	private int notifi_check;
	private int obj_id;
	
	public NotifiBean() {}
	
	public NotifiBean(int notifi_id, String user_id, String notifi_title, String notifi_cnt, String notifi_regdate,
			int notifi_check, int obj_id) {
		this.notifi_id = notifi_id;
		this.user_id = user_id;
		this.notifi_title = notifi_title;
		this.notifi_cnt = notifi_cnt;
		this.notifi_regdate = notifi_regdate;
		this.notifi_check = notifi_check;
		this.obj_id = obj_id;
	}

	public int getNotifi_id() {
		return notifi_id;
	}
	public void setNotifi_id(int notifi_id) {
		this.notifi_id = notifi_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getNotifi_title() {
		return notifi_title;
	}
	public void setNotifi_title(String notifi_title) {
		this.notifi_title = notifi_title;
	}
	public String getNotifi_cnt() {
		return notifi_cnt;
	}
	public void setNotifi_cnt(String notifi_cnt) {
		this.notifi_cnt = notifi_cnt;
	}
	public String getNotifi_regdate() {
		return notifi_regdate;
	}
	public void setNotifi_regdate(String notifi_regdate) {
		this.notifi_regdate = notifi_regdate;
	}
	public int getNotifi_check() {
		return notifi_check;
	}
	public void setNotifi_check(int notifi_check) {
		this.notifi_check = notifi_check;
	}
	public int getObj_id() {
		return obj_id;
	}
	public void setObj_id(int obj_id) {
		this.obj_id = obj_id;
	}
}
