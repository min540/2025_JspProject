package test2;

public class ProfessorBean {
	
	private int pfId;
    private String pfSub;
    private String pfName;
    private String pfPw;
    private String pfTel;
    private int dmId;
    
    public ProfessorBean() {}
    
	public ProfessorBean(int pfId, String pfSub, String pfName, String pfPw, String pfTel, int dmId) {
		super();
		this.pfId = pfId;
		this.pfSub = pfSub;
		this.pfName = pfName;
		this.pfPw = pfPw;
		this.pfTel = pfTel;
		this.dmId = dmId;
	}

	public int getPfId() {
		return pfId;
	}

	public void setPfId(int pfId) {
		this.pfId = pfId;
	}

	public String getPfSub() {
		return pfSub;
	}

	public void setPfSub(String pfSub) {
		this.pfSub = pfSub;
	}

	public String getPfName() {
		return pfName;
	}

	public void setPfName(String pfName) {
		this.pfName = pfName;
	}

	public String getPfPw() {
		return pfPw;
	}

	public void setPfPw(String pfPw) {
		this.pfPw = pfPw;
	}

	public String getPfTel() {
		return pfTel;
	}

	public void setPfTel(String pfTel) {
		this.pfTel = pfTel;
	}

	public int getDmId() {
		return dmId;
	}

	public void setDmId(int dmId) {
		this.dmId = dmId;
	}
  
}
