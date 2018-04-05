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
import com.moorim.hr.admin.service.AdminRecruitService;
import com.moorim.hr.admin.service.MemberService;
import com.moorim.hr.admin.vo.AdminRecruitCareerVO;
import com.moorim.hr.admin.vo.AdminRecruitVO;
import com.moorim.hr.admin.vo.MemberVO;
import com.moorim.hr.common.CheckNull;
import com.moorim.hr.common.FileUtil;
import com.moorim.hr.common.SessionUtil;
import com.moorim.hr.common.TextUtil;
import com.moorim.hr.common.dao.ComCodeDAO;
import com.moorim.hr.common.vo.PagingCommonVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class AdminRecruit02Controller {
	private static Logger log = LoggerFactory.getLogger(AdminRecruit02Controller.class);
	
	@Autowired
	private AdminRecruit02Service recruit02Service;
	
	@Autowired
	private MemberService memberService;
	@Autowired
	ComCodeDAO comCodeDao;
	
	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	/**
	 * 관리자 - 채용관리 - 평가위원등록 임직원조회
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * 
	 */
	@RequestMapping(value= "/admin/recruit/selHrUser")
	public ModelAndView selectHrUser(ModelMap model,
			//@RequestParam("searchType") String searchType,
			//@RequestParam("SKEY_1") String SKEY_1,
			HttpServletRequest request) throws Exception
	{
		String searchType = request.getParameter("searchType");
		String searchKey = request.getParameter("searchKey");
		log.debug(searchType);
		log.debug(searchKey);
		
		PagingCommonVO vo = new PagingCommonVO();
		vo.setSearchType(searchType);
		vo.setSKEY_1(searchKey);
		
		@SuppressWarnings("rawtypes")
		List<Map> rsList = memberService.listEpMember(vo);
		
		int cnt = memberService.countEpMember(vo);
		
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("total", cnt);
		mav.addObject("rows", rsList);
    	mav.setViewName("jsonView");
    	
		
		return mav;
	}
	
	@RequestMapping(value= "/admin/recruit/rec0200")
	public String rec0200(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageNo()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getRows()); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(vo.getPageSize()); //페이징 리스트의 사이즈
		
		int firstRecordIndex = paginationInfo.getFirstRecordIndex()+1;
		int lastRecordIndex = paginationInfo.getLastRecordIndex();
		vo.setFirstIndex(firstRecordIndex);
		vo.setLastIndex(lastRecordIndex );
		
		vo.setSearchType("EV");
		
		@SuppressWarnings("rawtypes")
		List<Map> rsList = memberService.listMember(vo);
		
		int cnt = memberService.cntMember(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		
		return "/admin/recruit/rec0200";
	}
	
	@RequestMapping(value= "/admin/processEvMember")
	public ModelAndView processEvMember(MemberVO memberVo,  HttpServletRequest request) throws Exception
	{
		memberVo.setReg_id(SessionUtil.getHomeLoginId(request));
		memberVo.setMod_id(SessionUtil.getHomeLoginId(request));
		memberVo.setUser_auth("90003");
		
		
		resultMap = memberService.processMember(memberVo);
				
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("result", resultMap);
		log.debug(resultMap.toString());
		
		return mav;
	}
	
	
	
	
}
