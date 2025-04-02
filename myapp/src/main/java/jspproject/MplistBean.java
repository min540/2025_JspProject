package jspproject;

public class MplistBean {
	private int mplist_id;
	private String mplist_name;
	private String user_id;
	private String mplist_cnt;
	private String mplist_img;
	
	public MplistBean() {}
	
	public MplistBean(int mplist_id, String mplist_name, String user_id, String mplist_cnt,
			String mplist_img) {
		this.mplist_id = mplist_id;
		this.mplist_name = mplist_name;
		this.user_id = user_id;
		this.mplist_cnt = mplist_cnt;
		this.mplist_img = mplist_img;
	}

	public int getMplist_id() {
		return mplist_id;
	}
	public void setMplist_id(int mplist_id) {
		this.mplist_id = mplist_id;
	}
	public String getMplist_name() {
		return mplist_name;
	}
	public void setMplist_name(String mplist_name) {
		this.mplist_name = mplist_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getMplist_cnt() {
		return mplist_cnt;
	}
	public void setMplist_cnt(String mplist_cnt) {
		this.mplist_cnt = mplist_cnt;
	}
	public String getMplist_img() {
		return mplist_img;
	}
	public void setMplist_img(String mplist_img) {
		this.mplist_img = mplist_img;
	}
}
