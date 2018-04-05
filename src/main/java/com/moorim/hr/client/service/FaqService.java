package com.moorim.hr.client.service;

import java.util.List;
import java.util.Map;

import com.moorim.hr.common.vo.PagingCommonVO;


public interface FaqService {
	
	@SuppressWarnings("rawtypes")
	public List<Map> listFaq ( PagingCommonVO vo );
	
	public int cntFaq ( PagingCommonVO vo );
	
	
}
