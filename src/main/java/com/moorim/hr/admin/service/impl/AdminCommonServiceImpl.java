package com.moorim.hr.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.dao.AdminCommonDAO;
import com.moorim.hr.admin.service.AdminCommonService;
import com.moorim.hr.admin.vo.AdminEvalItemVO;
import com.moorim.hr.admin.vo.AdminItemInterviewVO;
import com.moorim.hr.admin.vo.AdminItemIntroVO;
import com.moorim.hr.admin.vo.AdminMajorVO;
import com.moorim.hr.admin.vo.AdminMenuVO;
import com.moorim.hr.admin.vo.AdminPopupVO;
import com.moorim.hr.common.vo.PagingCommonVO;

@Repository
public class AdminCommonServiceImpl implements AdminCommonService {
	private static Logger log = LoggerFactory.getLogger(AdminCommonServiceImpl.class);
	
	@Autowired
	private AdminCommonDAO adminCommonDAO;
	
	@SuppressWarnings("rawtypes")
	private List lists;

	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	private int totCount = 0;

	@Override
	public List<Map> selectItm0001list(HashMap<String, String> param) {
		try {
			lists = adminCommonDAO.selectItm0001list(param);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public Map selectItm0001PopDetail(AdminItemIntroVO vo) {
		try {
			resultMap = adminCommonDAO.selectItm0001PopDetail(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public Map deleteItm0001Pop(AdminItemIntroVO vo) {
		resultMap = new HashMap();
		String result = "SUCCESS";
		String msg = "";
		int cnt = 0;
		try {
			cnt = adminCommonDAO.deleteItm0001Pop(vo);
			msg = "삭제 되었습니다.";
		} catch( Exception e ) {
			e.printStackTrace();
			msg = "삭제 에러";
			result = "FAIL";
			
		}
		resultMap.put( "msg", msg );
		resultMap.put( "result", result );
		
		return resultMap;
	}

	@Override
	public boolean insertItm0001Pop(AdminItemIntroVO vo) {
		boolean isSuccess = true;
		try {
			int idx = adminCommonDAO.insertItm0001Pop(vo);
		} catch (Exception e) {
			isSuccess = false;
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		return isSuccess;
	}

	@Override
	public boolean updateItm0001Pop(AdminItemIntroVO vo) {
		boolean isSuccess = true;
		try {
			int idx = adminCommonDAO.updateItm0001Pop(vo);
		} catch (Exception e) {
			isSuccess = false;
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	@Override
	public List<Map> selectItm0002list(PagingCommonVO vo) {
		try {
			lists = adminCommonDAO.selectItm0002list(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}
	
	@Override
	public int selectItm0002Count(PagingCommonVO vo) {
		totCount = adminCommonDAO.selectItm0002Count( vo );
		return totCount;
	}

	@Override
	public Map selectItm0002PopDetail(AdminItemInterviewVO vo) {
		try {
			resultMap = adminCommonDAO.selectItm0002PopDetail(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public Map deleteItm0002Pop(AdminItemInterviewVO vo) {
		resultMap = new HashMap();
		String result = "SUCCESS";
		String msg = "";
		int cnt = 0;
		try {
			cnt = adminCommonDAO.deleteItm0002Pop(vo);
			msg = "삭제 되었습니다.";
		} catch( Exception e ) {
			e.printStackTrace();
			msg = "삭제 에러";
			result = "FAIL";
			
		}
		resultMap.put( "msg", msg );
		resultMap.put( "result", result );
		
		return resultMap;
	}

	@Override
	public boolean insertItm0002Pop(AdminItemInterviewVO vo) {
		boolean isSuccess = true;
		try {
			String qCode;
			String eStepCode;
			for(AdminItemInterviewVO aVO : vo.getInterviewList()) {
				qCode = vo.getqCode();
				eStepCode = vo.geteStepCode();
				
				if(qCode != null && eStepCode != null) {
					aVO.seteStepCode(eStepCode);
					aVO.setqCode(qCode);
					adminCommonDAO.insertItm0002Pop(aVO);
				}
			}
		} catch (Exception e) {
			isSuccess = false;
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		return isSuccess;
	}

	@Override
	public boolean updateItm0002Pop(AdminItemInterviewVO vo) {
		boolean isSuccess = true;
		try {
			int idx = adminCommonDAO.updateItm0002Pop(vo);
		} catch (Exception e) {
			isSuccess = false;
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		return isSuccess;
	}

	@Override
	public List<Map> getMenuList(AdminMenuVO vo) {
		try {
			lists = adminCommonDAO.getMenuList(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public Map menuDetail(AdminMenuVO vo) {
		try {
			resultMap = adminCommonDAO.menuDetail(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public boolean menuProcess(AdminMenuVO vo) {
		boolean isSuccess = true;
		
		try {
			String catCode;
			for(AdminMenuVO aVO : vo.getAdminMenuList()) {
				catCode = aVO.getCatCode();
				
				if(catCode != null) {
					// Merge
					adminCommonDAO.mergeMenuInfo(aVO);
					adminCommonDAO.mergeMenuInfoCodeByGroup(aVO);
				}
			}
		} catch (Exception e) {
			isSuccess = false;
			
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return isSuccess;
	}

	@Override
	public Map deleteMenu(AdminMenuVO vo) {
		resultMap = new HashMap();
		String result = "SUCCESS";
		String msg = "";
		int cnt = 0;
		try {
			cnt = adminCommonDAO.deleteMenu(vo);
			if(cnt > 0){
				cnt = adminCommonDAO.deleteMenuCodeByGroup(vo);
			}
			
			msg = "삭제 되었습니다.";
		} catch( Exception e ) {
			e.printStackTrace();
			msg = "삭제 에러";
			result = "FAIL";
			
		}
		resultMap.put( "msg", msg );
		resultMap.put( "result", result );
		
		return resultMap;
	}

	@Override
	public Map getMenuAddCatCode(AdminMenuVO vo) {
		try {
			resultMap = adminCommonDAO.getMenuAddCatCode(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public List<Map> selectCom0101List(PagingCommonVO vo) {
		try {
			lists = adminCommonDAO.selectCom0101List(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int selectCom0101Count(PagingCommonVO vo) {
		totCount = adminCommonDAO.selectCom0101Count( vo );
		return totCount;
	}

	@Override
	public boolean insertCom0101Pop(AdminMajorVO vo) {
		boolean isSuccess = true;
		
		try {
			String mCode;
			for(AdminMajorVO aVO : vo.getMajorList()) {
				mCode = aVO.getmCode();
				
				if(mCode != null) {
					adminCommonDAO.insertCom0101(aVO);
				}
			}
		} catch (Exception e) {
			isSuccess = false;
			
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return isSuccess;
	}

	@Override
	public boolean updateCom0101(AdminMajorVO vo) {
		boolean isSuccess = true;
		try {
			int idx = adminCommonDAO.updateCom0101(vo);
		} catch (Exception e) {
			isSuccess = false;
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		return isSuccess;
	}

	@Override
	public Map com0101Detail(AdminMajorVO vo) {
		try {
			resultMap = adminCommonDAO.selectCom0101Datail(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public Map deleteCom0101(AdminMajorVO vo) {
		resultMap = new HashMap();
		String result = "SUCCESS";
		String msg = "";
		int cnt = 0;
		try {
			cnt = adminCommonDAO.deleteCom0101(vo);
			msg = "삭제 되었습니다.";
		} catch( Exception e ) {
			e.printStackTrace();
			msg = "삭제 에러";
			result = "FAIL";
			
		}
		resultMap.put( "msg", msg );
		resultMap.put( "result", result );
		
		return resultMap;
	}
	
	@Override
	public List<Map> selectItm0101list(PagingCommonVO vo) {
		try {
			lists = adminCommonDAO.selectItm0101list(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}
	
	@Override
	public List<Map> selectItm0102PopItemList(AdminItemInterviewVO vo) {
		try {
			lists = adminCommonDAO.selectItm0102PopItemList(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}
	
	@Override
	public Map selectItm0101PopDetail(AdminEvalItemVO vo) {
		try {
			resultMap = adminCommonDAO.selectItm0101PopDetail(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public boolean evalItmProcess(AdminEvalItemVO vo) {
		boolean isSuccess = true;
		
		try {
			String eStepCode;
			String itemIndex;
			for(AdminEvalItemVO aVO : vo.getItemList()) {
				eStepCode = vo.geteStepCode();
				itemIndex = vo.getItemIndex();
				
				if(eStepCode != null && itemIndex != null) {
					aVO.seteStepCode(eStepCode);
					aVO.setItemIndex(itemIndex);
					// Merge
					adminCommonDAO.mergeEvalItmProcess(aVO);
				}
			}
		} catch (Exception e) {
			isSuccess = false;
			
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return isSuccess;
	}

	@Override
	public Map evalItmDelete(AdminEvalItemVO vo) {
		resultMap = new HashMap();
		String result = "SUCCESS";
		String msg = "";
		int cnt = 0;
		try {
			cnt = adminCommonDAO.evalItmDelete(vo);
			msg = "삭제 되었습니다.";
		} catch( Exception e ) {
			e.printStackTrace();
			msg = "삭제 에러";
			result = "FAIL";
			
		}
		resultMap.put( "msg", msg );
		resultMap.put( "result", result );
		
		return resultMap;
	}

	@Override
	public List<Map> selectPopupManageList(PagingCommonVO vo) {
		try {
			lists = adminCommonDAO.selectPopupManageList(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int selectPopupManageCount(PagingCommonVO vo) {
		totCount = adminCommonDAO.selectPopupManageCount( vo );
		return totCount;
	}

	@Override
	public Map PopupManageForm(PagingCommonVO vo) {
		try {
			resultMap = adminCommonDAO.PopupManageForm(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public Map deletePopup(AdminPopupVO vo) {
		resultMap = new HashMap();
		String result = "SUCCESS";
		String msg = "";
		int cnt = 0;
		try {
			cnt = adminCommonDAO.deletePopup(vo);
			msg = "삭제 되었습니다.";
		} catch( Exception e ) {
			e.printStackTrace();
			msg = "삭제 에러";
			result = "FAIL";
			
		}
		resultMap.put( "msg", msg );
		resultMap.put( "result", result );
		
		return resultMap;
	}

	@Override
	public boolean PopupManageProcess(AdminPopupVO vo) {
		
		boolean isSuccess = true;
		
		try {
			int cnt = -1;
			if("mod".equals(vo.getProcType())){
				cnt = adminCommonDAO.insertPopupManageProcess(vo);	
			}else{
				cnt = adminCommonDAO.updatePopupManageProcess(vo);	
			}
			
		} catch (Exception e) {
			isSuccess = false;
			
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return isSuccess;
		
		
	}

	


}
