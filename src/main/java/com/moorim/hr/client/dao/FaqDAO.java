package com.moorim.hr.client.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.vo.FaqVO;
import com.moorim.hr.common.dao.AbstractDAO;
import com.moorim.hr.common.vo.PagingCommonVO;


@Repository
public class FaqDAO extends AbstractDAO {
	private static Logger log = LoggerFactory.getLogger(FaqDAO.class);
	private int totCount = 0;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> listFaq(PagingCommonVO vo) {
		return (List<Map>) selectList("selectFaqList", vo);
	}
	public int countFaq(PagingCommonVO vo) {
		totCount = (Integer) selectOne("selectFaqCount", vo);
		return totCount;
	}
}