package test2;

public class SignupBean {
	
	private int signupId;
    private int sjId;
    private int stId;
    private int dmId;
    
    public SignupBean() {}
    
	public SignupBean(int signupId, int sjId, int stId, int dmId) {
		super();
		this.signupId = signupId;
		this.sjId = sjId;
		this.stId = stId;
		this.dmId = dmId;
	}

	public int getSignupId() {
		return signupId;
	}

	public void setSignupId(int signupId) {
		this.signupId = signupId;
	}

	public int getSjId() {
		return sjId;
	}

	public void setSjId(int sjId) {
		this.sjId = sjId;
	}

	public int getStId() {
		return stId;
	}

	public void setStId(int stId) {
		this.stId = stId;
	}

	public int getDmId() {
		return dmId;
	}

	public void setDmId(int dmId) {
		this.dmId = dmId;
	}
    
}
