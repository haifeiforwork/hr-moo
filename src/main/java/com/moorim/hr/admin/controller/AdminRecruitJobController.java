package com.moorim.hr.admin.controller;

import java.util.ArrayList;
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
public class AdminRecruitJobController {
	private static Logger log = LoggerFactory.getLogger(AdminRecruitJobController.class);
	
	@Autowired
	private AdminRecruitService recruitService;
	
	@Autowired
	ComCodeService comCodeService;
	
	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	/**
	 * 관리자 - 공고관리 - 채용공고 - 조회
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value= "/admin/recruit/rec0001")
	public String rec0001(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
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
		List<Map> rsList = recruitService.selectRec0001list(vo);
		
		int cnt = recruitService.selectRec0001count(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		
		return "/admin/recruit/rec0001";
	}
	
	/**
	 * 관리자 - 공고관리 - 채용공고 - 등록 및 수정
	 * @param model
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping(value = "/admin/recruit/rec0002")
	public String rec0002(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
	{	
		String idx = request.getParameter("idx");
		String procType = "mod";
		Vector realFileName = new Vector();
		Vector systemFileName = new Vector();
		Vector fileSize = new Vector();
		Vector fileType = new Vector();
		Map rs = new HashMap();
		Map code = new HashMap();
		
		/***************************************
		 * 코드 세팅
		 * **************************************/
		code.put("code03", comCodeService.getCodeByGroup("03")); // 직군
		code.put("code04", comCodeService.getCodeByGroup("04")); // 직무
		code.put("code05", comCodeService.getCodeByGroup("05")); // 지역
		code.put("code40", comCodeService.getCodeByGroup("40")); // 채용구분
		
		if("".equals(idx) || idx == null) {
			procType = "new";
		}else{
			vo.setIdx(idx);
			rs = recruitService.selectRec0002Detail(vo);
			rs.put("careerList", recruitService.selectRec0002DetailCareerList(vo));
			if(rs == null) {
				procType = "new";
			}
		}
		log.debug("=======procType:"+procType);

		if(rs != null){
			String fileInfo = (String)rs.get("R_SAVE_FILE");
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
		
		model.addAttribute("vo", vo);
		model.addAttribute("procType", procType);
		model.addAttribute("rs", rs);
		model.addAttribute("code", code);
		model.addAttribute("fileUpload", TextUtil.getFileUpload(1, realFileName, systemFileName, fileSize, fileType, "recruit", true, false));
		
		return "/admin/recruit/rec0002";
	}
	
	
	/**
	 * 관리자 - 공고관리 - 채용공고 - 삭제 프로세스
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/recruit/deleteRec0001", method = RequestMethod.POST)
	public ModelAndView deleteRec0001(AdminRecruitVO vo, HttpServletRequest request) throws Exception
	{	
    	resultMap = new HashMap();
		resultMap = recruitService.deleteRec0001(vo);
		log.debug(resultMap.toString());
		
    	ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	/**
	 * 관리자 - 공고관리 - 채용공고 - 입력 프로세스
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/recruit/insertRec0002", method = RequestMethod.POST)
	public ModelAndView insertRec0002(@Valid AdminRecruitVO vo
			                        , @Valid AdminRecruitCareerVO careerVO 
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
			 * 첨부파일 세팅
			 * **************************************/
			String fileInfo = vo.getFileinfo();
			String[] file;
			if(fileInfo != null && !"".equals(fileInfo)){
				//[TODO] 서버파일 정보에 원본파일 정보도 같이 넣어놨음 이거 어떻게 해야될지 생각
				file = fileInfo.split("\\*");
				vo.setrRealFile(file[1]);
				vo.setrSaveFile(fileInfo);
			}
			
			/***************************************
			 * 등록자아이디 / 등록자 이름 세팅
			 * **************************************/
			vo.setRegId(SessionUtil.getHomeLoginId(request));
			vo.setRegName(SessionUtil.getHomeLoginName(request));
			
			/***************************************
			 * 프로세스
			 * **************************************/
			boolean isSuccess = recruitService.insertRec0002(vo, careerVO.getCareerList());
			
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
	 * 관리자 - 공고관리 - 채용공고 - 수정 프로세스
	 * @param vo
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 김병식
	 * 
	 */
	@RequestMapping( value = "/admin/recruit/updateRec0002", method = RequestMethod.POST)
	public ModelAndView updateRec0002(@Valid AdminRecruitVO vo
			                        , @Valid AdminRecruitCareerVO careerVO 
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
			 * 첨부파일 세팅
			 * **************************************/
			String fileInfo = vo.getFileinfo();
			String[] file;
			if(fileInfo != null && !"".equals(fileInfo)){
				//[TODO] 서버파일 정보에 원본파일 정보도 같이 넣어놨음 이거 어떻게 해야될지 생각
				file = fileInfo.split("\\*");
				vo.setrRealFile(file[1]);
				vo.setrSaveFile(fileInfo);
			}
			
			/***************************************
			 * 등록자아이디 / 등록자 이름 세팅
			 * **************************************/
			vo.setRegId(SessionUtil.getHomeLoginId(request));
			vo.setRegName(SessionUtil.getHomeLoginName(request));
			
			/***************************************
			 * 프로세스
			 * **************************************/
			boolean isSuccess = recruitService.updateRec0002(vo, careerVO.getCareerList());
			
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
