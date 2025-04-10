package jspproject;

public class MplistMgrBean {
	private int mplistmgr_id;
	private int mplist_id;
	private int bgm_id;
	private String user_id;

	public MplistMgrBean() {}

	public MplistMgrBean(int mplistmgr_id, int mplist_id, int bgm_id, String user_id) {
		this.mplistmgr_id = mplistmgr_id;
		this.mplist_id = mplist_id;
		this.bgm_id = bgm_id;
		this.user_id = user_id;
	}

	public int getMplistmgr_id() {
		return mplistmgr_id;
	}
	public void setMplistmgr_id(int mplistmgr_id) {
		this.mplistmgr_id = mplistmgr_id;
	}

	public int getMplist_id() {
		return mplist_id;
	}
	public void setMplist_id(int mplist_id) {
		this.mplist_id = mplist_id;
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
}
