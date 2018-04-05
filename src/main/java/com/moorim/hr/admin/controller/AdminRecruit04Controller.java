package com.moorim.hr.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.moorim.hr.admin.service.AdminRecruit02Service;
import com.moorim.hr.admin.service.AdminRecruit04Service;
import com.moorim.hr.admin.service.AdminRecruitService;
import com.moorim.hr.admin.service.MemberService;
import com.moorim.hr.admin.vo.AdminRecruitCareerVO;
import com.moorim.hr.admin.vo.AdminRecruitVO;
import com.moorim.hr.admin.vo.IvGroupVO;
import com.moorim.hr.admin.vo.MemberVO;
import com.moorim.hr.client.service.JobService;
import com.moorim.hr.common.CheckNull;
import com.moorim.hr.common.FileUtil;
import com.moorim.hr.common.SessionUtil;
import com.moorim.hr.common.TextUtil;
import com.moorim.hr.common.dao.ComCodeDAO;
import com.moorim.hr.common.vo.PagingCommonVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class AdminRecruit04Controller {
	private static Logger log = LoggerFactory.getLogger(AdminRecruit04Controller.class);
	
	@Autowired
	private AdminRecruit04Service recruit04Service;
	
	@Autowired
	private JobService jobService;
	
	
	@Autowired
	private MemberService memberService;
	@Autowired
	ComCodeDAO comCodeDao;
	
	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	@RequestMapping(value= "/admin/recruit/rec0400")
	public String rec0400(ModelMap model, @RequestParam Map<String, String> param, HttpServletRequest request) throws Exception
	{
		log.debug("====param"+param.toString());
		List<Map> rs = recruit04Service.selectJobNotice();
		
		List<Map> gList = recruit04Service.selectIvGroup(param);
		int total = recruit04Service.countIvGroup(param);
		
		model.addAttribute("rs", rs);
		model.addAttribute("total", total);
		model.addAttribute("gList", gList);
		
		return "/admin/recruit/rec0400";
	}

	
	@RequestMapping(value= "/admin/processIgGroup")
	public ModelAndView processIgGroup(IvGroupVO vo,  HttpServletRequest request) throws Exception
	{
		vo.setREG_ID(SessionUtil.getHomeLoginId(request));
		
//		resultMap = memberService.processMember(memberVo);
				
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("result", resultMap);
		log.debug(resultMap.toString());
		
		return mav;
	}
	
	@RequestMapping(value= "/admin/getIvUser")
	public ModelAndView getIvUser( @RequestParam Map<String, String> param, HttpServletRequest request) throws Exception
	{
		
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("result", recruit04Service.getIvUser(param));
		
		return mav;
	}
	
	
	
}
