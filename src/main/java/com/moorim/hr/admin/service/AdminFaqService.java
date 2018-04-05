package com.moorim.hr.admin.service;

import java.util.List;
import java.util.Map;

import com.moorim.hr.admin.vo.FaqVO;
import com.moorim.hr.common.vo.PagingCommonVO;


public interface AdminFaqService {
	
	@SuppressWarnings("rawtypes")
	public List<Map> selectFaq0001List ( PagingCommonVO vo );
	
	public int selectFaq0001Count ( PagingCommonVO vo );
	
	@SuppressWarnings("rawtypes")
	public Map selectFaq0002Detail ( PagingCommonVO vo );

	@SuppressWarnings("rawtypes")
	public Map processFaq(FaqVO vo);

	public List<Map> selectFaq0001ListEasy(PagingCommonVO vo);
	
}
