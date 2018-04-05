package com.moorim.hr.admin.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.vo.AdminRecruitCareerVO;
import com.moorim.hr.admin.vo.AdminRecruitVO;
import com.moorim.hr.common.dao.AbstractDAO;
import com.moorim.hr.common.vo.PagingCommonVO;


@Repository
public class AdminRecruit02DAO extends AbstractDAO {
	private static Logger log = LoggerFactory.getLogger(AdminRecruit02DAO.class);
	private int totCount = 0;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectHrUser(Map params) {
		return (List<Map>) selectList("selectHrUser0200", params);
	}
	
	public int countHrUser(Map params) {
		totCount = (Integer) selectOne("countHrUser0200", params); 
		return totCount;
	}
	
}