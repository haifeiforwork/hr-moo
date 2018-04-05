package com.moorim.hr.common.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.moorim.hr.common.vo.SmsVO;

@Repository
public class SmsDAO extends AbstractDAO {
	private static Logger log = LoggerFactory.getLogger(SmsDAO.class);
	
	public int insertSms(SmsVO vo) {
		return (Integer) insertSms("insertSms", vo);  
	}

}
