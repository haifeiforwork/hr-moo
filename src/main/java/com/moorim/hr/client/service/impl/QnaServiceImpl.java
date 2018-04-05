package com.moorim.hr.client.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.moorim.hr.client.dao.QnaDAO;
import com.moorim.hr.client.service.QnaService;
import com.moorim.hr.client.vo.QnaVO;
import com.moorim.hr.common.vo.PagingCommonVO;

@Repository
public class QnaServiceImpl implements QnaService {
	private static Logger log = LoggerFactory.getLogger(QnaServiceImpl.class);
	
	@Autowired
	private QnaDAO qnaDao;
	
	@SuppressWarnings("rawtypes")
	private List lists;

	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	private int totCount = 0;
	
	@Override
	public List<Map> listQna(PagingCommonVO vo) {
		try {
			lists = qnaDao.listQna(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int cntQna(PagingCommonVO vo) {
		totCount = qnaDao.countQna( vo );

		return totCount;
	}
	@Override
	public int viewCountQna(QnaVO vo) {
		totCount = qnaDao.viewCountQna( vo );

		return totCount;
	}
	
	@Override
	public int pwdQna(QnaVO vo) {
		totCount = qnaDao.pwdQna( vo );

		return totCount;
	}


	@Override
	public Map detailQna(PagingCommonVO vo) {
		return (Map) qnaDao.detailQna( vo );
	}
	

	@Override
	public Map processQna(QnaVO vo) {
		// TODO Auto-generated method stub
		resultMap = new HashMap();
		String result = "SUCCESS";
		String msg = "";
		int cnt = 0;
		try {
			
			String at = vo.getProcType();
			if("new".equals(at)) {
				cnt = qnaDao.insertQna(vo);
				msg = "등록 되었습니다.";
			} else if("mod".equals(at)) {
				cnt = qnaDao.updateQna(vo);
				msg = "수정 되었습니다.";
				
			} else if("del".equals(at)) {
				cnt = qnaDao.deleteQna(vo);
				msg = "삭제 되었습니다.";
			
			} else if("reply".equals(at)) {
				cnt = qnaDao.answerQna(vo);
				msg = "등록 되었습니다.";
				
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
	public int updateViewQna(PagingCommonVO vo) {
		return (Integer) qnaDao.updateViewQna( vo );
	}

}
