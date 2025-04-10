package jspproject;

public class TimerBean {
	private int timer_id;
	private String timer_title;
	private String timer_cnt;
	private String timer_img;
	
	public TimerBean() {}

	public TimerBean(int timer_id, String timer_title, String timer_cnt, String timer_img) {
		super();
		this.timer_id = timer_id;
		this.timer_title = timer_title;
		this.timer_cnt = timer_cnt;
		this.timer_img = timer_img;
	}

	public int getTimer_id() {
		return timer_id;
	}

	public void setTimer_id(int timer_id) {
		this.timer_id = timer_id;
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

	public void setTimer_cnt(String timer_cnt) {
		this.timer_cnt = timer_cnt;
	}

	public String getTimer_img() {
		return timer_img;
	}

	public void setTimer_img(String timer_img) {
		this.timer_img = timer_img;
	}
	
}
