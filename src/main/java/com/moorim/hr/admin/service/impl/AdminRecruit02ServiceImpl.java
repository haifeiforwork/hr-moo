package com.moorim.hr.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.dao.AdminRecruit02DAO;
import com.moorim.hr.admin.dao.AdminRecruitDAO;
import com.moorim.hr.admin.dao.MemberDAO;
import com.moorim.hr.admin.service.AdminRecruit02Service;
import com.moorim.hr.admin.service.AdminRecruitService;
import com.moorim.hr.admin.vo.AdminRecruitCareerVO;
import com.moorim.hr.admin.vo.AdminRecruitVO;
import com.moorim.hr.admin.vo.MemberVO;
import com.moorim.hr.common.vo.PagingCommonVO;

@Repository
public class AdminRecruit02ServiceImpl implements AdminRecruit02Service {
	private static Logger log = LoggerFactory.getLogger(AdminRecruit02ServiceImpl.class);
	
	@Autowired
	private AdminRecruit02DAO recruit02DAO;
	@Autowired
	private MemberDAO memberDao;
	
	@SuppressWarnings("rawtypes")
	private List lists;

	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	private int totCount = 0;
	
	@Override
	public List<Map> selectHrUser(Map params) {
		try {
			lists = recruit02DAO.selectHrUser(params);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int countHrUser(Map params) {
		int total = 0;
		total = (Integer) recruit02DAO.countHrUser(params);
		return total;
	}
	
	@Override
	public Map processEvMember(MemberVO vo) {
		// TODO Auto-generated method stub
		resultMap = new HashMap();
		String result = "SUCCESS";
		String msg = "";
		int cnt = 0;
		try {
			String at = vo.getProcType();
			log.debug("===========procType:"+vo.getProcType());
			if("new".equals(at)) {
				if(memberDao.existMember(vo) > 0) {
					msg="이미 등록된 사용자입니다.";
					result = "FAIL";
				} else {
					cnt = memberDao.insertMember(vo);
					msg = "등록 되었습니다.";
				}
			} else if("mod".equals(at)) {
				
				List<MemberVO> ltmp = vo.getMemberVOList();
				MemberVO mVo = ltmp.get(vo.getListIndex());
				mVo.setMod_id(vo.getMod_id());
				
				cnt = memberDao.updateMember(mVo);
				msg = "수정 되었습니다.";
				
			} else if("del".equals(at)) {
				
				List<MemberVO> ltmp = vo.getMemberVOList();
				MemberVO mVo = ltmp.get(vo.getListIndex());
				mVo.setMod_id(vo.getMod_id());

				cnt = memberDao.deleteMember(mVo);
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
