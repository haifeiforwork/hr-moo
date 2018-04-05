package com.moorim.hr.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.dao.AdminRecruitDAO;
import com.moorim.hr.admin.service.AdminRecruitService;
import com.moorim.hr.admin.vo.AdminMenuVO;
import com.moorim.hr.admin.vo.AdminRecruitCareerVO;
import com.moorim.hr.admin.vo.AdminRecruitVO;
import com.moorim.hr.admin.vo.AdminVolunteerVO;
import com.moorim.hr.client.vo.RecruitNoticeOptionVO;
import com.moorim.hr.common.vo.PagingCommonVO;

@Repository
public class AdminRecruitServiceImpl implements AdminRecruitService {
	private static Logger log = LoggerFactory.getLogger(AdminRecruitServiceImpl.class);
	
	@Autowired
	private AdminRecruitDAO recruitDAO;
	
	@SuppressWarnings("rawtypes")
	private List lists;

	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	private int totCount = 0;
	
	@Override
	public List<Map> getMainRecruitNoticeList(HashMap<String, String> param) {
		try {
			lists = recruitDAO.getMainRecruitNoticeList(param);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}
	
	@Override
	public Map getMainRecruitNoticeCnt() {
		return (Map) recruitDAO.getMainRecruitNoticeCnt();
	}
	
	
	
	@Override
	public List<Map> selectRec0001list(PagingCommonVO vo) {
		try {
			lists = recruitDAO.selectRec0001list(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int selectRec0001count(PagingCommonVO vo) {
		totCount = recruitDAO.selectRec0001count( vo );
		return totCount;
	}
	
	@Override
	public Map selectRec0002Detail(PagingCommonVO vo) {
		return (Map) recruitDAO.selectRec0002Detail( vo );
	}
	
	@Override
	public List selectRec0002DetailCareerList(PagingCommonVO vo) {
		return (List<Map>) recruitDAO.selectRec0002DetailCareerList( vo );
	}

	@Override
	public Map deleteRec0001(AdminRecruitVO vo) {
		// TODO Auto-generated method stub
		resultMap = new HashMap();
		String result = "SUCCESS";
		String msg = "";
		int cnt = 0;
		try {
			cnt = recruitDAO.deleteRec0001(vo);
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
	public boolean insertRec0002(AdminRecruitVO vo, List<AdminRecruitCareerVO> careerList) {
		boolean isSuccess = true;
		
		try {
			
			int idx = recruitDAO.insertRec0002(vo);
			if(idx > 0){
				for(AdminRecruitCareerVO cVo : careerList){
					cVo.setrIdx(vo.getrIdx());
					recruitDAO.insertRec0002Career(cVo);
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
	public boolean updateRec0002(AdminRecruitVO vo, List<AdminRecruitCareerVO> careerList) {
		boolean isSuccess = true;
		
		try {
			int idx = recruitDAO.updateRec0002(vo);
			if(idx > 0){
				if(careerList.size() >0){
					recruitDAO.deleteRec0002Career(vo);
					for(AdminRecruitCareerVO cVo : careerList){
						cVo.setrIdx(Integer.parseInt(vo.getIdx()));
						recruitDAO.insertRec0002Career(cVo);
					}
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
	public List<Map> selectRec0100list(PagingCommonVO vo) {
		try {
			lists = recruitDAO.selectRec0100list(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}
	
	@Override
	public int selectRecRec0100total() {
		totCount = recruitDAO.selectRecRec0100total();
		return totCount;
	}
	
	@Override
	public int selectRecRec0100count(PagingCommonVO vo) {
		totCount = recruitDAO.selectRecRec0100count( vo );
		return totCount;
	}

	@Override
	public List<Map> selectNoticeList() {
		try {
			lists = recruitDAO.selectNoticeList();
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public List<Map> selectKindOptions(RecruitNoticeOptionVO vo) {
		return recruitDAO.selectKindOptions(vo);
	}

	@Override
	public List<Map> selectPartOptions(RecruitNoticeOptionVO vo) {
		return recruitDAO.selectPartOptions(vo);
	}

	@Override
	public Map selectRecruitDetail(AdminVolunteerVO vo) {
		return recruitDAO.selectRecruitDetail(vo);
	}

	@Override
	public List<Map> selectSchoolList(AdminVolunteerVO vo) {
		try {
			lists = recruitDAO.selectSchoolList(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}
	
	@Override
	public List<Map> selectGradeList(AdminVolunteerVO vo) {
		try {
			lists = recruitDAO.selectGradeList(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public List<Map> selectCareerList(AdminVolunteerVO vo) {
		try {
			lists = recruitDAO.selectCareerList(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public List<Map> selectTrainingList(AdminVolunteerVO vo) {
		try {
			lists = recruitDAO.selectTrainingList(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public List<Map> selectLanguageList(AdminVolunteerVO vo) {
		try {
			lists = recruitDAO.selectLanguageList(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public List<Map> selectCertList(AdminVolunteerVO vo) {
		try {
			lists = recruitDAO.selectCertList(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public List<Map> selectIntroList(AdminVolunteerVO vo) {
		try {
			lists = recruitDAO.selectIntroList(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public List<Map> selectAdminItemIntroList(AdminVolunteerVO vo) {
		try {
			lists = recruitDAO.selectAdminItemIntroList(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public List<Map> selectRec0300list(PagingCommonVO vo) {
		try {
			lists = recruitDAO.selectRec0300list(vo);
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int selectRecRec0300count(PagingCommonVO vo) {
		totCount = recruitDAO.selectRecRec0300count( vo );
		return totCount;
	}

	@Override
	public boolean updateRec0300(AdminVolunteerVO vo, List<AdminVolunteerVO> volList) {
		boolean isSuccess = true;
		
		try {
			String rApCode;
			for(AdminVolunteerVO aVO : volList) {
				rApCode = aVO.getrApCode();
				
				if(rApCode != null) {
					aVO.setrStatusCode(vo.getrStatusCode());
					recruitDAO.updateRec0300(aVO);
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
	public List<Map> selectEvalMember() {
		try {
			lists = recruitDAO.selectEvalMember();
		} catch (Exception e) {
			log.debug(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

}
