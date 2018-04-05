package com.moorim.hr.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.servlet.ModelAndView;

import com.moorim.hr.admin.service.AdminRecruitService;
import com.moorim.hr.admin.vo.AdminRecruitCareerVO;
import com.moorim.hr.admin.vo.AdminRecruitVO;
import com.moorim.hr.admin.vo.AdminVolunteerVO;
import com.moorim.hr.client.vo.RecruitNoticeOptionVO;
import com.moorim.hr.common.CheckNull;
import com.moorim.hr.common.SessionUtil;
import com.moorim.hr.common.TextUtil;
import com.moorim.hr.common.service.ComCodeService;
import com.moorim.hr.common.vo.PagingCommonVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class AdminRecruit03Controller {
	private static Logger log = LoggerFactory.getLogger(AdminRecruit03Controller.class);
	
	@Autowired
	private AdminRecruitService recruitService;
	
	@Autowired
	ComCodeService comCodeService;
	
	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	/**
	 * 관리자 - 채용관리 - 서류전형[시스템평가] - 조회
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/recruit/rec0300")
	public String rec0300(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
	{
		/***************************************
		 * 코드 세팅
		 * **************************************/
		Map code = new HashMap();
		code.put("code50", comCodeService.getCodeByGroup("50")); // 지원상태
		
		String SKEY_1 = request.getParameter("SKEY_1");
		String SKEY_2 = request.getParameter("SKEY_2");
		
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
			if(SKEY_2 == null && "".equals(SKEY_2)){
				SKEY_2 = "50002";
				vo.setSKEY_2(SKEY_2);
			}
			rsList = recruitService.selectRec0300list(vo);
			cnt = recruitService.selectRecRec0300count(vo);
		}
		
		paginationInfo.setTotalRecordCount(cnt);
		
		model.addAttribute( "notice", recruitService.selectNoticeList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("code", code);
		model.addAttribute( "rsList", rsList );
		return "/admin/recruit/rec0300";
	}
	
	
	/**
	 * 관리자 - 공고관리 - 서류전형[시스템평가] - 수정 프로세스
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/recruit/updateRec0300", method = RequestMethod.POST)
	public ModelAndView updateRec0300(@Valid AdminVolunteerVO vo
			                        , BindingResult bindingResult
			                        , HttpServletRequest request) throws Exception
	{
    	resultMap = new HashMap();
    	
    	if(bindingResult.hasErrors()) {
			log.error("saveApplyCareer Binding Result has error!");
			List<ObjectError> errors = bindingResult.getAllErrors();
			for(ObjectError error : errors) {
				log.error("{} : {}", error.getObjectName(), error.getDefaultMessage());
			}
			
			resultMap.put("errors", errors);
			resultMap.put("result", "fail");
		} else {
			
			
			/***************************************
			 * 프로세스
			 * **************************************/
			boolean isSuccess = recruitService.updateRec0300(vo, vo.getVolList());
			
			if(isSuccess) {
				resultMap.put("msg", "저장되었습니다.");
				resultMap.put("result", "success");
			} else {
				resultMap.put("msg", "저장에 실패하였습니다.");
				resultMap.put("result", "fail");
			}
		}
    	
		
		log.debug(resultMap.toString());
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	/**
	 * 관리자 - 채용관리 - 서류전형[시스템평가] - 조회
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/recruit/rec0301")
	public String rec0301(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		/***************************************
		 * 코드 세팅
		 * **************************************/
		Map code = new HashMap();
		code.put("code50", comCodeService.getCodeByGroup("50")); // 지원상태
		
		String SKEY_1 = request.getParameter("SKEY_1");
		String SKEY_2 = request.getParameter("SKEY_2");
		
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
			if(SKEY_2 == null){
				SKEY_2 = "50003";
				vo.setSKEY_2(SKEY_2);
			}
			rsList = recruitService.selectRec0300list(vo);
			cnt = recruitService.selectRecRec0300count(vo);
		}
		
		paginationInfo.setTotalRecordCount(cnt);
		
		model.addAttribute( "evalMem", recruitService.selectEvalMember());
		model.addAttribute( "notice", recruitService.selectNoticeList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("code", code);
		model.addAttribute( "rsList", rsList );
		return "/admin/recruit/rec0301";
	}
	
}
