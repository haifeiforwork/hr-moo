package com.moorim.hr.admin.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.moorim.hr.admin.dao.CodeDAO;
import com.moorim.hr.admin.service.CodeService;
import com.moorim.hr.admin.vo.CodeVO;
import com.moorim.hr.common.vo.PagingCommonVO;

@Repository
public class CodeServiceImpl implements CodeService {
	private static Logger log = LoggerFactory.getLogger(CodeServiceImpl.class);
	
	@Autowired
	private CodeDAO codeDao;
	
	@SuppressWarnings("rawtypes")
	private List lists;

	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	private int totCount = 0;
	
	@Override
	public List<Map> listCodeGroup() {
		try {
			lists = codeDao.listCodeGroup();
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public Map procCodeGroup(CodeVO vo) {
		// TODO Auto-generated method stub
		resultMap = new HashMap();
		String result = "SUCCESS";
		String msg = "";
		int cnt = 0;
		try {
			String at = vo.getProcType();
			if("new".equals(at)) {
				cnt = codeDao.insertCodeGroup(vo);
				msg = "등록 되었습니다.";
			} else if("mod".equals(at)) {
				cnt = codeDao.updateCodeGroup(vo);
				msg = "수정 되었습니다.";
			} else if("del".equals(at)) {
				cnt = codeDao.deleteCodeGroup(vo);
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
	@Transactional
	public void txTest() throws SQLException {
		codeDao.insertDummy();
		codeDao.insertDummy2();
	}

	@Override
	public List<Map> selectCodeByGruop(String g_code) {
		try {
			lists = codeDao.selectCodeByGruop(g_code);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public Map procCodeByGroup(CodeVO vo) {
		resultMap = new HashMap();
		String result = "SUCCESS";
		String msg = "";
		int cnt = 0;
		try {
			String at = vo.getProcType();
			if("new".equals(at)) {
				cnt = codeDao.insertCodeByGroup(vo);
				msg = "등록 되었습니다.";
			} else if("mod".equals(at)) {
				cnt = codeDao.updateCodeByGroup(vo);
				msg = "수정 되었습니다.";
			} else if("del".equals(at)) {
				cnt = codeDao.deleteCodeByGroup(vo);
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

}
