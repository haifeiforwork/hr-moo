package com.moorim.hr.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.vo.AdminEvalItemVO;
import com.moorim.hr.admin.vo.AdminItemInterviewVO;
import com.moorim.hr.admin.vo.AdminItemIntroVO;
import com.moorim.hr.admin.vo.AdminMajorVO;
import com.moorim.hr.admin.vo.AdminMenuVO;
import com.moorim.hr.admin.vo.AdminPopupVO;
import com.moorim.hr.common.dao.AbstractDAO;
import com.moorim.hr.common.vo.PagingCommonVO;


@Repository
public class AdminCommonDAO extends AbstractDAO {
	private static Logger log = LoggerFactory.getLogger(AdminCommonDAO.class);
	private int totCount = 0;
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List selectItm0001list(HashMap<String, String> param) {
		return (List<Map>) selectList("selectItm0001list", param);
	}

	@SuppressWarnings({ "rawtypes" })
	public Map selectItm0001PopDetail(AdminItemIntroVO vo) {
		return (Map) selectOne("selectItm0001PopDetail", vo);
	}
	
	public int deleteItm0001Pop(AdminItemIntroVO vo) {
		return (Integer) delete("deleteItm0001Pop", vo);
	}
	public int insertItm0001Pop(AdminItemIntroVO vo) {
		return (Integer) delete("insertItm0001Pop", vo);
	}
	public int updateItm0001Pop(AdminItemIntroVO vo) {
		return (Integer) delete("updateItm0001Pop", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List selectItm0002list(PagingCommonVO vo) {
		return (List<Map>) selectList("selectItm0002list", vo);
	}
	public int selectItm0002Count(PagingCommonVO vo) {
		return (Integer) selectOne("selectItm0002Count", vo);
	}

	@SuppressWarnings({ "rawtypes" })
	public Map selectItm0002PopDetail(AdminItemInterviewVO vo) {
		return (Map) selectOne("selectItm0002PopDetail", vo);
	}
	
	public int deleteItm0002Pop(AdminItemInterviewVO vo) {
		return (Integer) delete("deleteItm0002Pop", vo);
	}
	public int insertItm0002Pop(AdminItemInterviewVO vo) {
		return (Integer) delete("insertItm0002Pop", vo);
	}
	public int updateItm0002Pop(AdminItemInterviewVO vo) {
		return (Integer) delete("updateItm0002Pop", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getMenuList(AdminMenuVO vo) {
		return (List<Map>) selectList("getMenuList", vo);
	}
	
	@SuppressWarnings({ "rawtypes" })
	public Map menuDetail(AdminMenuVO vo) {
		return (Map) selectOne("selectAdminMenuDetail", vo);
	}

	public void mergeMenuInfo(AdminMenuVO vo) {
		update("mergeMenuInfo", vo);
	}

	public void mergeMenuInfoCodeByGroup(AdminMenuVO vo) {
		update("mergeMenuInfoCodeByGroup", vo);
	}

	public int deleteMenu(AdminMenuVO vo) {
		return (Integer) delete("deleteMenu", vo);
	}

	public int deleteMenuCodeByGroup(AdminMenuVO vo) {
		return (Integer) delete("deleteMenuCodeByGroup", vo);
	}
	
	@SuppressWarnings({ "rawtypes" })
	public Map getMenuAddCatCode(AdminMenuVO vo) {
		return (Map) selectOne("getMenuAddCatCode", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List selectCom0101List(PagingCommonVO vo) {
		return (List<Map>) selectList("selectCom0101List", vo);
	}

	public int selectCom0101Count(PagingCommonVO vo) {
		return (Integer) selectOne("selectCom0101Count", vo);
	}
	
	@SuppressWarnings({ "rawtypes" })
	public Map selectCom0101Datail(AdminMajorVO vo) {
		return (Map) selectOne("selectCom0101Datail", vo);
	}
	public int deleteCom0101(AdminMajorVO vo) {
		return (Integer) delete("deleteCom0101", vo);
	}
	public int insertCom0101(AdminMajorVO vo) {
		return (Integer) insert("insertCom0101", vo);
	}
	public int updateCom0101(AdminMajorVO vo) {
		return (Integer) update("updateCom0101", vo);
	}
	
	@SuppressWarnings({ "rawtypes" })
	public Map selectItm0101PopDetail(AdminEvalItemVO vo) {
		return (Map) selectOne("selectItm0101PopDetail", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List selectItm0102PopItemList(AdminItemInterviewVO vo) {
		return (List<Map>) selectList("selectItm0102PopItemList", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List selectItm0101list(PagingCommonVO vo) {
		return (List<Map>) selectList("selectItm0101list", vo);
	}

	public void mergeEvalItmProcess(AdminEvalItemVO aVO) {
		update("mergeEvalItmProcess", aVO);
	}

	public int evalItmDelete(AdminEvalItemVO vo) {
		return (Integer) delete("evalItmDelete", vo);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List selectPopupManageList(PagingCommonVO vo) {
		return (List<Map>) selectList("selectPopupManageList", vo);
	}

	public int selectPopupManageCount(PagingCommonVO vo) {
		return (Integer) selectOne("selectPopupManageCount", vo);
	}
	
	@SuppressWarnings({ "rawtypes" })
	public Map PopupManageForm(PagingCommonVO vo) {
		return (Map) selectOne("selectPpupManageForm", vo);
	}

	public int deletePopup(AdminPopupVO vo) {
		return (Integer) delete("deletePopup", vo);
	}

	public int insertPopupManageProcess(AdminPopupVO vo) {
		return (Integer) insert("insertPopupManageProcess", vo);
	}

	public int updatePopupManageProcess(AdminPopupVO vo) {
		return (Integer) update("updatePopupManageProcess", vo);
	}
	
}