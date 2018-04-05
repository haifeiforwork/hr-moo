package com.moorim.hr.client.service;

import java.util.List;
import java.util.Map;

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

public interface JobService {
	
	public List<Map> listTopJob(PagingCommonVO vo);

	public List<Map> listJob(PagingCommonVO vo);
	
	public int cntJob(PagingCommonVO vo);
	
	public void updateHit(PagingCommonVO vo);

	public Map detailJob(PagingCommonVO vo);
	
	public List<Map> getCurrentNoticeList();
	
	public String getApplyCode(RecruitVO vo);
	
	public int checkReg(RecruitVO vo);
	
	public Map getPersonalInfo(RecruitVO vo);
	
	public List<Map> getKindOptions(RecruitNoticeOptionVO vo);

	public List<Map> getPartOptions(RecruitNoticeOptionVO vo);
	
	public List<Map> getAreaOptions(RecruitNoticeOptionVO vo);
	
	public Map saveApplyMaster(RecruitVO vo);
	
	public int checkSchoolReg(RecruitVO vo);

	public int checkGradeReg(RecruitVO vo);
	
	public List<Map> getSchoolList(RecruitVO vo);

	public List<Map> getGradeList(RecruitVO vo);
	
	public boolean saveApplySchool(List<RecruitSchoolVO> schoolList);
	
	public boolean saveApplyGrade(List<RecruitGradeVO> gradeList);
	
	public int checkCareerReg(RecruitVO vo);
	
	public List<Map> getCareerList(RecruitVO vo);

	public int checkTrainingReg(RecruitVO vo);
	
	public List<Map> getTrainingList(RecruitVO vo);

	public int checkLanguageReg(RecruitVO vo);
	
	public List<Map> getLanguageList(RecruitVO vo);

	public int checkCertReg(RecruitVO vo);
	
	public List<Map> getCertList(RecruitVO vo);
	
	public void saveApplyCareer(RecruitVO recruitVO, List<RecruitCareerVO> careerList) throws Exception;

	public void saveApplyTraining(RecruitVO recruitVO, List<RecruitTrainingVO> trainingList) throws Exception;

	public void saveApplyLanguage(RecruitVO recruitVO, List<RecruitLanguageVO> languageList) throws Exception;

	public void saveApplyCert(RecruitVO recruitVO, List<RecruitCertVO> certList) throws Exception;
	
	public List<Map> getIntroList(RecruitVO vo);
	
	public String getApplyKindNm(RecruitVO vo);
	
	public int checkApplyIntroReg(RecruitVO vo);
	
	public List<Map> getApplyIntroList(RecruitVO vo);
	
	public boolean saveApplyIntro(List<RecruitIntroVO> introList);
	
	public void updateStatus(RecruitVO vo);
	
	public Map getApplyInfo(RecruitVO vo);

	public Map appySelectOneInfo(RecruitVO vo);

}
