package com.yesall.ntts.action.m1;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.yesall.ntts.entity.m1.BaomingInfo;
import com.yesall.ntts.entity.m1.BaseInfo;
import com.yesall.ntts.srv.m1.BaseInfoSrv;

@Controller
public class BaseInfoAction extends ActionSupport{
	@Autowired
	private BaseInfoSrv baseInfoSrv;
	private BaseInfo baseInfo;
	private BaomingInfo baomingInfo;
	private JSONArray  baseInfoJsonArray;
	private JSONObject baseInfoJsonObject;

	public JSONObject getBaseInfoJsonObject() {
		return baseInfoJsonObject;
	}
	public void setBaseInfoJsonObject(JSONObject baseInfoJsonObject) {
		this.baseInfoJsonObject = baseInfoJsonObject;
	}
	public BaomingInfo getBaomingInfo() {
		return baomingInfo;
	}
	public void setBaomingInfo(BaomingInfo baomingInfo) {
		this.baomingInfo = baomingInfo;
	}
	public JSONArray getBaseInfoJsonArray() {
		return baseInfoJsonArray;
	}
	public void setBaseInfoJsonArray(JSONArray baseInfoJsonArray) {
		this.baseInfoJsonArray = baseInfoJsonArray;
	}
	public BaseInfo getBaseInfo() {
		return baseInfo;
	}
	public void setBaseInfo(BaseInfo baseInfo) {
		this.baseInfo = baseInfo;
	}
	//基本信息录入+报名信息
	public String submitBaseInfo()throws Exception{		
		
		Boolean bln = baseInfoSrv.submitBaseInfo(baseInfo, baomingInfo);
		return bln ? "success" : "failure";
	}
	
	/*
	 * **form.jsp页面加载grid数据
	 */
		public String query_BaseInfo_JsonArray() {
			try {
				HttpServletRequest request = ServletActionContext.getRequest();
				
				baseInfoJsonArray = baseInfoSrv.getBaseInfoJsonArray();

				return "success";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
		}
		
		public String queryBaseInfoJsonObject() {
			try {
				HttpServletRequest request = ServletActionContext.getRequest();
				
				String idCard = request.getParameter("idCard");
				
				baseInfoJsonObject = baseInfoSrv.getBaseInfoJson(idCard);
				return "success";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
		}
}
