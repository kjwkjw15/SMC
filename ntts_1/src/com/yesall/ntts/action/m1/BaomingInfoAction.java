package com.yesall.ntts.action.m1;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.yesall.ntts.srv.m1.BaomingInfoSrv;
@Controller
public class BaomingInfoAction extends ActionSupport{
	@Autowired
	private BaomingInfoSrv baomingInfoSrv;
	private JSONArray baomingJsonArray;

	public JSONArray getBaomingJsonArray() {
		return baomingJsonArray;
	}

	public void setBaomingJsonArray(JSONArray baomingJsonArray) {
		this.baomingJsonArray = baomingJsonArray;
	}

	public String queryBaomingJsonArray(){
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			
			String idCard = request.getParameter("idCard");
			
			baomingJsonArray = baomingInfoSrv.getBaomingJsonArray(idCard);
			return "success";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
