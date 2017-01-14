package com.yesall.ntts.srv.m1;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yesall.ntts.dao.m1.BaomingInfoDAO;
@Transactional
@Service("baomingInfoSrv")
public class BaomingInfoSrv {
	@Autowired
	private BaomingInfoDAO baomingInfoDAO;
	
	public JSONArray getBaomingJsonArray(String idCard) {
		String selectFieldsString = "idCard, firstKind, secondKind,whetherPay,whetherInformation,classInfo,baomingdate";
		
		String sql = "select " +selectFieldsString+ " from baoming_info where idCard=?";
		return baomingInfoDAO.findBySQL(sql, selectFieldsString, idCard);
	}
}
