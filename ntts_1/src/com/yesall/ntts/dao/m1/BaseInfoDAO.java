package com.yesall.ntts.dao.m1;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.yesall.ntts.dao.BaseDAO;
import com.yesall.ntts.entity.m1.BaseInfo;
@Transactional
@Repository("baseInfoDAO")
public class BaseInfoDAO extends BaseDAO<BaseInfo, String>{

}
