package com.moorim.hr.client.dao;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Repository;

import com.moorim.hr.client.vo.RecruitCareerVO;
import com.moorim.hr.client.vo.RecruitCertVO;
import com.moorim.hr.client.vo.RecruitGradeVO;
import com.moorim.hr.client.vo.RecruitIntroVO;
import com.moorim.hr.client.vo.RecruitLanguageVO;
import com.moorim.hr.client.vo.RecruitNoticeOptionVO;
import com.moorim.hr.client.vo.RecruitSchoolVO;
import com.moorim.hr.client.vo.RecruitTrainingVO;
import com.moorim.hr.client.vo.RecruitVO;
import com.moorim.hr.common.dao.AbstractDAO;
import com.moorim.hr.common.vo.PagingCommonVO;

@Repository
public class JobDAO extends AbstractDAO {
	
	private static Logger log = LoggerFactory.getLogger(JobDAO.class);
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	public List<Map> listTopJob(PagingCommonVO vo) {
		return (List<Map>) selectList("selectTopJobList", vo);
	}

	public List<Map> listJob(PagingCommonVO vo) {
		return (List<Map>) selectList("selectJobList", vo);
	}
	
	public int countJob(PagingCommonVO vo) {
		int totCount = (Integer) selectOne("selectJobCount", vo);
		return totCount;
	}
	
	public void updateHit(PagingCommonVO vo) {
		update("updateHit", vo);
	}

	public Map detailJob(PagingCommonVO vo) {
		return (Map) selectOne("selectJobDetail", vo);
	}
	
	public String getApplyCode(RecruitVO vo) {
		return (String) selectOne("selectApplyCode", vo);
	}
	
	public int checkReg(RecruitVO vo) {
		return (Integer) selectOne("selectCheckReg", vo);
	}
	
	public Map getPersonalInfo(RecruitVO vo) {
		return (Map) selectOne("selectRecApplyMaster", vo);
	}
	
	public List<Map> getKindOptions(RecruitNoticeOptionVO vo) {
		return (List<Map>) selectList("getKindOptions", vo);
	}

	public List<Map> getPartOptions(RecruitNoticeOptionVO vo) {
		return (List<Map>) selectList("getPartOptions", vo);
	}

	public List<Map> getAreaOptions(RecruitNoticeOptionVO vo) {
		return (List<Map>) selectList("getAreaOptions", vo);
	}
	
	public void insertApplyMaster(RecruitVO vo) {
		insert("insertApplyMaster", vo);
	}
	
	public void updateApplyMaster(RecruitVO vo) {
		update("updateApplyMaster", vo);
	}
	
	public int checkSchoolReg(RecruitVO vo) {
		return (Integer) selectOne("selectCheckSchoolReg", vo);
	}

	public int checkGradeReg(RecruitVO vo) {
		return (Integer) selectOne("selectCheckGradeReg", vo);
	}
	
	public List<Map> selectSchoolList(RecruitVO vo) {
		return (List<Map>) selectList("selectSchoolList", vo);
	}

	public List<Map> selectGradeList(RecruitVO vo) {
		return (List<Map>) selectList("selectGradeList", vo);
	}
	
	public void mergeApplySchool(RecruitSchoolVO vo) {
		update("mergeApplySchool", vo);
	}

	public void mergeApplyGrade(RecruitGradeVO vo) {
		update("mergeApplyGrade", vo);
	}
	
	public int checkCareerReg(RecruitVO vo) {
		return (Integer) selectOne("selectCheckCareerReg", vo);
	}
	
	public List<Map> selectCareerList(RecruitVO vo) {
		return (List<Map>) selectList("selectCareerList", vo);
	}
	
	public int checkTrainingReg(RecruitVO vo) {
		return (Integer) selectOne("selectCheckTrainingReg", vo);
	}
	
	public List<Map> selectTrainingList(RecruitVO vo) {
		return (List<Map>) selectList("selectTrainingList", vo);
	}
	
	public int checkLanguageReg(RecruitVO vo) {
		return (Integer) selectOne("selectCheckLanguageReg", vo);
	}
	
	public List<Map> selectLanguageList(RecruitVO vo) {
		return (List<Map>) selectList("selectLanguageList", vo);
	}
	
	public int checkCertReg(RecruitVO vo) {
		return (Integer) selectOne("selectCheckCertReg", vo);
	}
	
	public List<Map> selectCertList(RecruitVO vo) {
		return (List<Map>) selectList("selectCertList", vo);
	}
	
	public void deleteApplyCareer(RecruitVO vo) {
		delete("deleteApplyCareer", vo);
	}
	
	public void insertApplyCareer(RecruitCareerVO vo) {
		insert("insertApplyCareer", vo);
	}
	
	public void deleteApplyTraining(RecruitVO vo) {
		delete("deleteApplyTraining", vo);
	}

	public void insertApplyTraining(RecruitTrainingVO vo) {
		delete("insertApplyTraining", vo);
	}

	public void deleteApplyLanguage(RecruitVO vo) {
		delete("deleteApplyLanguage", vo);
	}

	public void insertApplyLanguage(RecruitLanguageVO vo) {
		insert("insertApplyLanguage", vo);
	}

	public void deleteApplyCert(RecruitVO vo) {
		delete("deleteApplyCert", vo);
	}

	public void insertApplyCert(RecruitCertVO vo) {
		insert("insertApplyCert", vo);
	}
	
	public List<Map> selectIntroList(RecruitVO vo) {
		return (List<Map>) selectList("selectIntroList", vo);
	}
	
	public String getApplyKindNm(RecruitVO vo) {
		return (String) selectOne("selectApplyKindNm", vo);
	}
	
	public int checkApplyIntroReg(RecruitVO vo) {
		return (Integer) selectOne("selectCheckApplyIntroReg", vo);
	}
	
	public List<Map> selectApplyIntroList(RecruitVO vo) {
		return (List<Map>) selectList("selectApplyIntroList", vo);
	}
	
	public void mergeApplyIntro(RecruitIntroVO vo) {
		update("mergeApplyIntro", vo);
	}
	
	public void updateStatus(RecruitVO vo) {
		update("updateStatus", vo);
	}
	
	public Map getApplyInfo(RecruitVO vo) {
		return (Map) selectOne("selectApplyInfo", vo);
	}
	
	public List<Map> getCurrentNoticeList() {
		return (List<Map>) selectList("selectCurrentNoticeList");
	}

	public Map appySelectOneInfo(RecruitVO vo) {
		return (Map) selectOne("appySelectOneInfo", vo);
	}

}
