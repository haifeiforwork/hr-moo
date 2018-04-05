package com.moorim.hr.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.moorim.hr.admin.vo.AdminRecruitCareerVO;
import com.moorim.hr.admin.vo.AdminRecruitVO;
import com.moorim.hr.admin.vo.AdminVolunteerVO;
import com.moorim.hr.client.vo.RecruitNoticeOptionVO;
import com.moorim.hr.common.dao.AbstractDAO;
import com.moorim.hr.common.vo.PagingCommonVO;


@Repository
public class AdminRecruitDAO extends AbstractDAO {
	private static Logger log = LoggerFactory.getLogger(AdminRecruitDAO.class);
	private int totCount = 0;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getMainRecruitNoticeList(HashMap<String, String> param) {
		return (List<Map>) selectList("getMainRecruitNoticeList",param);
	}
	
	@SuppressWarnings({ "rawtypes" })
	public Map getMainRecruitNoticeCnt() {
		return (Map) selectOne("getMainRecruitNoticeCnt");
	}
	
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectRec0001list(PagingCommonVO vo) {
		return (List<Map>) selectList("selectRec0001list", vo);
	}
	public int selectRec0001count(PagingCommonVO vo) {
		totCount = (Integer) selectOne("selectRec0001count", vo);
		return totCount;
	}
	
	@SuppressWarnings({ "rawtypes" })
	public Map selectRec0002Detail(PagingCommonVO vo) {
		return (Map) selectOne("selectRec0002Detail", vo);
	}
	
	public int deleteRec0001(AdminRecruitVO vo) {
		return (Integer) delete("deleteRec0001", vo);
	}
	public int insertRec0002(AdminRecruitVO vo) {
		return (Integer) insert("insertRec0002", vo);
	}
	public int updateRec0002(AdminRecruitVO vo) {
		return (Integer) update("updateRec0002", vo);
	}
	public int insertRec0002Career(AdminRecruitCareerVO cVo) {
		return (Integer) insert("insertRec0002Career", cVo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectRec0002DetailCareerList(PagingCommonVO vo) {
		return (List<Map>) selectList("selectRec0002DetailCareerList", vo);
	}
	public int deleteRec0002Career(AdminRecruitVO vo) {
		return (Integer) delete("deleteRec0002Career", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List selectRec0100list(PagingCommonVO vo) {
		return (List<Map>) selectList("selectRec0100list", vo);
	}
	
	public int selectRecRec0100count(PagingCommonVO vo) {
		totCount = (Integer) selectOne("selectRecRec0100count", vo);
		return totCount;
	}
	public int selectRecRec0100total() {
		totCount = (Integer) selectOne("selectRecRec0100total");
		return totCount;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List selectNoticeList() {
		return (List<Map>) selectList("selectNoticeList");
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectKindOptions(RecruitNoticeOptionVO vo) {
		return (List<Map>) selectList("selectKindOptions", vo);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectPartOptions(RecruitNoticeOptionVO vo) {
		return (List<Map>) selectList("selectPartOptions", vo);
	}
	
	
	@SuppressWarnings({ "rawtypes" })
	public Map selectRecruitDetail(AdminVolunteerVO vo) {
		return (Map) selectOne("selectAdminRecruitDetail", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectSchoolList(AdminVolunteerVO vo) {
		return (List<Map>) selectList("selectAdminSchoolList", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectGradeList(AdminVolunteerVO vo) {
		return (List<Map>) selectList("selectAdminGradeList", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectCareerList(AdminVolunteerVO vo) {
		return (List<Map>) selectList("selectAdminCareerList", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectTrainingList(AdminVolunteerVO vo) {
		return (List<Map>) selectList("selectAdminTrainingList", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectLanguageList(AdminVolunteerVO vo) {
		return (List<Map>) selectList("selectAdminLanguageList", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectCertList(AdminVolunteerVO vo) {
		return (List<Map>) selectList("selectAdminCertList", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> selectIntroList(AdminVolunteerVO vo) {
		return (List<Map>) selectList("selectAdminIntroList", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List selectAdminItemIntroList(AdminVolunteerVO vo) {
		return (List<Map>) selectList("selectAdminItemIntroList", vo);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List selectRec0300list(PagingCommonVO vo) {
		return (List<Map>) selectList("selectRec0300list", vo);
	}

	public int selectRecRec0300count(PagingCommonVO vo) {
		totCount = (Integer) selectOne("selectRecRec0300count", vo);
		return totCount;
	}

	public int updateRec0300(AdminVolunteerVO aVO) {
		return (Integer) update("updateRec0300",aVO);
	}

	public List selectEvalMember() {
		return (List<Map>) selectList("selectEvalMember");
	}
	
}