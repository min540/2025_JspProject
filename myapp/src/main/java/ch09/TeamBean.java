package ch09;

public class TeamBean {
	private int num;
	private String name;
	private String city;
	private int age;
	private String team;
	
	public TeamBean() {}
	
	public TeamBean(int num, String name, String city, int age, String team) {
		this.num = num;
		this.name = name;
		this.city = city;
		this.age = age;
		this.team = team;
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
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getTeam() {
		return team;
	}
	public void setTeam(String team) {
		this.team = team;
	}
	
	
}
