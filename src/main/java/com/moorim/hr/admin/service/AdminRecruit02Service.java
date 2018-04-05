package com.moorim.hr.admin.service;

import java.util.List;
import java.util.Map;

import com.moorim.hr.admin.vo.AdminRecruitCareerVO;
import com.moorim.hr.admin.vo.AdminRecruitVO;
import com.moorim.hr.admin.vo.FaqVO;
import com.moorim.hr.admin.vo.MemberVO;
import com.moorim.hr.common.vo.PagingCommonVO;


public interface AdminRecruit02Service {
	
	@SuppressWarnings("rawtypes")
	public List<Map> selectHrUser(Map params);
	
	public int countHrUser(Map params);
	
	public Map processEvMember(MemberVO vo);
	
}
