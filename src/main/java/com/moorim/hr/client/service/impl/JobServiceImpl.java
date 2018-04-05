package com.moorim.hr.client.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.moorim.hr.client.dao.JobDAO;
import com.moorim.hr.client.service.JobService;
import com.moorim.hr.client.vo.RecruitCareerVO;
import com.moorim.hr.client.vo.RecruitCertVO;
import com.moorim.hr.client.vo.RecruitGradeVO;
import com.moorim.hr.client.vo.RecruitIntroVO;
import com.moorim.hr.client.vo.RecruitLanguageVO;
import com.moorim.hr.client.vo.RecruitNoticeOptionVO;
import com.moorim.hr.client.vo.RecruitSchoolVO;
import com.moorim.hr.client.vo.RecruitTrainingVO;
import com.moorim.hr.client.vo.RecruitVO;
import com.moorim.hr.common.vo.PagingCommonVO;

@Service
public class JobServiceImpl implements JobService {
	
	private static Logger log = LoggerFactory.getLogger(JobServiceImpl.class);
	
	@Autowired
	private JobDAO jobDao;

	@Override
	public List<Map> listTopJob(PagingCommonVO vo) {
		List<Map> lists = null;
		try {
			lists = jobDao.listTopJob(vo);
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public List<Map> listJob(PagingCommonVO vo) {
		List<Map> lists = null;
		try {
			lists = jobDao.listJob(vo);
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int cntJob(PagingCommonVO vo) {
		int totCount = jobDao.countJob(vo);

		return totCount;
	}

	@Override
	public void updateHit(PagingCommonVO vo) {
		jobDao.updateHit(vo);
	}

	@Override
	public Map detailJob(PagingCommonVO vo) {
		Map rs = null;
		
		try {
			rs = jobDao.detailJob(vo);
		} catch(Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return rs;
	}
	
	@Override
	public String getApplyCode(RecruitVO vo) {
		return jobDao.getApplyCode(vo);
	}

	@Override
	public int checkReg(RecruitVO vo) {
		return jobDao.checkReg(vo);
	}
	
	@Override
	public Map getPersonalInfo(RecruitVO vo) {
		Map rs = null;
		
		try {
			rs = jobDao.getPersonalInfo(vo);
		} catch(Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return rs;
	}
	
	@Override
	public List<Map> getKindOptions(RecruitNoticeOptionVO vo) {
		return jobDao.getKindOptions(vo);
	}

	@Override
	public List<Map> getPartOptions(RecruitNoticeOptionVO vo) {
		return jobDao.getPartOptions(vo);
	}
	
	@Override
	public List<Map> getAreaOptions(RecruitNoticeOptionVO vo) {
		return jobDao.getAreaOptions(vo);
	}

	@Override
	public Map saveApplyMaster(RecruitVO vo) {
		HashMap resultMap = new HashMap();
		String result = "success";
		String msg = "";
		String procType = vo.getProcType();
		
		try {
			
			if(procType.equals("new")) {
				jobDao.insertApplyMaster(vo);
				
				msg = "저장되었습니다.";
			} else if(procType.equals("mod")) {
				jobDao.updateApplyMaster(vo);
				
				msg = "수정되었습니다.";
			} else {
			}
			
		} catch (Exception e) {
			msg = "저장에 실패하였습니다.";
			result = "fail";
			
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		resultMap.put("msg", msg);
		resultMap.put("result", result);
		
		return resultMap;
	}

	@Override
	public int checkSchoolReg(RecruitVO vo) {
		return jobDao.checkSchoolReg(vo);
	}

	@Override
	public int checkGradeReg(RecruitVO vo) {
		return jobDao.checkGradeReg(vo);
	}

	@Override
	public List<Map> getSchoolList(RecruitVO vo) {
		List<Map> lists = null;
		try {
			lists = jobDao.selectSchoolList(vo);
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public List<Map> getGradeList(RecruitVO vo) {
		List<Map> lists = null;
		try {
			lists = jobDao.selectGradeList(vo);
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public boolean saveApplySchool(List<RecruitSchoolVO> schoolList) {
		boolean isSuccess = true;
		
		try {
			String rApCode;
			for(RecruitSchoolVO vo : schoolList) {
				rApCode = vo.getrApCode();
				
				if(rApCode != null) {
					// Merge
					jobDao.mergeApplySchool(vo);
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
	public boolean saveApplyGrade(List<RecruitGradeVO> gradeList) {
		boolean isSuccess = true;
		
		try {
			String rApCode;
			for(RecruitGradeVO vo : gradeList) {
				rApCode = vo.getrApCode();
				
				if(rApCode != null) {
					// Merge
					jobDao.mergeApplyGrade(vo);
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
	public int checkCareerReg(RecruitVO vo) {
		return jobDao.checkCareerReg(vo);
	}

	@Override
	public List<Map> getCareerList(RecruitVO vo) {
		List<Map> lists = null;
		try {
			lists = jobDao.selectCareerList(vo);
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int checkTrainingReg(RecruitVO vo) {
		return jobDao.checkTrainingReg(vo);
	}

	@Override
	public List<Map> getTrainingList(RecruitVO vo) {
		List<Map> lists = null;
		try {
			lists = jobDao.selectTrainingList(vo);
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int checkLanguageReg(RecruitVO vo) {
		return jobDao.checkLanguageReg(vo);
	}

	@Override
	public List<Map> getLanguageList(RecruitVO vo) {
		List<Map> lists = null;
		try {
			lists = jobDao.selectLanguageList(vo);
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public int checkCertReg(RecruitVO vo) {
		return jobDao.checkCertReg(vo);
	}

	@Override
	public List<Map> getCertList(RecruitVO vo) {
		List<Map> lists = null;
		try {
			lists = jobDao.selectCertList(vo);
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	@Transactional
	public void saveApplyCareer(RecruitVO recruitVO, List<RecruitCareerVO> careerList) throws Exception {
		jobDao.deleteApplyCareer(recruitVO);
		
		String rApCode;
		for(RecruitCareerVO vo : careerList) {
			rApCode = vo.getrApCode();
			
			if(rApCode != null) {
				// Insert Career
				jobDao.insertApplyCareer(vo);
			}
		}
	}

	@Override
	public void saveApplyTraining(RecruitVO recruitVO, List<RecruitTrainingVO> trainingList) throws Exception {
		jobDao.deleteApplyTraining(recruitVO);
		
		String rApCode;
		for(RecruitTrainingVO vo : trainingList) {
			rApCode = vo.getrApCode();
			
			if(rApCode != null) {
				jobDao.insertApplyTraining(vo);
			}
		}
	}

	@Override
	public void saveApplyLanguage(RecruitVO recruitVO, List<RecruitLanguageVO> languageList) throws Exception {
		jobDao.deleteApplyLanguage(recruitVO);
		
		String rApCode;
		for(RecruitLanguageVO vo : languageList) {
			rApCode = vo.getrApCode();
			
			if(rApCode != null) {
				jobDao.insertApplyLanguage(vo);
			}
		}
	}

	@Override
	public void saveApplyCert(RecruitVO recruitVO, List<RecruitCertVO> certList) throws Exception {
		jobDao.deleteApplyCert(recruitVO);
		
		String rApCode;
		for(RecruitCertVO vo : certList) {
			rApCode = vo.getrApCode();
			
			if(rApCode != null) {
				jobDao.insertApplyCert(vo);
			}
		}
	}

	@Override
	public List<Map> getIntroList(RecruitVO vo) {
		List<Map> lists = null;
		try {
			lists = jobDao.selectIntroList(vo);
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}
	
	@Override
	public String getApplyKindNm(RecruitVO vo) {
		return jobDao.getApplyKindNm(vo);
	}

	@Override
	public int checkApplyIntroReg(RecruitVO vo) {
		return jobDao.checkApplyIntroReg(vo);
	}

	@Override
	public List<Map> getApplyIntroList(RecruitVO vo) {
		List<Map> lists = null;
		try {
			lists = jobDao.selectApplyIntroList(vo);
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public boolean saveApplyIntro(List<RecruitIntroVO> introList) {
		boolean isSuccess = true;
		
		try {
			String rApCode;
			log.debug("@@@@@@@@ Intro size :: {}", introList.size());
			for(RecruitIntroVO vo : introList) {
				rApCode = vo.getrApCode();
				log.debug("@@@@@@@@ Intro rApCode :: {}", rApCode);
				if(rApCode != null) {
					// Merge
					jobDao.mergeApplyIntro(vo);
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
	public void updateStatus(RecruitVO vo) {
		jobDao.updateStatus(vo);
	}

	@Override
	public Map getApplyInfo(RecruitVO vo) {
		Map rs = null;
		
		try {
			rs = jobDao.getApplyInfo(vo);
		} catch(Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return rs;
	}

	@Override
	public List<Map> getCurrentNoticeList() {
		List<Map> lists = null;
		try {
			lists = jobDao.getCurrentNoticeList();
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public Map appySelectOneInfo(RecruitVO vo) {
		Map map = null;
		try {
			map = jobDao.appySelectOneInfo(vo);
		} catch (Exception e) {
			if(log.isErrorEnabled())log.error(e.getMessage());
			e.printStackTrace();
		}
		
		return map;
	}

}
