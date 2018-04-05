package com.moorim.hr.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.moorim.hr.admin.vo.AdminEvalItemVO;
import com.moorim.hr.admin.vo.AdminItemInterviewVO;
import com.moorim.hr.admin.vo.AdminItemIntroVO;
import com.moorim.hr.admin.vo.AdminMajorVO;
import com.moorim.hr.admin.vo.AdminMenuVO;
import com.moorim.hr.admin.vo.AdminPopupVO;
import com.moorim.hr.common.vo.PagingCommonVO;


public interface AdminCommonService {

	List<Map> selectItm0001list(HashMap<String, String> param);
	Map selectItm0001PopDetail(AdminItemIntroVO vo);
	Map deleteItm0001Pop(AdminItemIntroVO vo);
	boolean insertItm0001Pop(AdminItemIntroVO vo);
	boolean updateItm0001Pop(AdminItemIntroVO vo);
	
	List<Map> selectItm0002list(PagingCommonVO vo);
	int selectItm0002Count(PagingCommonVO vo);
	Map selectItm0002PopDetail(AdminItemInterviewVO vo);
	Map deleteItm0002Pop(AdminItemInterviewVO vo);
	boolean insertItm0002Pop(AdminItemInterviewVO vo);
	boolean updateItm0002Pop(AdminItemInterviewVO vo);

	List<Map> getMenuList(AdminMenuVO vo);
	Map menuDetail(AdminMenuVO vo);
	boolean menuProcess(AdminMenuVO vo);
	Map deleteMenu(AdminMenuVO vo);
	Map getMenuAddCatCode(AdminMenuVO vo);

	List<Map> selectCom0101List(PagingCommonVO vo);
	int selectCom0101Count(PagingCommonVO vo);
	Map com0101Detail(AdminMajorVO vo);
	Map deleteCom0101(AdminMajorVO vo);
	boolean insertCom0101Pop(AdminMajorVO vo);
	boolean updateCom0101(AdminMajorVO vo);
	
	List<Map> selectItm0101list(PagingCommonVO vo);
	Map selectItm0101PopDetail(AdminEvalItemVO vo);
	boolean evalItmProcess(AdminEvalItemVO vo);
	List<Map> selectItm0102PopItemList(AdminItemInterviewVO vo);
	Map evalItmDelete(AdminEvalItemVO vo);
	
	
	List<Map> selectPopupManageList(PagingCommonVO vo);
	int selectPopupManageCount(PagingCommonVO vo);
	Map PopupManageForm(PagingCommonVO vo);
	Map deletePopup(AdminPopupVO vo);
	boolean PopupManageProcess(AdminPopupVO vo);
	
	
}
