package com.yesall.ntts.dao;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.yesall.ntts.entity.User;

@Repository("userDAO")
public class UserDAO extends HibernateDaoSupport{

	public User userLogin(String name,String pass) {
		// TODO Auto-generated method stub
		List<User> obj = (List<User>) getHibernateTemplate().find("from User where userName=? and passWord=?", name, pass);
        return obj.size()>0?obj.get(0):null;
	}
}
