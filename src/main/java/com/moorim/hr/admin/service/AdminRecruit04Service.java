package com.moorim.hr.admin.service;

import java.util.List;
import java.util.Map;

import com.moorim.hr.admin.vo.AdminRecruitCareerVO;
import com.moorim.hr.admin.vo.AdminRecruitVO;
import com.moorim.hr.admin.vo.FaqVO;
import com.moorim.hr.admin.vo.IvGroupVO;
import com.moorim.hr.admin.vo.MemberVO;
import com.moorim.hr.common.vo.PagingCommonVO;


public interface AdminRecruit04Service {
	
	@SuppressWarnings("rawtypes")
	public List<Map> selectJobNotice();
	
	@SuppressWarnings("rawtypes")
	public List<Map> selectIvGroup(Map params);
	
	public int countIvGroup(Map params);
	
	public Map processIvGroup(IvGroupVO vo);
	
	@SuppressWarnings("rawtypes")
	public List<Map> getIvUser(Map params);
	
	
}
