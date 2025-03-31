package jspproject;

public class BgmBean {
	private int bgm_id;
	private String user_id;
	private String bgm_name;
	private String bgm_cnt;
	private String bgm_size;
	private int bgm_onoff;
	private String bgm_image;
	
	public BgmBean() {}
	
	public BgmBean(int bgm_id, String user_id, String bgm_name, String bgm_cnt, String bgm_size, int bgm_onoff,
			String bgm_image) {
		this.bgm_id = bgm_id;
		this.user_id = user_id;
		this.bgm_name = bgm_name;
		this.bgm_cnt = bgm_cnt;
		this.bgm_size = bgm_size;
		this.bgm_onoff = bgm_onoff;
		this.bgm_image = bgm_image;
	}

	public int getBgm_id() {
		return bgm_id;
	}
	public void setBgm_id(int bgm_id) {
		this.bgm_id = bgm_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getBgm_name() {
		return bgm_name;
	}
	public void setBgm_name(String bgm_name) {
		this.bgm_name = bgm_name;
	}
	public String getBgm_cnt() {
		return bgm_cnt;
	}
	public void setBgm_cnt(String bgm_cnt) {
		this.bgm_cnt = bgm_cnt;
	}
	public String getBgm_size() {
		return bgm_size;
	}
	public void setBgm_size(String bgm_size) {
		this.bgm_size = bgm_size;
	}
	public int getBgm_onoff() {
		return bgm_onoff;
	}
	public void setBgm_onoff(int bgm_onoff) {
		this.bgm_onoff = bgm_onoff;
	}
	public String getBgm_image() {
		return bgm_image;
	}
	public void setBgm_image(String bgm_image) {
		this.bgm_image = bgm_image;
	}
}
