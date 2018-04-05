package com.moorim.hr.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.jsoup.helper.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.dao.MemberDAO;
import com.moorim.hr.admin.service.MemberService;
import com.moorim.hr.admin.vo.FaqVO;
import com.moorim.hr.admin.vo.MemberVO;
import com.moorim.hr.common.EncryptUtil;
import com.moorim.hr.common.vo.PagingCommonVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Repository
public class MemberServiceImpl implements MemberService {
	private static Logger log = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	private MemberDAO memberDao;
	
	@SuppressWarnings("rawtypes")
	private List lists;

	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	private int totCount = 0;
	
	@Override
	@SuppressWarnings({ "unchecked", "rawtypes", "static-access" })
	public Map getMemberInfo(MemberVO vo) {
		return memberDao.getHrMemberInfo(vo);
	}
	
	@Override
	public Map checkLogin(MemberVO vo) {
		resultMap = new HashMap();
		String result = "success";
		String msg = "";
		try {
			Map hpMap = memberDao.getEpMember(vo);
			String voPwd = EncryptUtil.encryptText(vo.getUser_password());
			
			if(hpMap==null || hpMap.isEmpty()) {
				result = "false";
				msg = "입력하신 ID의 직원 정보가 없습니다.";
			} else {
				String dbPwd = (String) hpMap.get("user_password");
				
				if(voPwd.equals(dbPwd)) {
					if(memberDao.getHrMember(vo) == 1) {
						msg = "로그인 되었습니다.";
					} else {
						result = "fail";
						msg = "HR 시스템에 사용자 정보가 없습니다.";
					}
				} else {
					result = "fail";
					msg = "비밀번호를 다시 확인하시기 바랍니다.";
				}
			}
			
		} catch (Exception e) {
			result = "fail";
			msg = "비밀번호를 다시 확인하시기 바랍니다.";
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		resultMap.put("result", result);
		resultMap.put("msg", msg);
		
		return resultMap;
		
	}
	
	@Override
	public Map checkSSOLogin(MemberVO vo) {
		resultMap = new HashMap();
		String result = "success";
		String msg = "";
		try {
			Map hpMap = memberDao.getSSOEpMember(vo);
			
			if(hpMap==null || hpMap.isEmpty()) {
				result = "fail";
				msg = "SSO 로그인 직원 정보가 없습니다.";
			} else {
				if(memberDao.getHrMember(vo) == 1) {
					msg = "로그인 되었습니다.";
				} else {
					result = "fail";
					msg = "HR 시스템에 사용자 정보가 없습니다.";
				}
			}
			
		} catch (Exception e) {
			result = "fail";
			msg = "로그인에 실패했습니다. 관리자에게 문의해 주세요";
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		resultMap.put("result", result);
		resultMap.put("msg", msg);
		
		return resultMap;
		
	}
	
	@Override
	public List<Map> listMember(PagingCommonVO vo) {
		try {
			lists = memberDao.listMember(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int cntMember(PagingCommonVO vo) {
		totCount = memberDao.cntMember( vo );
		return totCount;
	}
	
	@Override
	public List<Map> listEpMember(PagingCommonVO vo) {
		try {
			lists = memberDao.listEpMember(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}
	@Override
	public int countEpMember(PagingCommonVO vo) {
		try {
			totCount = memberDao.countEpMember(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return totCount;
	}
	@Override
	public List<Map> searchEpMember(String searchMemberName) {
		PagingCommonVO vo = new PagingCommonVO();
		vo.setSearchType("1");
		vo.setSKEY_1(searchMemberName);
		try {
			lists = memberDao.listEpMember(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}
	
	@Override
	public Map processMember(MemberVO vo) {
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
				log.debug("========"+mVo.getUser_id());
				
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
