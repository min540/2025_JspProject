package jspproject;

public class ObjBean {
	private int obj_id;
	private String user_id;
	private String obj_title;
	private int obj_check;
	private String obj_regdate;
	private String obj_sdate;
	private String obj_edate;
	private int objgroup_id;
	
	public ObjBean() {}
	
	public ObjBean(int obj_id, String user_id, String obj_title, int obj_check, String obj_regdate,
			String obj_sdate, String obj_edate, int objgroup_id) {
		this.obj_id = obj_id;
		this.user_id = user_id;
		this.obj_title = obj_title;
		this.obj_check = obj_check;
		this.obj_regdate = obj_regdate;
		this.obj_sdate = obj_sdate;
		this.obj_edate = obj_edate;
		this.objgroup_id = objgroup_id;
	}

	public int getObj_id() {
		return obj_id;
	}
	public void setObj_id(int obj_id) {
		this.obj_id = obj_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getObj_title() {
		return obj_title;
	}
	public void setObj_title(String obj_title) {
		this.obj_title = obj_title;
	}
	public int getObj_check() {
		return obj_check;
	}
	public void setObj_check(int obj_check) {
		this.obj_check = obj_check;
	}
	public String getObj_regdate() {
		return obj_regdate;
	}
	public void setObj_regdate(String obj_regdate) {
		this.obj_regdate = obj_regdate;
	}
	public String getObj_sdate() {
		return obj_sdate;
	}
	public void setObj_sdate(String obj_sdate) {
		this.obj_sdate = obj_sdate;
	}
	public String getObj_edate() {
		return obj_edate;
	}
	public void setObj_edate(String obj_edate) {
		this.obj_edate = obj_edate;
	}

	public int getObjgroup_id() {
		return objgroup_id;
	}

	public void setObjgroup_id(int objgroup_id) {
		this.objgroup_id = objgroup_id;
	}


}
