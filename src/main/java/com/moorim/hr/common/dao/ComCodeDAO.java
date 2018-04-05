package com.moorim.hr.common.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;


@Repository("codeDao")
public class ComCodeDAO extends AbstractDAO {
	private static Logger log = LoggerFactory.getLogger(ComCodeDAO.class);
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Cacheable(value="codeCache", key="#g_code")
	public  List<Map> getCodeByGroup(String g_code) {
		return (List<Map>) selectList("getCodeByGroup", g_code);
	}

	public  List<Map> getCodeSearchByGroup(String g_code, String search_txt) {
		Map param = new HashMap();
		param.put("G_CODE", g_code);
		param.put("SEARCH_TXT", search_txt);
		return (List<Map>) selectList("getCodeSearchByGroup", param);
	}

}
