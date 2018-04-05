package com.moorim.hr.admin.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.vo.MemberVO;
import com.moorim.hr.common.dao.AbstractDAO;
import com.moorim.hr.common.vo.PagingCommonVO;


@Repository
public class MemberDAO extends AbstractDAO {
	private static Logger log = LoggerFactory.getLogger(MemberDAO.class);
	private int totCount = 0;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getEpMember(MemberVO vo) { 
		return (Map) selectOneEp("getEpUser", vo);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getSSOEpMember(MemberVO vo) { 
		return (Map) selectOneEp("getSSOEpUser", vo);
	}
	public int getHrMember(MemberVO vo) {
		return (Integer) selectOne("getHrUser", vo);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getHrMemberInfo(MemberVO vo) {
		return (Map) selectOne("getHrUserInfo", vo);
	} 
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> listMember(PagingCommonVO vo) {
		return selectList("selectHrMember", vo);
	}
	
	public int cntMember(PagingCommonVO vo) {
		totCount = (Integer) selectOne("countHrMember", vo);
		return totCount;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> listEpMember(PagingCommonVO vo) {
		log.debug(vo.getSearchType());
		log.debug(vo.getSearchType()); 
//		return null;
		return selectListEp("selectEpMember", vo);
	}
	
	public int existMember(MemberVO vo) {
		totCount = (Integer) selectOne("existHrMember", vo);
		return totCount;
	}

	
	public int countEpMember(PagingCommonVO vo) {
		totCount = (Integer) selectOneEp("countEpMember", vo); 
		return totCount;
	}
	public int insertMember(MemberVO vo) {
		return (Integer) insert("insertHrMember", vo);
	}
	public int updateMember(MemberVO vo) {
		return (Integer) update("updateHrMember", vo);
	}
	public int deleteMember(MemberVO vo) { 
		return (Integer) delete("deleteHrMember", vo);
	}
	
	
} 