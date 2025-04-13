package jspproject;

public class UserTimerBean{
	private int user_timer_id;
	private String user_id;
	private int timer_id;
	private int timer_session;
	private int timer_break;
	private String timer_loc;
	
	public UserTimerBean() {}
	
	public UserTimerBean(int user_timer_id, String user_id, int timer_id, 
			int timer_session, int timer_break, String timer_loc) {
		this.user_timer_id = user_timer_id;
		this.user_id = user_id;
		this.timer_id = timer_id;
		this.timer_session = timer_session;
		this.timer_break = timer_break;
		this.timer_loc = timer_loc;
	}
	
	public int getUser_timer_id() {
		return user_timer_id;
	}

	public void setUser_timer_id(int user_timer_id) {
		this.user_timer_id = user_timer_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getTimer_id() {
		return timer_id;
	}

	public void setTimer_id(int timer_id) {
		this.timer_id = timer_id;
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

	public String getTimer_loc() {
		return timer_loc;
	}

	public void setTimer_loc(String timer_loc) {
		this.timer_loc = timer_loc;
	}
	
}