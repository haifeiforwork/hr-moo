package com.moorim.hr.common.service;

import java.util.List;
import java.util.Map;

public interface ComCodeService {

	public List<Map> getCodeByGroup(String g_code);

	public List<Map> getCodeSearchByGroup(String g_code, String search_txt);
	
}
