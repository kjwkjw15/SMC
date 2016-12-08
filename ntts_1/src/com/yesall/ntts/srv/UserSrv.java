package com.yesall.ntts.srv;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yesall.ntts.dao.UserDAO;
import com.yesall.ntts.entity.User;
@Service("userSrv")
public class UserSrv {
	@Autowired
	private UserDAO userDAO;

	
	public User userLogin(String name, String pass) {
		// TODO Auto-generated method stub
		return userDAO.userLogin(name,pass);
	}
}
