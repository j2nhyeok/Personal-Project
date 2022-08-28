package member.service;


public class JoinRequest {

	private String id;
	private String pw;
	private String name;
	private int year;
	private int month;
	private int date;
	private String gender;
	private String email;
	private String phoneNumber;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = Integer.parseInt(year);
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = Integer.parseInt(month);
	}
	public int getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = Integer.parseInt(date);
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	
}
