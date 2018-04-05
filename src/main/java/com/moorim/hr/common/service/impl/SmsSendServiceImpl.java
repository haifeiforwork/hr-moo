package com.moorim.hr.common.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moorim.hr.common.dao.SmsDAO;
import com.moorim.hr.common.service.SmsSendService;
import com.moorim.hr.common.vo.SmsVO;

@Repository
public class SmsSendServiceImpl implements SmsSendService {
private static Logger log = LoggerFactory.getLogger(SmsSendServiceImpl.class);
	
	@Autowired
	private SmsDAO smsDao;
	
	@Override
	public int sendSms(SmsVO vo) {
		return smsDao.insertSms(vo);
	}
	

}
