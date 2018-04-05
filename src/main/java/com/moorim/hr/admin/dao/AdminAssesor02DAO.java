package com.moorim.hr.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.vo.AdminRecruitCareerVO;
import com.moorim.hr.admin.vo.AdminRecruitVO;
import com.moorim.hr.admin.vo.AdminVolunteerVO;
import com.moorim.hr.client.vo.RecruitNoticeOptionVO;
import com.moorim.hr.common.dao.AbstractDAO;
import com.moorim.hr.common.vo.PagingCommonVO;


@Repository
public class AdminAssesor02DAO extends AbstractDAO {
	private static Logger log = LoggerFactory.getLogger(AdminAssesor02DAO.class);
	private int totCount = 0;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List selectDoc0201list(PagingCommonVO vo) {
		return (List<Map>) selectList("selectDoc0201list", vo);
	}
	public int selectDoc0201count(PagingCommonVO vo) {
		totCount = (Integer) selectOne("selectDoc0201count", vo); 
		return totCount;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List selectDoc0201PopIntro(AdminVolunteerVO vo) {
		return (List<Map>) selectList("selectDoc0201PopIntro", vo);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List selectDoc0201PopItem(String idx) {
		return (List<Map>) selectList("selectDoc0201PopItem", idx);
	}
	

}