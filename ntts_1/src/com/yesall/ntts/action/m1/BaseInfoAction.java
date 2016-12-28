package com.yesall.ntts.action.m1;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.yesall.ntts.entity.m1.BaseInfo;
import com.yesall.ntts.srv.m1.BaseInfoSrv;
@Controller
public class BaseInfoAction extends ActionSupport{
	@Autowired
	private BaseInfoSrv baseInfoSrv;
	private BaseInfo baseInfo;
	
	public BaseInfo getBaseInfo() {
		return baseInfo;
	}
	public void setBaseInfo(BaseInfo baseInfo) {
		this.baseInfo = baseInfo;
	}
	
	public String addBaseInfo()throws Exception{
		Date date=new Date();
		
		baseInfo.setWritedate(date);
		baseInfoSrv.addBaseInfo(baseInfo);
		return "success";
	}
}
