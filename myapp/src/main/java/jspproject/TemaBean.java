package jspproject;

public class TemaBean {
	private int tema_id;
	private String user_id;
	private String tema_title;
	private String tema_bimg;
	private String tema_cnt;
	private int tema_dark;
	private int tema_onoff;
	private String tema_img;
	
	public TemaBean() {}
	
	public TemaBean(int tema_id, String user_id, String tema_title, String tema_bimg, String tema_cnt, int tema_dark,
			int tema_onoff, String tema_img) {
		this.tema_id = tema_id;
		this.user_id = user_id;
		this.tema_title = tema_title;
		this.tema_bimg = tema_bimg;
		this.tema_cnt = tema_cnt;
		this.tema_dark = tema_dark;
		this.tema_onoff = tema_onoff;
		this.tema_img = tema_img;
	}

	public int getTema_id() {
		return tema_id;
	}
	public void setTema_id(int tema_id) {
		this.tema_id = tema_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getTema_title() {
		return tema_title;
	}
	public void setTema_title(String tema_title) {
		this.tema_title = tema_title;
	}
	public String getTema_bimg() {
		return tema_bimg;
	}
	public void setTema_bimg(String tema_bimg) {
		this.tema_bimg = tema_bimg;
	}
	public String getTema_cnt() {
		return tema_cnt;
	}
	public void setTema_cnt(String tema_cnt) {
		this.tema_cnt = tema_cnt;
	}
	public int getTema_dark() {
		return tema_dark;
	}
	public void setTema_dark(int tema_dark) {
		this.tema_dark = tema_dark;
	}
	public int getTema_onoff() {
		return tema_onoff;
	}
	public void setTema_onoff(int tema_onoff) {
		this.tema_onoff = tema_onoff;
	}
	public String getTema_img() {
		return tema_img;
	}
	public void setTema_img(String tema_img) {
		this.tema_img = tema_img;
	}
}
