package ch14;

public class MemberBean {

	private String id;
	private String pwd;
	private String name;
	private String gender;
	private String birthday;
	private String email;
	private String zipcode;
	private String address;
	private String hobby[];
	private String job;
	
	// 기본 생성자 추가
    public MemberBean() {}
	
	public MemberBean(String id, String pwd, String name, String gender, String birthday, String email, String zipcode,
			String address, String[] hobby, String job) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.gender = gender;
		this.birthday = birthday;
		this.email = email;
		this.zipcode = zipcode;
		this.address = address;
		this.hobby = hobby;
		this.job = job;
	}
	
	public String getId() {
		return id;
	}
	
	
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	
	public String[] getHobby() {
		return hobby;
	}

	public void setHobby(String[] hobby) {
		this.hobby = hobby;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	
	
}
