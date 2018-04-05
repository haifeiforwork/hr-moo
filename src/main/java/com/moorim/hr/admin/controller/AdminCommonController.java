package com.moorim.hr.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import com.moorim.hr.admin.service.AdminCommonService;
import com.moorim.hr.admin.vo.AdminEvalItemVO;
import com.moorim.hr.admin.vo.AdminItemInterviewVO;
import com.moorim.hr.admin.vo.AdminItemIntroVO;
import com.moorim.hr.admin.vo.AdminMajorVO;
import com.moorim.hr.admin.vo.AdminMenuVO;
import com.moorim.hr.admin.vo.AdminPopupVO;
import com.moorim.hr.common.SessionUtil;
import com.moorim.hr.common.service.ComCodeService;
import com.moorim.hr.common.vo.PagingCommonVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class AdminCommonController {
	private static Logger log = LoggerFactory.getLogger(AdminCommonController.class);
	
	@Autowired
	private AdminCommonService adminCommonService;
	
	@Autowired
	ComCodeService comCodeService;
	
	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	/**
	 * 관리자 - 시스템관리 - 메뉴관리 - 조회
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/menu")
	public String adminMenu(ModelMap model, HttpServletRequest request, @ModelAttribute AdminMenuVO vo) throws Exception
	{	
		@SuppressWarnings("rawtypes")
		List<Map> rsList = adminCommonService.getMenuList(vo);
		
		model.addAttribute("rsList", rsList);
		return "/admin/common/menu";
	}
	
	/**
	 * 관리자 - 시스템관리 - 메뉴관리 - 삭제
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/deleteMenu", method = RequestMethod.POST)
	public ModelAndView deleteMenu(@ModelAttribute AdminMenuVO vo, HttpServletRequest request) throws Exception
	{	
    	resultMap = new HashMap();
		resultMap = adminCommonService.deleteMenu(vo);
		log.debug(resultMap.toString());
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	/**
	 * 관리자 - 시스템관리 - 메뉴관리 - 상세
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/menuDetail", method = RequestMethod.POST)
	public ModelAndView menuDetail(@ModelAttribute AdminMenuVO vo, HttpServletRequest request) throws Exception
	{	
    	resultMap = new HashMap();
		resultMap = adminCommonService.menuDetail(vo);
		log.debug(resultMap.toString());
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	/**
	 * 관리자 - 시스템관리 - 메뉴관리 - 최종 index
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/getMenuAddCatCode", method = RequestMethod.POST)
	public ModelAndView getMenuAddCatCode(@ModelAttribute AdminMenuVO vo, HttpServletRequest request) throws Exception
	{	
    	resultMap = new HashMap();
		resultMap = adminCommonService.getMenuAddCatCode(vo);
		log.debug(resultMap.toString());
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	
	/**
	 * 관리자 - 시스템관리 - 메뉴관리 - 수정 입력
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/menuProcess", method = RequestMethod.POST)
	public ModelAndView menuProcess(@Valid AdminMenuVO vo
								  , BindingResult bindingResult
			                      , HttpServletRequest request) throws Exception
	{	
		String result = "success";
    	String msg = "";
    	
    	resultMap = new HashMap();
    	boolean isbool = adminCommonService.menuProcess(vo);
    	
    	if(!isbool){
    		msg = "삭제 에러";
    		result = "fail";
    		resultMap.put("msg", msg);
    		resultMap.put("result", result);
    	}
    	
		log.debug(resultMap.toString());
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	
		
	/**
	 * 관리자 - 시스템관리 - 항목 관리 - 자기소개서 조회
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/itm0001")
	public String itm0001(ModelMap model, HttpServletRequest request, @RequestParam HashMap<String, String> param) throws Exception
	{
		@SuppressWarnings("rawtypes")
		List<Map> rsList = adminCommonService.selectItm0001list(param);
		model.addAttribute( "rsList", rsList );
		
		return "/admin/common/itm0001";
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
	@RequestMapping(value= "/admin/common/itm0001Pop")
	public String itm0001Pop(ModelMap model, HttpServletRequest request, @ModelAttribute AdminItemIntroVO vo) throws Exception
	{
		if("mod".equals(vo.getProcType())){
			Map rs = adminCommonService.selectItm0001PopDetail(vo);
			model.addAttribute("rs", rs);
		}
		
		model.addAttribute("procType", vo.getProcType());
		return "/admin/common/itm0001Pop";
	}
	
	
	
	/**
	 * 관리자 - 시스템관리 - 항목 관리 - 자기소개서 삭제
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/deleteItm0001Pop", method = RequestMethod.POST)
	public ModelAndView deleteItm0001Pop(@ModelAttribute AdminItemIntroVO vo, HttpServletRequest request) throws Exception
	{	
    	resultMap = new HashMap();
		resultMap = adminCommonService.deleteItm0001Pop(vo);
		log.debug(resultMap.toString());
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	/**
	 * 관리자 - 시스템관리 - 항목 관리 - 자기소개서 입력
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/insertItm0001Pop", method = RequestMethod.POST)
	public ModelAndView insertItm0001Pop(@Valid AdminItemIntroVO vo
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
			 * 등록자아이디 / 등록자 이름 세팅
			 * **************************************/
			vo.setRegId(SessionUtil.getHomeLoginId(request));
			
			/***************************************
			 * 프로세스
			 * **************************************/
			boolean isSuccess = adminCommonService.insertItm0001Pop(vo);
			
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
	 * 관리자 - 시스템관리 - 항목 관리 - 자기소개서 수정
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/updateItm0001Pop", method = RequestMethod.POST)
	public ModelAndView updateItm0001Pop(@Valid AdminItemIntroVO vo
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
			 * 등록자아이디 / 등록자 이름 세팅
			 * **************************************/
			vo.setRegId(SessionUtil.getHomeLoginId(request));
			
			/***************************************
			 * 프로세스
			 * **************************************/
			boolean isSuccess = adminCommonService.updateItm0001Pop(vo);
			
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
	 * 관리자 - 시스템관리 - 항목 관리 - 인성항목 조회
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/itm0002")
	public String itm0002(ModelMap model, HttpServletRequest request, @ModelAttribute("pCommon") PagingCommonVO vo) throws Exception
	{
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageNo()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getRows()); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(vo.getPageSize()); //페이징 리스트의 사이즈
		
		int firstRecordIndex = paginationInfo.getFirstRecordIndex()+1;
		int lastRecordIndex = paginationInfo.getLastRecordIndex();
		vo.setFirstIndex(firstRecordIndex);
		vo.setLastIndex(lastRecordIndex );
		vo.setSKEY_1("51020");
		@SuppressWarnings("rawtypes")
		List<Map> rsList = adminCommonService.selectItm0002list(vo);
		
		int cnt = adminCommonService.selectItm0002Count(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		
		return "/admin/common/itm0002";
	}
	
	/**
	 * 관리자 - 시스템관리 - 항목 관리 - 인성항목 팝업
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/itm0002Pop")
	public String itm0002Pop(ModelMap model, HttpServletRequest request, @ModelAttribute AdminItemInterviewVO vo) throws Exception
	{
		Map code = new HashMap();
		
		/***************************************
		 * 코드 세팅
		 * **************************************/
		code.put("code60", comCodeService.getCodeByGroup("60")); // 인성면접 문항요소
		
		if("mod".equals(vo.getProcType())){
			Map rs = adminCommonService.selectItm0002PopDetail(vo);
			model.addAttribute("rs", rs);
		}
		
		model.addAttribute("procType", vo.getProcType());
		model.addAttribute("code", code);
		return "/admin/common/itm0002Pop";
	}
	
	
	
	/**
	 * 관리자 - 시스템관리 - 항목 관리 - 인성항목 삭제
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/deleteItm0002Pop", method = RequestMethod.POST)
	public ModelAndView deleteItm0002Pop(@ModelAttribute AdminItemInterviewVO vo, HttpServletRequest request) throws Exception
	{	
    	resultMap = new HashMap();
		resultMap = adminCommonService.deleteItm0002Pop(vo);
		log.debug(resultMap.toString());
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	/**
	 * 관리자 - 시스템관리 - 항목 관리 - 인성항목 입력
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/insertItm0002Pop", method = RequestMethod.POST)
	public ModelAndView insertItm0002Pop(@Valid AdminItemInterviewVO vo
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
			boolean isSuccess = adminCommonService.insertItm0002Pop(vo);
			
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
	 * 관리자 - 시스템관리 - 항목 관리 - 인성항목 수정
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/updateItm0002Pop", method = RequestMethod.POST)
	public ModelAndView updateItm0002Pop(@Valid AdminItemInterviewVO vo
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
			boolean isSuccess = adminCommonService.updateItm0002Pop(vo);
			
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
	 * 관리자 - 시스템관리 - 항목 관리 - 직무항목 조회
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/itm0003")
	public String itm0003(ModelMap model, HttpServletRequest request, @ModelAttribute("pCommon") PagingCommonVO vo) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageNo()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getRows()); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(vo.getPageSize()); //페이징 리스트의 사이즈
		
		int firstRecordIndex = paginationInfo.getFirstRecordIndex()+1;
		int lastRecordIndex = paginationInfo.getLastRecordIndex();
		vo.setFirstIndex(firstRecordIndex);
		vo.setLastIndex(lastRecordIndex );
		vo.setSKEY_1("51030");
		@SuppressWarnings("rawtypes")
		List<Map> rsList = adminCommonService.selectItm0002list(vo);
		
		int cnt = adminCommonService.selectItm0002Count(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		
		return "/admin/common/itm0003";
	}
	
	/**
	 * 관리자 - 시스템관리 - 항목 관리 - 직무항목 팝업
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/itm0003Pop")
	public String itm0003Pop(ModelMap model, HttpServletRequest request, @ModelAttribute AdminItemInterviewVO vo) throws Exception
	{	
		Map code = new HashMap();
		
		/***************************************
		 * 코드 세팅
		 * **************************************/
		code.put("code61", comCodeService.getCodeByGroup("61")); // 직무면접 문항요소
		
		if("mod".equals(vo.getProcType())){
			Map rs = adminCommonService.selectItm0002PopDetail(vo);
			model.addAttribute("rs", rs);
		}
		
		model.addAttribute("code", code);
		model.addAttribute("procType", vo.getProcType());
		return "/admin/common/itm0003Pop";
	}
	
	/**
	 * 관리자 - 공통관리 - 학과등록 - 조회
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/com0101")
	public String Com0101(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
	{	
		Map code = new HashMap();
		
		/***************************************
		 * 코드 세팅
		 * **************************************/
		code.put("code15", comCodeService.getCodeByGroup("15")); // 전공계열
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageNo()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getRows()); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(vo.getPageSize()); //페이징 리스트의 사이즈
		
		int firstRecordIndex = paginationInfo.getFirstRecordIndex()+1;
		int lastRecordIndex = paginationInfo.getLastRecordIndex();
		vo.setFirstIndex(firstRecordIndex);
		vo.setLastIndex(lastRecordIndex );
		
		@SuppressWarnings("rawtypes")
		List<Map> rsList = adminCommonService.selectCom0101List(vo);
		
		int cnt = adminCommonService.selectCom0101Count(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		model.addAttribute( "code", code );
		
		return "/admin/common/com0101";
	}
	
	/**
	 * 관리자 - 공통관리 - 학과등록 - 상세
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/com0101Detail", method = RequestMethod.POST)
	public ModelAndView com0101Detail(@ModelAttribute AdminMajorVO vo, HttpServletRequest request) throws Exception
	{	
    	resultMap = new HashMap();
		resultMap = adminCommonService.com0101Detail(vo);
		log.debug(resultMap.toString());
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	/**
	 * 관리자 - 공통관리 - 학과등록 - 학과 삭제
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/deleteCom0101", method = RequestMethod.POST)
	public ModelAndView deleteCom0101(@ModelAttribute AdminMajorVO vo, HttpServletRequest request) throws Exception
	{	
    	resultMap = new HashMap();
		resultMap = adminCommonService.deleteCom0101(vo);
		log.debug(resultMap.toString());
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	/**
	 * 관리자 - 공통관리 - 학과등록 - 등록 팝업
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/com0101Pop")
	public String com0101Pop(ModelMap model, HttpServletRequest request, @ModelAttribute AdminMajorVO vo) throws Exception
	{
		Map code = new HashMap();
		
		/***************************************
		 * 코드 세팅
		 * **************************************/
		code.put("code15", comCodeService.getCodeByGroup("15")); // 전공계열
		
		model.addAttribute( "code", code );
		return "/admin/common/com0101Pop";
	}
	
	/**
	 * 관리자 - 공통관리 - 학과등록 - 입력
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/insertCom0101Pop", method = RequestMethod.POST)
	public ModelAndView insertCom0101Pop(@Valid AdminMajorVO vo
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
			
			boolean isSuccess = adminCommonService.insertCom0101Pop(vo);
			
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
	 * 관리자 - 공통관리 - 학과등록 - 수정
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/updateCom0101", method = RequestMethod.POST)
	public ModelAndView updateCom0101(@Valid AdminMajorVO vo
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
			boolean isSuccess = adminCommonService.updateCom0101(vo);
			
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
	 * 관리자 - 시스템관리 - 평가항목 관리 - 자기소개서
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/itm0101")
	public String itm0101(ModelMap model, HttpServletRequest request, @ModelAttribute("pCommon") PagingCommonVO vo) throws Exception
	{
		@SuppressWarnings("rawtypes")
		List<Map> rsList = adminCommonService.selectItm0101list(vo);
		model.addAttribute( "rsList", rsList );
		
		return "/admin/common/itm0101";
	}
	
	/**
	 * 관리자 - 시스템관리 - 평가항목 관리 - 자기소개서 등록팝업
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/itm0101Pop")
	public String itm0101Pop(ModelMap model, HttpServletRequest request, @ModelAttribute AdminEvalItemVO vo) throws Exception
	{
		HashMap<String, String> param = new HashMap<String, String>();
		
		if("mod".equals(vo.getProcType())){
			Map rs = adminCommonService.selectItm0101PopDetail(vo);
			model.addAttribute("rs", rs);
		}
		
		model.addAttribute("procType", vo.getProcType());
		model.addAttribute("item", adminCommonService.selectItm0001list(param)); // 문항요소
		return "/admin/common/itm0101Pop";
	}
	
	/**
	 * 관리자 - 시스템관리 - 평가항목 관리 - 인성면접
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/itm0102")
	public String itm0102(ModelMap model, HttpServletRequest request, @ModelAttribute("pCommon") PagingCommonVO vo) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageNo()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getRows()); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(vo.getPageSize()); //페이징 리스트의 사이즈
		
		int firstRecordIndex = paginationInfo.getFirstRecordIndex()+1;
		int lastRecordIndex = paginationInfo.getLastRecordIndex();
		vo.setFirstIndex(firstRecordIndex);
		vo.setLastIndex(lastRecordIndex );
		vo.setSKEY_1("51020");
		@SuppressWarnings("rawtypes")
		List<Map> rsList = adminCommonService.selectItm0002list(vo);
		
		int cnt = adminCommonService.selectItm0002Count(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		
		return "/admin/common/itm0102";
	}
	
	/**
	 * 관리자 - 시스템관리 - 평가항목 관리 - 인성면접 팝업
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/itm0102Pop")
	public String itm0102Pop(ModelMap model, HttpServletRequest request, @ModelAttribute AdminItemInterviewVO vo) throws Exception
	{
		Map rs = adminCommonService.selectItm0002PopDetail(vo);
		@SuppressWarnings("rawtypes")
		List<Map> rsList = adminCommonService.selectItm0102PopItemList(vo);
		
		model.addAttribute("rs", rs);
		model.addAttribute("rsList", rsList);
		model.addAttribute("procType", vo.getProcType());
		return "/admin/common/itm0102Pop";
	}
	
	/**
	 * 관리자 - 시스템관리 - 평가항목 관리 - 직무면접
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/itm0103")
	public String itm0103(ModelMap model, HttpServletRequest request, @ModelAttribute("pCommon") PagingCommonVO vo) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageNo()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getRows()); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(vo.getPageSize()); //페이징 리스트의 사이즈
		
		int firstRecordIndex = paginationInfo.getFirstRecordIndex()+1;
		int lastRecordIndex = paginationInfo.getLastRecordIndex();
		vo.setFirstIndex(firstRecordIndex);
		vo.setLastIndex(lastRecordIndex );
		vo.setSKEY_1("51030");
		@SuppressWarnings("rawtypes")
		List<Map> rsList = adminCommonService.selectItm0002list(vo);
		
		int cnt = adminCommonService.selectItm0002Count(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		
		return "/admin/common/itm0103";
	}
	
	/**
	 * 관리자 - 시스템관리 - 평가항목 관리 - 직무면접 팝업
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/itm0103Pop")
	public String itm0103Pop(ModelMap model, HttpServletRequest request, @ModelAttribute AdminItemInterviewVO vo) throws Exception
	{
		Map rs = adminCommonService.selectItm0002PopDetail(vo);
		@SuppressWarnings("rawtypes")
		List<Map> rsList = adminCommonService.selectItm0102PopItemList(vo);
		
		model.addAttribute("rs", rs);
		model.addAttribute("rsList", rsList);
		model.addAttribute("procType", vo.getProcType());
		return "/admin/common/itm0103Pop";
	}
	
	/**
	 * 관리자 - 시스템관리 - 항목 관리 - 수정 및 입력 프로세스
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/evalItmProcess", method = RequestMethod.POST)
	public ModelAndView evalItmProcess(@Valid AdminEvalItemVO vo
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
			boolean isSuccess = adminCommonService.evalItmProcess(vo);
			
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
	 * 관리자 - 시스템관리 - 항목 관리 - 삭제
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/evalItmDelete", method = RequestMethod.POST)
	public ModelAndView evalItmDelete(@ModelAttribute AdminEvalItemVO vo, HttpServletRequest request) throws Exception
	{	
    	resultMap = new HashMap();
		resultMap = adminCommonService.evalItmDelete(vo);
		log.debug(resultMap.toString());
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	/**
	 * 관리자 - 시스템관리 - 팝업관리
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/popupManage")
	public String popupManage(ModelMap model, HttpServletRequest request, @ModelAttribute("pCommon") PagingCommonVO vo) throws Exception
	{
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageNo()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getRows()); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(vo.getPageSize()); //페이징 리스트의 사이즈
		
		int firstRecordIndex = paginationInfo.getFirstRecordIndex()+1;
		int lastRecordIndex = paginationInfo.getLastRecordIndex();
		vo.setFirstIndex(firstRecordIndex);
		vo.setLastIndex(lastRecordIndex );
		@SuppressWarnings("rawtypes")
		List<Map> rsList = null; //adminCommonService.selectPopupManageList(vo);
		
		int cnt =0;// adminCommonService.selectPopupManageCount(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		
		return "/admin/common/popupManage";
	}
	
	/**
	 * 관리자 - 시스템관리 - 항목 관리 - 삭제
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/deletePopup", method = RequestMethod.POST)
	public ModelAndView deletePopup(@ModelAttribute AdminPopupVO vo, HttpServletRequest request) throws Exception
	{	
    	resultMap = new HashMap();
		resultMap = adminCommonService.deletePopup(vo);
		log.debug(resultMap.toString());
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	/**
	 * 관리자 - 시스템관리 - 팝업관리
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/common/popupManageForm")
	public String popupManageForm(ModelMap model, HttpServletRequest request, @ModelAttribute("pCommon") PagingCommonVO vo) throws Exception
	{
		String procType = request.getParameter("procType");
		if("mod".equals(procType)){
			Map rs = adminCommonService.PopupManageForm(vo);
			model.addAttribute( "rs", rs );
		}
		
		model.addAttribute("procType", procType);
		return "/admin/common/popupManageForm";
	}
	
	/**
	 * 관리자 - 시스템관리 - 항목 관리 - 수정 및 입력 프로세스
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/common/PopupManageProcess", method = RequestMethod.POST)
	public ModelAndView PopupManageProcess(@Valid AdminPopupVO vo
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
			boolean isSuccess = adminCommonService.PopupManageProcess(vo);
			
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
	
	
	
	
}
