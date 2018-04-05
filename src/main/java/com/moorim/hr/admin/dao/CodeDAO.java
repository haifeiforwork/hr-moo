package com.moorim.hr.admin.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.vo.CodeVO;
import com.moorim.hr.common.dao.AbstractDAO;


@Repository
public class CodeDAO extends AbstractDAO {
	private static Logger log = LoggerFactory.getLogger(CodeDAO.class);
	private int totCount = 0;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> listCodeGroup() { 
		return (List<Map>) selectList("selectCodeGruop");
	}
	public int insertCodeGroup(CodeVO vo) {
		return (Integer) insert("insertCodeGroup", vo);
	}
	public int updateCodeGroup(CodeVO vo) {
		return (Integer) update("updateCodeGroup", vo);
	}
	public int deleteCodeGroup(CodeVO vo) {
		return (Integer) delete("deleteCodeGroup", vo);
	}
	
	public void insertDummy() {
		insert("insertDummy");
	} 
	public void insertDummy2() {
		insert("insertDummy2");
	}
	public List selectCodeByGruop(String g_code) {
		return (List<Map>) selectList("selectCodeByGruop",g_code);
	}
	
	public int insertCodeByGroup(CodeVO vo) {
		return (Integer) insert("insertCodeByGroup", vo);
	}
	public int updateCodeByGroup(CodeVO vo) {
		return (Integer) update("updateCodeByGroup", vo);
	}
	public int deleteCodeByGroup(CodeVO vo) {
		return (Integer) delete("deleteCodeByGroup", vo);
	}
}