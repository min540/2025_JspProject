package jspproject;

public class JourBean {
	private int jour_id;
	private String user_id;
	private String jour_title;
	private String user_cnt;
	private String jour_regdate;
	
	public JourBean() {}
	
	public JourBean(int jour_id, String user_id, String jour_title, String user_cnt, String jour_regdate) {
		this.jour_id = jour_id;
		this.user_id = user_id;
		this.jour_title = jour_title;
		this.user_cnt = user_cnt;
		this.jour_regdate = jour_regdate;
	}

	public int getJour_id() {
		return jour_id;
	}
	public void setJour_id(int jour_id) {
		this.jour_id = jour_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getJour_title() {
		return jour_title;
	}
	public void setJour_title(String jour_title) {
		this.jour_title = jour_title;
	}
	public String getUser_cnt() {
		return user_cnt;
	}
	public void setUser_cnt(String user_cnt) {
		this.user_cnt = user_cnt;
	}
	public String getJour_regdate() {
		return jour_regdate;
	}
	public void setJour_regdate(String jour_regdate) {
		this.jour_regdate = jour_regdate;
	}
}
