package jspproject;

public class TimerBean {
	private int timer_id;
	private String user_id;
	private int timer_session;
	private int timer_break;
	private int timer_design;
	private String timer_title;
	private String timer_cnt;
	private int timer_loc;
	private int timer_onoff;
	private String timer_img;
	
	public TimerBean() {}
	
	public TimerBean(int timer_id, String user_id, int timer_session, int timer_break, int timer_design, String timer_title,
			String timer_cnt, int timer_loc, int timer_onoff, String timer_img) {
		this.timer_id = timer_id;
		this.user_id = user_id;
		this.timer_session = timer_session;
		this.timer_break = timer_break;
		this.timer_design = timer_design;
		this.timer_title = timer_title;
		this.timer_cnt = timer_cnt;
		this.timer_loc = timer_loc;
		this.timer_onoff = timer_onoff;
		this.timer_img = timer_img;
	}

	public int getTimer_id() {
		return timer_id;
	}
	public void setTimer_id(int timer_id) {
		this.timer_id = timer_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getTimer_session() {
		return timer_session;
	}
	public void setTimer_session(int timer_session) {
		this.timer_session = timer_session;
	}
	public int getTimer_break() {
		return timer_break;
	}
	public void setTimer_break(int timer_break) {
		this.timer_break = timer_break;
	}
	public int getTimer_design() {
		return timer_design;
	}
	public void setTimer_design(int timer_design) {
		this.timer_design = timer_design;
	}
	public String getTimer_title() {
		return timer_title;
	}
	public void setTimer_title(String timer_title) {
		this.timer_title = timer_title;
	}
	public String getTimer_cnt() {
		return timer_cnt;
	}
	public void setTimer_cnt(String cnt) {
		this.timer_cnt = timer_cnt;
	}
	public int getTimer_loc() {
		return timer_loc;
	}
	public void setTimer_loc(int timer_loc) {
		this.timer_loc = timer_loc;
	}
	public int getTimer_onoff() {
		return timer_onoff;
	}
	public void setTimer_onoff(int timer_onoff) {
		this.timer_onoff = timer_onoff;
	}
	public String getTimer_img() {
		return timer_img;
	}
	public void setTimer_img(String timer_img) {
		this.timer_img = timer_img;
	}
	
	
}
