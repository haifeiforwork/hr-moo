package com.moorim.hr.common.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moorim.hr.common.dao.ComCodeDAO;
import com.moorim.hr.common.service.ComCodeService;

@Repository
public class ComCodeServiceImpl implements ComCodeService {
	
	private static Logger log = LoggerFactory.getLogger(ComCodeServiceImpl.class);
	
	@Autowired
	ComCodeDAO comCodeDao;

	@Override
	public List<Map> getCodeByGroup(String g_code) {
		List<Map> codeList = null;
		
		try {
			codeList = comCodeDao.getCodeByGroup(g_code);
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return codeList;
	}

	@Override
	public List<Map> getCodeSearchByGroup(String g_code, String search_txt) {
		List<Map> codeList = null;
		
		try {
			codeList = comCodeDao.getCodeSearchByGroup(g_code, search_txt);
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return codeList;
	}

}
