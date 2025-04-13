package jspproject;

public class MplistBgmView {
    private int mplistmgr_id;
    private int mplist_id;
    private BgmBean bgm;
    private int bgm_onoff;
    private int bgm_order; 

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

    public BgmBean getBgm() {
        return bgm;
    }

    public void setBgm(BgmBean bgm) {
        this.bgm = bgm;
    }

	public int getBgm_onoff() {
		return bgm_onoff;
	}

	public void setBgm_onoff(int bgm_onoff) {
		this.bgm_onoff = bgm_onoff;
	}

	public int getBgm_order() {
		return bgm_order;
	}

	public void setBgm_order(int bgm_order) {
		this.bgm_order = bgm_order;
	}
    
}
