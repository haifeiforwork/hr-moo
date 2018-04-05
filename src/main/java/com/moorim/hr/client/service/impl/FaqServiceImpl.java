package com.moorim.hr.client.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moorim.hr.client.dao.FaqDAO;
import com.moorim.hr.client.service.FaqService;
import com.moorim.hr.common.vo.PagingCommonVO;

@Repository
public class FaqServiceImpl implements FaqService {
	private static Logger log = LoggerFactory.getLogger(FaqServiceImpl.class);
	
	@Autowired
	private FaqDAO faqDao;
	
	@SuppressWarnings("rawtypes")
	private List lists;

	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	private int totCount = 0;
	
	@Override
	public List<Map> listFaq(PagingCommonVO vo) {
		try {
			lists = faqDao.listFaq(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int cntFaq(PagingCommonVO vo) {
		totCount = faqDao.countFaq( vo );
		return totCount;
	}
}
