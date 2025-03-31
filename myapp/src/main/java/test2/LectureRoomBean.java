package test2;

public class LectureRoomBean {
	
	private int lrId;
    private String lrName;
    
    public LectureRoomBean() {}
    
	public LectureRoomBean(int lrId, String lrName) {
		super();
		this.lrId = lrId;
		this.lrName = lrName;
	}

	public int getLrId() {
		return lrId;
	}
	public void setLrId(int lrId) {
		this.lrId = lrId;
	}
	public String getLrName() {
		return lrName;
	}
	public void setLrName(String lrName) {
		this.lrName = lrName;
	}
    
}	
