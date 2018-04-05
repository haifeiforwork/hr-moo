package com.moorim.hr.admin.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.vo.AdminRecruitCareerVO;
import com.moorim.hr.admin.vo.AdminRecruitVO;
import com.moorim.hr.admin.vo.IvGroupVO;
import com.moorim.hr.common.dao.AbstractDAO;
import com.moorim.hr.common.vo.PagingCommonVO;


@Repository
public class AdminRecruit04DAO extends AbstractDAO {
	private static Logger log = LoggerFactory.getLogger(AdminRecruit04DAO.class);
	private int totCount = 0;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectJobNotice() {
		return (List<Map>) selectList("selectJobNotice");
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectIvGroup(Map params) {
		return (List<Map>) selectList("selectIvGroup", params);
	}
	
	public int countIvGroup(Map params) {
		totCount = (Integer) selectOne("countIvGroup", params); 
		return totCount;
	}
	
	public int insertIvGroup(IvGroupVO vo) {
		return (Integer) insert("insertIvGroup", vo);
		
	}
	public int updateIvGroup(IvGroupVO vo) {
		return (Integer) update("updateIvGroup", vo);
	}
	public int deleteIvGroup(IvGroupVO vo) {
		return (Integer) delete("deleteIvGroup", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> getIvUser(Map params) {
		return (List<Map>) selectList("getIvUser", params);
	}
	
	
}