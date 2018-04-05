package com.moorim.hr.admin.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.moorim.hr.admin.service.AdminFaqService;
import com.moorim.hr.admin.vo.FaqVO;
import com.moorim.hr.common.SessionUtil;
import com.moorim.hr.common.vo.PagingCommonVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class AdminFaqController {
	private static Logger log = LoggerFactory.getLogger(AdminFaqController.class);
	
	@Autowired
	private AdminFaqService faqService;
	
	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	/**
	 * 관리자 - 채용문의관리 - FAQ관리 - 조회화면
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/faq/faq0001")
	public String faq0001(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
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
		List<Map> rsList = faqService.selectFaq0001List(vo);
		
		int cnt = faqService.selectFaq0001Count(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		
		return "/admin/faq/faq0001";
	}
	
	/**
	 * 관리자 - 채용문의관리 - FAQ관리 - 등록 및 수정
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value = "/admin/faq/faq0002")
	public String faq0002(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
	{
		String idx = request.getParameter("idx");
		vo.setIdx(idx);
		
		String procType = "mod";
		Map rs = new HashMap();
		if("".equals(idx) || idx == null) {
			procType = "new";
		}else{
			rs = faqService.selectFaq0002Detail(vo);
			if(rs == null) {
				procType = "new";
			}
		}
		log.debug("=======procType:"+procType);
		/*
		Vector realFileName = new Vector();
		Vector systemFileName = new Vector();
		Vector fileSize = new Vector();
		Vector fileType = new Vector();

		if(rs != null){
			String fileInfo = (String)rs.get("ATT_FILE");
			if(fileInfo != null){
				List fileList = TextUtil.getFileInfo(fileInfo);
				if(fileList != null){
					for(int i=0; i<fileList.size(); i++){
						Map fileMap = (Map) fileList.get(i);
						realFileName.addElement(CheckNull.checkString((String)fileMap.get("file_realname")));
						systemFileName.addElement(CheckNull.checkString((String)fileMap.get("file_sysname")));
						fileSize.addElement(CheckNull.checkString((String)fileMap.get("file_size")));
						fileType.addElement(CheckNull.checkString((String)fileMap.get("file_type")));
					}
				}
			}
		}
		*/
		
		model.addAttribute("vo", vo);
		model.addAttribute("procType", procType);
		model.addAttribute("rs", rs);
		//model.addAttribute("fileUpload", TextUtil.getFileUpload(3, realFileName, systemFileName, fileSize, fileType, "faq", true, false));
		
		return "/admin/faq/faq0002";
	}
	
	/**
	 * 관리자 - 채용문의관리 - FAQ관리 - 등록,수정,삭제 프로세스
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/faq/faqProcess", method = RequestMethod.POST)
	public ModelAndView processQna(FaqVO vo, HttpServletRequest request) throws Exception
	{
    	resultMap = new HashMap();
    	/***************************************
		 * 등록자아이디 / 등록자 이름 세팅
		 * **************************************/
		vo.setRegId(SessionUtil.getHomeLoginId(request));
		vo.setModId(SessionUtil.getHomeLoginId(request));
		vo.setModName(SessionUtil.getHomeLoginName(request));
    	
		resultMap = faqService.processFaq(vo);
		log.debug(resultMap.toString());
		log.debug("---------------["+vo.getProcType()+"]");
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 관리자 - 채용문의관리 - FAQ관리 - 조회화면
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/faq/faq0001easy")
	public String faq0001easy(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
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
		List<Map> rsList = faqService.selectFaq0001List(vo);
		
		int cnt = faqService.selectFaq0001Count(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		
		return "/admin/faq/faq0001easy";
	}
	
	/**
	 * 관리자 - 채용문의관리 - FAQ관리 - 조회화면
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/faq/faq0001Select")
	public ModelAndView faq0001Select(ModelMap model,@ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request,@RequestParam HashMap<String, String> param) throws Exception
	{
		
		int page = Integer.parseInt(request.getParameter("page"));
		int rows = Integer.parseInt(request.getParameter("rows"));
		
		int start = ((page-1)*rows) +1;
		int end   = page * rows;
		vo.setFirstIndex(start);
		vo.setLastIndex(end);
		ModelAndView mav = new ModelAndView("jsonView");
		List<Map> rsList = faqService.selectFaq0001ListEasy(vo);
		int total = faqService.selectFaq0001Count(vo);
		mav.addObject("total", total);
		mav.addObject("rows", rsList);
		mav.setViewName("jsonView");
		return mav;
	}
	
	
}
