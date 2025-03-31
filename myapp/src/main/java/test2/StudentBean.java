package test2;

public class StudentBean {
	
	private int stId;
    private String stName;
    private String stTel;
    private String stPw;
    private int dmId;
    
    public StudentBean() {}

	public StudentBean(int stId, String stName, String stTel, String stPw, int dmId) {
		super();
		this.stId = stId;
		this.stName = stName;
		this.stTel = stTel;
		this.stPw = stPw;
		this.dmId = dmId;
	}

	public int getStId() {
		return stId;
	}

	public void setStId(int stId) {
		this.stId = stId;
	}

	public String getStName() {
		return stName;
	}

	public void setStName(String stName) {
		this.stName = stName;
	}

	public String getStTel() {
		return stTel;
	}

	public void setStTel(String stTel) {
		this.stTel = stTel;
	}

	public String getStPw() {
		return stPw;
	}

	public void setStPw(String stPw) {
		this.stPw = stPw;
	}

	public int getDmId() {
		return dmId;
	}

	public void setDmId(int dmId) {
		this.dmId = dmId;
	}
    
}
