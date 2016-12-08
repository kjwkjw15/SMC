package com.yesall.ntts.entity;

import javax.persistence.*;

@Entity
@Table(name="user")
public class User {
	
	    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="id")
	private int id;
	private String userName;
	private String passWord;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	   @Column(name="username")
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	   @Column(name="password")
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	
	public User(){
		
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", userName=" + userName + ", passWord=" + passWord + "]";
	}
	public User(String userName, String passWord) {
		this.userName = userName;
		this.passWord = passWord;
	}
	
}
