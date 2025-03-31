package test2;

public class DepartmentBean {
	
	private int dmId;
    private String dmName;
    
    public DepartmentBean() {}
    
	public DepartmentBean(int dmId, String dmName) {
		super();
		this.dmId = dmId;
		this.dmName = dmName;
	}
	public int getDmId() {
		return dmId;
	}
	public void setDmId(int dmId) {
		this.dmId = dmId;
	}
	public String getDmName() {
		return dmName;
	}
	public void setDmName(String dmName) {
		this.dmName = dmName;
	} 
    
}
