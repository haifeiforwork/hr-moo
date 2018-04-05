package com.moorim.hr.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.moorim.hr.admin.service.AdminAssesor02Service;
import com.moorim.hr.admin.service.AdminRecruitService;
import com.moorim.hr.admin.vo.AdminVolunteerVO;
import com.moorim.hr.common.service.ComCodeService;
import com.moorim.hr.common.vo.PagingCommonVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class AdminAssesor02Controller {
	private static Logger log = LoggerFactory.getLogger(AdminAssesor02Controller.class);
	
	@Autowired
	private AdminAssesor02Service assesorService;
	
	@Autowired
	private AdminRecruitService recruitService;
	
	@Autowired
	ComCodeService comCodeService;
	
	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	/**
	 * 관리자 - 채용관리 - 지원자관리
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/assesor/doc0201")
	public String doc0201(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
	{
		/***************************************
		 * 코드 세팅
		 * **************************************/
		Map code = new HashMap();
		code.put("code40", comCodeService.getCodeByGroup("40")); // 채용구분
		
		String SKEY_1 = request.getParameter("SKEY_1");
		List<Map> rsList = null;
		int cnt =0;
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageNo()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getRows()); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(vo.getPageSize()); //페이징 리스트의 사이즈
		
		int firstRecordIndex = paginationInfo.getFirstRecordIndex()+1;
		int lastRecordIndex = paginationInfo.getLastRecordIndex();
		vo.setFirstIndex(firstRecordIndex);
		vo.setLastIndex(lastRecordIndex );
		
		if(SKEY_1 != null && !"".equals(SKEY_1)){
			rsList = assesorService.selectDoc0201list(vo);
			cnt = assesorService.selectDoc0201count(vo);
		}
		
		paginationInfo.setTotalRecordCount(cnt);
		
		model.addAttribute( "notice", recruitService.selectNoticeList());
		model.addAttribute( "code" , code);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		return "/admin/assesor/doc0201";
	}
	
	/**
	 * 관리자 - 시스템관리 - 항목 관리 - 자기소개서 팝업
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/assesor/doc0201Pop")
	public String doc0201Pop(ModelMap model, HttpServletRequest request, @ModelAttribute AdminVolunteerVO vo) throws Exception
	{	
		
		@SuppressWarnings("rawtypes")
		Map rs1 = recruitService.selectRecruitDetail(vo);
		
		List<Map> introList = assesorService.selectDoc0201PopIntro(vo);
		List rs = new ArrayList();
		for(Map map : introList){
			String idx = String.valueOf(map.get("IDX"));
			if(!"null".equals(idx)){
				List<Map> itemList = assesorService.selectDoc0201PopItem(idx);
				rs.add(itemList);
			}
		}
		
		model.addAttribute("introList", introList);
		model.addAttribute("itemList", rs);
		model.addAttribute("rs", rs1);
		model.addAttribute("vo", vo);
		return "/admin/assesor/doc0201Pop";
	}
	
}
