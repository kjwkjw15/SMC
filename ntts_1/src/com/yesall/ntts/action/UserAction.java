package com.yesall.ntts.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.yesall.ntts.entity.User;
import com.yesall.ntts.srv.UserSrv;
@Controller
public class UserAction extends ActionSupport{
	@Autowired
	private UserSrv userSrv;
	private String username;
	private String password;
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String userLogin() throws Exception{
		//User user=new User(username,password);
		User user=userSrv.userLogin(username,password);
		if (user!=null) {
			//System.out.print(list.get(0));
			return "success";
		}
		return "fail";
	}
}
