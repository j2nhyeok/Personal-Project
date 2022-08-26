package member.model;

public class BlacklistMember {
	
	private String id;
	private String phoneNumber;
	
	public BlacklistMember() {
	}
	
	public BlacklistMember(String id, String phoneNumber) {
		this.id = id;
		this.phoneNumber = phoneNumber;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
}
