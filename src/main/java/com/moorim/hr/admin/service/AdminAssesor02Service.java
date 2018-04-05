package com.moorim.hr.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.moorim.hr.admin.vo.AdminRecruitCareerVO;
import com.moorim.hr.admin.vo.AdminRecruitVO;
import com.moorim.hr.admin.vo.AdminVolunteerVO;
import com.moorim.hr.client.vo.RecruitNoticeOptionVO;
import com.moorim.hr.common.vo.PagingCommonVO;


public interface AdminAssesor02Service {
	@SuppressWarnings("rawtypes")
	List<Map> selectDoc0201list(PagingCommonVO vo);
	int selectDoc0201count(PagingCommonVO vo);
	List<Map> selectDoc0201PopIntro(AdminVolunteerVO vo);
	List<Map> selectDoc0201PopItem(String idx);
	
	
	
}
