package jspproject;

public class AncBean {
	private int anc_id;
	private String user_id;
	private String anc_title;
	private String anc_cnt;
	private String anc_regdate;
	private String anc_img;
	
	public AncBean() {}
	
	public AncBean(int anc_id, String user_id, String anc_title, String anc_cnt, String anc_regdate, String anc_img) {
		this.anc_id = anc_id;
		this.user_id = user_id;
		this.anc_title = anc_title;
		this.anc_cnt = anc_cnt;
		this.anc_regdate = anc_regdate;
		this.anc_img = anc_img;
	}

	public int getAnc_id() {
		return anc_id;
	}
	public void setAnc_id(int anc_id) {
		this.anc_id = anc_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getAnc_title() {
		return anc_title;
	}
	public void setAnc_title(String anc_title) {
		this.anc_title = anc_title;
	}
	public String getAnc_cnt() {
		return anc_cnt;
	}
	public void setAnc_cnt(String anc_cnt) {
		this.anc_cnt = anc_cnt;
	}
	public String getAnc_regdate() {
		return anc_regdate;
	}
	public void setAnc_regdate(String anc_regdate) {
		this.anc_regdate = anc_regdate;
	}
	public String getAnc_img() {
		return anc_img;
	}
	public void setAnc_img(String anc_img) {
		this.anc_img = anc_img;
	}
}
