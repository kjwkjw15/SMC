package com.yesall.ntts.srv.m1;

import java.util.Date;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yesall.ntts.dao.m1.BaseInfoDAO;
import com.yesall.ntts.entity.m1.BaseInfo;
@Transactional
@Service("baseInfoSrv")
public class BaseInfoSrv {
	@Autowired
	private BaseInfoDAO baseInfoDAO;
	
	public Boolean addBaseInfo(BaseInfo baseInfo){
		baseInfoDAO.save(baseInfo);		
		return true;
	}
	
	public JSONArray getBaseInfoJsonArray() {
		
		String sql = "select idCard,name,age,birthdate,sex,companyName,phone,writedate from base_Info";

		
		return baseInfoDAO.findBySQL(sql, "idCard,name,age,birthday,sex,companyName,phone,writedate");
	}
}
