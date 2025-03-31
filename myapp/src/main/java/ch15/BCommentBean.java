package ch15;

public class BCommentBean {
	
	private int cnum;
	private int num;
	private String name;
	private String comment;
	private String regdate;
	
	public BCommentBean() {}

	public BCommentBean(int cnum, int num, String name, String comment, String regdate) {
		super();
		this.cnum = cnum;
		this.num = num;
		this.name = name;
		this.comment = comment;
		this.regdate = regdate;
	}
	
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
}
