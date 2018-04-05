package com.moorim.hr.client.controller;

import java.net.URI;
import java.net.URLDecoder;
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
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;

import com.moorim.hr.client.service.JobService;
import com.moorim.hr.client.vo.RecruitCareerVO;
import com.moorim.hr.client.vo.RecruitCertVO;
import com.moorim.hr.client.vo.RecruitGradeVO;
import com.moorim.hr.client.vo.RecruitIntroVO;
import com.moorim.hr.client.vo.RecruitLanguageVO;
import com.moorim.hr.client.vo.RecruitNoticeOptionVO;
import com.moorim.hr.client.vo.RecruitSchoolVO;
import com.moorim.hr.client.vo.RecruitTrainingVO;
import com.moorim.hr.client.vo.RecruitVO;
import com.moorim.hr.common.AESCrypt;
import com.moorim.hr.common.CheckNull;
import com.moorim.hr.common.FileUtil;
import com.moorim.hr.common.TextUtil;
import com.moorim.hr.common.service.ComCodeService;
import com.moorim.hr.common.service.EmailSendService;
import com.moorim.hr.common.vo.EmailVO;
import com.moorim.hr.common.vo.PagingCommonVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import net.sf.json.JSONArray;

@Controller
@RequestMapping(value="/client")
public class AcceptController {
	
	private static Logger log = LoggerFactory.getLogger(AcceptController.class);
	
	@Autowired
	ComCodeService comCodeService;
	
	@Autowired
	private EmailSendService emailService;
	
	@Autowired
	private JobService jobService;
	
	@RequestMapping(value="/acceptedCheck")
	public String acceptedCheck(	HttpServletRequest request
							, ModelMap model
							) throws Exception {
		
		Map code = new HashMap();
		
		/***************************************
		 * 코드 세팅
		 * **************************************/
		code.put("code40", comCodeService.getCodeByGroup("40")); // 채용구분
		
		List<Map> rsList = jobService.getCurrentNoticeList();
		
		model.addAttribute("code", code);
		model.addAttribute("rsList", rsList);
		return "/client/accept/acceptedCheck";
		
	}
	
	@RequestMapping(value="/acceptedList")
	public String acceptedList(	HttpServletRequest request
							, ModelMap model
							, @ModelAttribute("recruit") RecruitVO vo
							) throws Exception {
		Map resultMap = new HashMap();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		int regCount = jobService.checkReg(vo);
		if(regCount >0){
			resultMap = jobService.appySelectOneInfo(vo);
			resultMap.put("R_PWD", "");
		}else{
			// error
		}
		
		model.addAttribute("rs", resultMap);
		return "/client/accept/acceptedList";
		
	}
}
