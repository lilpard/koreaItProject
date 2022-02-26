package com.example.project.domain;

public class Member {
	
	private Long userNo;
	private int userState;
	private String email, userName, nickName, pw, tel;
	public Member() {
		// TODO Auto-generated constructor stub
	}
	public Member(Long userNo, int userState, String email, String userName, String nickName, String pw, String tel) {
		super();
		this.userNo = userNo;
		this.userState = userState;
		this.email = email;
		this.userName = userName;
		this.nickName = nickName;
		this.pw = pw;
		this.tel = tel;
	}
	public Long getUserNo() {
		return userNo;
	}
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}
	public int getUserState() {
		return userState;
	}
	public void setUserState(int userState) {
		this.userState = userState;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	@Override
	public String toString() {
		return "Member [userNo=" + userNo + ", userState=" + userState + ", email=" + email + ", userName=" + userName
				+ ", nickName=" + nickName + ", pw=" + pw + ", tel=" + tel + "]";
	}

}
