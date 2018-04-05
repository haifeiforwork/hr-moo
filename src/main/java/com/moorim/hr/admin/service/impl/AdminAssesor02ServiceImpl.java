package com.moorim.hr.admin.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.dao.AdminAssesor02DAO;
import com.moorim.hr.admin.service.AdminAssesor02Service;
import com.moorim.hr.admin.vo.AdminVolunteerVO;
import com.moorim.hr.common.vo.PagingCommonVO;

@Repository
public class AdminAssesor02ServiceImpl implements AdminAssesor02Service {
	private static Logger log = LoggerFactory.getLogger(AdminAssesor02ServiceImpl.class);
	
	@Autowired
	private AdminAssesor02DAO assesorDAO;
	
	@SuppressWarnings("rawtypes")
	private List lists;

	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	private int totCount = 0;

	@Override
	public List<Map> selectDoc0201list(PagingCommonVO vo) {
		try {
			lists = assesorDAO.selectDoc0201list(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int selectDoc0201count(PagingCommonVO vo) {
		totCount = assesorDAO.selectDoc0201count( vo );
		return totCount;
	}

	@Override
	public List<Map> selectDoc0201PopIntro(AdminVolunteerVO vo) {
		try {
			lists = assesorDAO.selectDoc0201PopIntro(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public List<Map> selectDoc0201PopItem(String idx) {
		try {
			lists = assesorDAO.selectDoc0201PopItem(idx);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}
	
	

}
