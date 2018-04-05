package com.moorim.hr.client.service;

import java.util.List;
import java.util.Map;

import com.moorim.hr.client.vo.QnaVO;
import com.moorim.hr.common.vo.PagingCommonVO;


public interface QnaService {
	
	@SuppressWarnings("rawtypes")
	public List<Map> listQna ( PagingCommonVO vo );
	
	public int cntQna ( PagingCommonVO vo );
	
	public int pwdQna ( QnaVO vo );
	
	public int viewCountQna ( QnaVO vo );
	
	@SuppressWarnings("rawtypes")
	public Map detailQna ( PagingCommonVO vo );
	
	@SuppressWarnings("rawtypes")
	public Map processQna ( QnaVO vo );
	
	public int updateViewQna ( PagingCommonVO vo );
	
	
}
