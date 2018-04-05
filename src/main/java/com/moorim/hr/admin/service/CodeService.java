package com.moorim.hr.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.moorim.hr.admin.vo.CodeVO;
import com.moorim.hr.common.vo.PagingCommonVO;

public interface CodeService {
	
	@SuppressWarnings("rawtypes")
	public List<Map> listCodeGroup();
	
	@SuppressWarnings("rawtypes")
	public Map procCodeGroup ( CodeVO vo );
	
	public void txTest() throws SQLException;

	public List<Map> selectCodeByGruop(String g_code);

	public Map procCodeByGroup(CodeVO vo);

}
