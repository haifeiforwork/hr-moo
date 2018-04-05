package com.moorim.hr.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.moorim.hr.admin.service.CodeService;
import com.moorim.hr.admin.service.MemberService;
import com.moorim.hr.admin.vo.CodeVO;
import com.moorim.hr.admin.vo.MemberVO;
import com.moorim.hr.client.vo.QnaVO;
import com.moorim.hr.common.EncryptUtil;
import com.moorim.hr.common.SessionUtil;
import com.moorim.hr.common.TextUtil;
import com.moorim.hr.common.service.ComCodeService;
import com.moorim.hr.common.vo.PagingCommonVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class MemberController {
	private static Logger log = LoggerFactory.getLogger(MemberController.class);
	
	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	private String errorPath = "redirect:/admin/home";
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	ComCodeService comCodeService;

	
	@RequestMapping(value = "/admin/loginComplete", method = RequestMethod.GET)
    public String doSessionSet() 
	{
		return errorPath;
    }
	
	@RequestMapping(value = "/admin/loginRequest")
    public ModelAndView requestLogin( @ModelAttribute("user") MemberVO user, HttpServletRequest request, ModelMap model ) throws Exception
	{
		// 임시 URL
		String targetUrl = "/admin/recruit/rec0001";
		ModelAndView mav = new ModelAndView();
		
		Map checkMap = memberService.checkLogin(user);
		String rst = (String) checkMap.get("result");
		if("success".equals(rst)) {
			Map userMap = memberService.getMemberInfo(user);
			HttpSession httpSession = null;
			httpSession = request.getSession(true);
			httpSession.setMaxInactiveInterval(60*60);
			httpSession.setAttribute("user", userMap);
		}
		
		mav.addObject("login", checkMap);
		mav.addObject("targetUrl", targetUrl);
        mav.setViewName("jsonView");
        return mav;
//        return targetUrl;
    }
	
	/*
	 * SSO로그인
	 */
	@RequestMapping(value = "/epLoginRequest")
    public String requestSSOLogin( HttpServletRequest request, ModelMap model ) throws Exception
	{
		String redirectUrl = "/admin/index";
		MemberVO user = new MemberVO();
		Map checkMap = new HashMap();
		try {
			String user_id = request.getParameter("mpsId");
			String emp_no = request.getParameter("mpsNo");
			if(user_id != null && emp_no != null) {
				user.setUser_id(EncryptUtil.decryptText(user_id));
				user.setEmp_no(EncryptUtil.decryptText(emp_no));
				
				checkMap = memberService.checkSSOLogin(user);
				String rst = (String) checkMap.get("result");
				if("success".equals(rst)) {
					// HR 사용자 정보 조회
					Map userMap = memberService.getMemberInfo(user);
					
					// Session 세팅
					HttpSession httpSession = null;
					httpSession = request.getSession(true);
					httpSession.setAttribute("user", userMap);
					
					redirectUrl = "/admin/index";
				}
				
				
			} else {
				checkMap.put("result", "fail");
				checkMap.put("msg", "SSO 로그인 처리에 실패하였습니다. 관리자에게 문의 하세요");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("login", checkMap);
		return redirectUrl;
    }
	
	// 로그아웃
    @RequestMapping("/admin/logout")
    public String logout(HttpSession session,  SessionStatus sessionStatus) {
        //session.setAttribute("user", null);
    	session.removeAttribute("user");
    	sessionStatus.setComplete();
    	//session.invalidate();
        return "redirect:/admin/home";
    }
	
	@RequestMapping(value= "/admin/memberList")
	public String selectMemberList(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
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
		List<Map> rsList = memberService.listMember(vo);
		
		
		// 군별 공통코드 조회
		List<Map> authCode = comCodeService.getCodeByGroup("90");

		
		int cnt = memberService.cntMember(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		model.addAttribute("authCode", authCode);
		
		return "/admin/system/memberList";
	}
	
	
	@RequestMapping(value= "/admin/epMemberList")
	public String selectEpMemberList(ModelMap model,  @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
	{
		@SuppressWarnings("rawtypes")
		List<Map> rsList = memberService.listEpMember(vo);
		
		model.addAttribute( "rsList", rsList );
		
		return "/admin/system/popEpMemberList";
	}
	
	@RequestMapping(value= "/admin/searchMember")
	public ModelAndView searchEpMember(HttpServletRequest request
			, @RequestParam(value="searchMemberName", required=true) String searchMemberName) throws Exception
	{
		
		@SuppressWarnings("rawtypes")
		List<Map> rsList = memberService.searchEpMember(searchMemberName);
		
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("result", rsList);
		
		return mav;
	}
	
	@RequestMapping(value= "/admin/processMember")
	public ModelAndView processMember(MemberVO memberVo,  HttpServletRequest request) throws Exception
	{
		memberVo.setReg_id(SessionUtil.getHomeLoginId(request));
		memberVo.setMod_id(SessionUtil.getHomeLoginId(request));
		resultMap = memberService.processMember(memberVo);
				
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("result", resultMap);
		log.debug(resultMap.toString());
		
		return mav;
	}
	
	
	
	


}
