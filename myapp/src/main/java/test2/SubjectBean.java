package test2;

public class SubjectBean {
	
	private int sjId;
    private String sjName;
    private String sjTime;
    private int pfId;
    private int lrId;
    private int maxPeople;
    
    public SubjectBean() {}
    
    public SubjectBean(int sjId, String sjName, String sjTime, int pfId, int lrId, int maxPeople) {
		super();
		this.sjId = sjId;
		this.sjName = sjName;
		this.sjTime = sjTime;
		this.pfId = pfId;
		this.lrId = lrId;
		this.maxPeople = maxPeople;
	}

	public int getSjId() {
		return sjId;
	}

	public void setSjId(int sjId) {
		this.sjId = sjId;
	}

	public String getSjName() {
		return sjName;
	}

	public void setSjName(String sjName) {
		this.sjName = sjName;
	}

	public String getSjTime() {
		return sjTime;
	}

	public void setSjTime(String sjTime) {
		this.sjTime = sjTime;
	}

	public int getPfId() {
		return pfId;
	}

	public void setPfId(int pfId) {
		this.pfId = pfId;
	}

	public int getLrId() {
		return lrId;
	}

	public void setLrId(int lrId) {
		this.lrId = lrId;
	}

	public int getMaxPeople() {
		return maxPeople;
	}

	public void setMaxPeople(int maxPeople) {
		this.maxPeople = maxPeople;
	}

}
