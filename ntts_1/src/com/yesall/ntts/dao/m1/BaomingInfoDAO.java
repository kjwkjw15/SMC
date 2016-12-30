package com.yesall.ntts.dao.m1;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.yesall.ntts.dao.BaseDAO;
import com.yesall.ntts.entity.m1.BaomingInfo;

@Transactional
@Repository("baomingInfoDAO")
public class BaomingInfoDAO extends BaseDAO<BaomingInfo, String>{

}
