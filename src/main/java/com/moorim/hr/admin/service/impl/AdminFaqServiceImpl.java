package com.moorim.hr.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.dao.AdminFaqDAO;
import com.moorim.hr.admin.service.AdminFaqService;
import com.moorim.hr.admin.vo.FaqVO;
import com.moorim.hr.common.vo.PagingCommonVO;

@Repository
public class AdminFaqServiceImpl implements AdminFaqService {
	private static Logger log = LoggerFactory.getLogger(AdminFaqServiceImpl.class);
	
	@Autowired
	private AdminFaqDAO faqDao;
	
	@SuppressWarnings("rawtypes")
	private List lists;

	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	private int totCount = 0;
	
	@Override
	public List<Map> selectFaq0001List(PagingCommonVO vo) {
		try {
			lists = faqDao.selectFaq0001List(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int selectFaq0001Count(PagingCommonVO vo) {
		totCount = faqDao.selectFaq0001Count( vo );
		return totCount;
	}
	
	@Override
	public Map selectFaq0002Detail(PagingCommonVO vo) {
		return (Map) faqDao.selectFaq0002Detail( vo );
	}
	
	@Override
	public Map processFaq(FaqVO vo) {
		// TODO Auto-generated method stub
		resultMap = new HashMap();
		String result = "SUCCESS";
		String msg = "";
		int cnt = 0;
		try {
			
			String at = vo.getProcType();
			log.debug("======================["+at+"]");
			if("new".equals(at)) {
				cnt = faqDao.insertFaq0002(vo);
				msg = "등록 되었습니다.";
			} else if("mod".equals(at)) {
				cnt = faqDao.updateFaq0002(vo);
				msg = "수정 되었습니다.";
				
			} else if("del".equals(at)) {
				cnt = faqDao.deleteFaq0001(vo);
				msg = "삭제 되었습니다.";
				
			} else {
				msg = "정상적인 접근이 아닙니다.";
				result = "FAIL";
				
			}
		} catch( Exception e ) {
			e.printStackTrace();
			msg = "등록 에러";
			result = "FAIL";
			
		}
		resultMap.put( "msg", msg );
		resultMap.put( "result", result );
		
		return resultMap;
	}

	@Override
	public List<Map> selectFaq0001ListEasy(PagingCommonVO vo) {
		return faqDao.selectFaq0001ListEasy(vo);
	}

}
