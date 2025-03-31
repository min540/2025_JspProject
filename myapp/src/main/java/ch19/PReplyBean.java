package ch19;

public class PReplyBean {
	
	private int rnum;
	private int num;
	private String id;
	private String rdate;
	private String comment;
	
	public PReplyBean() {}
	
	public PReplyBean(int rnum, int num, String id, String rdate, String comment) {
		super();
		this.rnum = rnum;
		this.num = num;
		this.id = id;
		this.rdate = rdate;
		this.comment = comment;
	}

	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}

}
