package com.moorim.hr.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.moorim.hr.admin.vo.AdminRecruitCareerVO;
import com.moorim.hr.admin.vo.AdminRecruitVO;
import com.moorim.hr.admin.vo.AdminVolunteerVO;
import com.moorim.hr.client.vo.RecruitNoticeOptionVO;
import com.moorim.hr.common.vo.PagingCommonVO;


public interface AdminRecruitService {
	@SuppressWarnings("rawtypes")
	public List<Map> getMainRecruitNoticeList(HashMap<String, String> param);
	public Map getMainRecruitNoticeCnt();
	
	/*공고관리*/
	@SuppressWarnings("rawtypes")
	public List<Map> selectRec0001list(PagingCommonVO vo);
	public int selectRec0001count ( PagingCommonVO vo );
	@SuppressWarnings("rawtypes")
	public Map selectRec0002Detail ( PagingCommonVO vo );
	public Map deleteRec0001(AdminRecruitVO vo);
	public boolean insertRec0002(AdminRecruitVO vo, List<AdminRecruitCareerVO> careerList);
	public List selectRec0002DetailCareerList(PagingCommonVO vo);
	public boolean updateRec0002(AdminRecruitVO vo, List<AdminRecruitCareerVO> careerList);

	/*채용관리*/
	public List<Map> selectRec0100list(PagingCommonVO vo);
	public int selectRecRec0100count(PagingCommonVO vo);
	public int selectRecRec0100total();
	public List<Map> selectNoticeList();
	public List<Map> selectKindOptions(RecruitNoticeOptionVO vo);
	public List<Map> selectPartOptions(RecruitNoticeOptionVO vo);
	public Map selectRecruitDetail(AdminVolunteerVO vo);
	public List<Map> selectSchoolList(AdminVolunteerVO vo);
	public List<Map> selectGradeList(AdminVolunteerVO vo);
	public List<Map> selectCareerList(AdminVolunteerVO vo);
	public List<Map> selectTrainingList(AdminVolunteerVO vo);
	public List<Map> selectLanguageList(AdminVolunteerVO vo);
	public List<Map> selectCertList(AdminVolunteerVO vo);
	public List<Map> selectIntroList(AdminVolunteerVO vo);
	public List<Map> selectAdminItemIntroList(AdminVolunteerVO vo);
	
	/*서류전형*/
	public List<Map> selectRec0300list(PagingCommonVO vo);
	public int selectRecRec0300count(PagingCommonVO vo);
	public boolean updateRec0300(AdminVolunteerVO vo, List<AdminVolunteerVO> volList);
	public List<Map> selectEvalMember();
	
	
}
