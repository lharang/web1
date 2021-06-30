package bbs;

public class Users {
	private String name;
	private String id;
	private String passwd;
	private String gender;
	private String address;
	private String phone;
	private String email;
	private String pin_num;
	private String UserGrade;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPin_num() {
		return pin_num;
	}
	public void setPin_num(String pin_num) {
		this.pin_num = pin_num;
	}
	public String getUserGrade() {
		return UserGrade;
	}
	public void setUserGrade(String userGrade) {
		UserGrade = userGrade;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
}
