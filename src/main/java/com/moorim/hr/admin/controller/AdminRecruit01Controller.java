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
public class AdminRecruit01Controller {
	private static Logger log = LoggerFactory.getLogger(AdminRecruit01Controller.class);
	
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
	@RequestMapping(value= "/admin/recruit/rec0100")
	public String rec0100(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
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
			rsList = recruitService.selectRec0100list(vo);
			cnt = recruitService.selectRecRec0100count(vo);
		}
		
		paginationInfo.setTotalRecordCount(cnt);
		
		model.addAttribute( "notice", recruitService.selectNoticeList());
		model.addAttribute( "total" , recruitService.selectRecRec0100total() );
		model.addAttribute( "code" , code);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		return "/admin/recruit/rec0100";
	}
	
	@RequestMapping(value="/getNoticeOptions")
	public ModelAndView getNoticeOptions(	HttpServletRequest request
											, RecruitNoticeOptionVO vo) throws Exception {
    	
		List<Map> optionList = new ArrayList<Map>();
		ModelAndView mav = new ModelAndView("jsonView");
		
		String result = "success";
		String message = "";
		
		String depth = vo.getDepth();
		
		try {
			
			if(depth.equals("1")) {
				optionList = recruitService.selectKindOptions(vo);
			} else if(depth.equals("2")) {
				optionList = recruitService.selectPartOptions(vo);
			} else {
				result = "fail";
				message = "유효하지 않은 값입니다.";
			}
			
		} catch (Exception ex) {
			result = "fail";
			message = "서버 에러가 발생하였습니다.";
			
			if(log.isErrorEnabled()) log.error(ex.getMessage());
		}
		
		mav.addObject("result", result);
		mav.addObject("message", message);
		mav.addObject("optionList", optionList);
    	mav.setViewName("jsonView");
    	
    	return mav;
    	
	}
	
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
	@RequestMapping(value= "/admin/recruit/rec0101")
	public String rec0101(ModelMap model
			           , @Valid AdminVolunteerVO vo
			           , @RequestParam("rApCode") String rApCode
			           , @RequestParam("rIdx") String rIdx
			           , BindingResult bindingResult
			           , HttpServletRequest request) throws Exception
	{
		Map rsSchool = null;
		Map rsGrade = null;
		int sIdx1;
		int sIdx2;
		
		// 지원서 기본 정보 및 연락처 및 보훈/병력사항
		@SuppressWarnings("rawtypes")
		Map rs1 = recruitService.selectRecruitDetail(vo);
		List<Map> rs2 =  recruitService.selectSchoolList(vo); // 학력사항
		for(Map rs : rs2) {
			rsSchool = new HashMap();
			sIdx1 = (int) rs.get("S_IDX");
			rsSchool = rs;
			
			model.addAttribute("rsSchool"+sIdx1, rsSchool);
		}
		
		
		List<Map> rs3 =  recruitService.selectGradeList(vo); // 성적
		for(Map rs : rs3) {
			rsGrade = new HashMap();
			sIdx2 = (int) rs.get("S_IDX");
			rsGrade = rs;
			
			model.addAttribute("rsGrade"+sIdx2, rsGrade);
		}
		
		List<Map> rs4 =  recruitService.selectCareerList(vo);  // 경력사항
		List<Map> rs5 =  recruitService.selectTrainingList(vo); // 교환학생 및 어학연수
		List<Map> rs6 =  recruitService.selectLanguageList(vo); // 어학능력
		List<Map> rs7 =  recruitService.selectCertList(vo); // 자격사항(자격증)
		List<Map> rs8 =  recruitService.selectIntroList(vo); // 자기소개서
		
		model.addAttribute( "rsDetail", rs1 );
		
		model.addAttribute( "rsCareer", rs4 );
		model.addAttribute( "rsTraining", rs5 );
		model.addAttribute( "rsLanguage", rs6 );
		model.addAttribute( "rsCert", rs7 );
		model.addAttribute( "rsIntroList", recruitService.selectAdminItemIntroList(vo) );
		model.addAttribute( "rsIntro", rs8 );
		
		return "/admin/recruit/rec0101";
	}
	
}
