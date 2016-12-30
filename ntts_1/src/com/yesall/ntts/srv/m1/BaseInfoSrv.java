package com.yesall.ntts.srv.m1;

import java.util.Date;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yesall.ntts.dao.m1.BaomingInfoDAO;
import com.yesall.ntts.dao.m1.BaseInfoDAO;
import com.yesall.ntts.entity.m1.BaomingInfo;
import com.yesall.ntts.entity.m1.BaseInfo;
@Transactional
@Service("baseInfoSrv")
public class BaseInfoSrv {
	@Autowired
	private BaseInfoDAO baseInfoDAO;
	@Autowired
	private BaomingInfoDAO baomingInfoDAO;
	
	public Boolean submitBaseInfo(BaseInfo baseInfo,BaomingInfo baomingInfo){
		try {
			Date date=new Date();		
			baseInfo.setWritedate(date);
			baomingInfo.setBaomingdate(date);
			baomingInfo.setBaseInfo(baseInfo);
			baseInfoDAO.saveOrUpdate(baseInfo);	
			baomingInfoDAO.saveOrUpdate(baomingInfo);
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}		

	}
	
	public JSONArray getBaseInfoJsonArray() {
		
		String sql = "select idCard,name,age,birthdate,sex,companyName,phone,writedate from base_Info";
		
		return baseInfoDAO.findBySQL(sql, "idCard,name,age,birthdate,sex,companyName,phone,writedate");
	}
}
