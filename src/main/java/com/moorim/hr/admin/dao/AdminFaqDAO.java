package com.moorim.hr.admin.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.vo.FaqVO;
import com.moorim.hr.common.dao.AbstractDAO;
import com.moorim.hr.common.vo.PagingCommonVO;


@Repository
public class AdminFaqDAO extends AbstractDAO {
	private static Logger log = LoggerFactory.getLogger(AdminFaqDAO.class);
	private int totCount = 0;
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectFaq0001List(PagingCommonVO vo) {
		return (List<Map>) selectList("selectFaq0001List", vo);
	}
	public int selectFaq0001Count(PagingCommonVO vo) {
		totCount = (Integer) selectOne("selectFaq0001Count", vo);
		return totCount;
	}
	
	@SuppressWarnings({ "rawtypes" })
	public Map selectFaq0002Detail(PagingCommonVO vo) {
		return (Map) selectOne("selectFaq0002Detail", vo);
	}
	
	public int insertFaq0002(FaqVO vo) {
		return (Integer) insert("insertFaq0002", vo);
	}
	public int updateFaq0002(FaqVO vo) {
		return (Integer) update("updateFaq0002", vo);
	}
	public int deleteFaq0001(FaqVO vo) {
		return (Integer) delete("deleteFaq0001", vo);
	}
	public List<Map> selectFaq0001ListEasy(PagingCommonVO vo) {
		return (List<Map>) selectList("selectFaq0001ListEasy",vo);
	}
	
	
}