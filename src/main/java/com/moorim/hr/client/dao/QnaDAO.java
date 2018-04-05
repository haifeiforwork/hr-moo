package com.moorim.hr.client.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.moorim.hr.common.vo.PagingCommonVO;
import com.moorim.hr.client.vo.QnaVO;
import com.moorim.hr.common.dao.AbstractDAO;


@Repository
public class QnaDAO extends AbstractDAO {
	private static Logger log = LoggerFactory.getLogger(QnaDAO.class);
	private int totCount = 0;
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> listQna(PagingCommonVO vo) {
		return (List<Map>) selectList("selectQnaList", vo);
	}
	public int countQna(PagingCommonVO vo) {
		totCount = (Integer) selectOne("selectQnaCount", vo);
		return totCount;
	}
	public int viewCountQna(QnaVO vo) {
		totCount = (Integer) update("updateViewCount", vo);
		return totCount;
	}

	
	public int pwdQna(QnaVO vo) { 
		totCount = (Integer) selectOne("selectQnaPwd", vo);
		return totCount; 
	}

	
	@SuppressWarnings({ "rawtypes" })
	public Map detailQna(PagingCommonVO vo) {
		return (Map) selectOne("detailQna", vo);
	}
	
	public int insertQna(QnaVO vo) {
		return (Integer) insert("insertQna", vo);
	}
	public int updateQna(QnaVO vo) {
		return (Integer) update("updateQna", vo);
	}
	public int deleteQna(QnaVO vo) {
		return (Integer) delete("deleteQna", vo);
	}
	public int answerQna(QnaVO vo) { 
		return (Integer) insert("answerQna", vo);
	}
	public int updateViewQna(PagingCommonVO vo) {
		return (Integer) update("updateViewQna", vo);
	}
	
}