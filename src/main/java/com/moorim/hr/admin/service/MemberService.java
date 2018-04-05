package com.moorim.hr.admin.service;

import java.util.List;
import java.util.Map;

import com.moorim.hr.admin.vo.CodeVO;
import com.moorim.hr.admin.vo.MemberVO;
import com.moorim.hr.common.vo.PagingCommonVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public interface MemberService {
	
	@SuppressWarnings("rawtypes")
	public Map getMemberInfo(MemberVO vo);
	
	@SuppressWarnings("rawtypes")
	public Map checkLogin(MemberVO vo);
	
	@SuppressWarnings("rawtypes")
	public Map checkSSOLogin(MemberVO vo);
	
	@SuppressWarnings("rawtypes")
	public List<Map> listMember(PagingCommonVO vo);
	
	@SuppressWarnings("rawtypes")
	public int cntMember(PagingCommonVO vo);
	
	@SuppressWarnings("rawtypes")
	public List<Map> listEpMember(PagingCommonVO vo);
	
	public int countEpMember(PagingCommonVO vo);
	
	
	@SuppressWarnings("rawtypes")
	public List<Map> searchEpMember(String searchMemberName);
	
	public Map processMember(MemberVO vo);
	
	
}
