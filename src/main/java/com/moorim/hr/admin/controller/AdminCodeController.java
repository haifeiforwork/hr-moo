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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.moorim.hr.admin.service.CodeService;
import com.moorim.hr.admin.vo.CodeVO;
import com.moorim.hr.client.vo.QnaVO;

@Controller
public class AdminCodeController {
	private static Logger log = LoggerFactory.getLogger(AdminCodeController.class);
	
	@Autowired
	private CodeService codeService;
	
	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	@RequestMapping(value= "/admin/getCodeGroup",  produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public ModelAndView selectCodeGroup(ModelMap model,  HttpServletRequest request) throws Exception 
	{
		@SuppressWarnings("rawtypes")
		List<Map> rsList = codeService.listCodeGroup();
		
		log.debug(rsList.toString());
		
		ModelAndView mav = new ModelAndView("jsonView");
//		mav.addObject("total", "4");
		mav.addObject("rows", rsList);
		mav.setViewName("jsonView");
    	return mav;

	}
	@RequestMapping( value = "/txTest")
	public ModelAndView txTest(HttpServletRequest request) throws Exception
	{
		try {
			codeService.txTest();
		} catch(Exception e) {
			log.debug("===================================================================");
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	@RequestMapping( value = "/admin/procCodeGroup", method = RequestMethod.POST)
	public ModelAndView procCodeGroup(CodeVO vo, HttpServletRequest request) throws Exception
	{
		resultMap = new HashMap();
    	resultMap = codeService.procCodeGroup(vo);
		
		ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}
	
	@RequestMapping(value= "/admin/selectCodeByGruop",  produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public ModelAndView selectCodeByGruop(ModelMap model
			                           , @RequestParam String g_code
			                           ,  HttpServletRequest request) throws Exception 
	{
		@SuppressWarnings("rawtypes")
		List<Map> rsList = codeService.selectCodeByGruop(g_code);
		
		log.debug(rsList.toString());
		
		ModelAndView mav = new ModelAndView("jsonView");
//		mav.addObject("total", "4");
		mav.addObject("rows", rsList);
		mav.setViewName("jsonView");
    	return mav;

	}
	
	@RequestMapping( value = "/admin/procCodeByGroup", method = RequestMethod.POST)
	public ModelAndView procCodeByGroup(CodeVO vo, HttpServletRequest request) throws Exception
	{
		resultMap = new HashMap();
    	resultMap = codeService.procCodeByGroup(vo);
		
		ModelAndView mav = new ModelAndView("jsonView");
    	mav.addObject("json", resultMap);	
    	mav.setViewName("jsonView");
    	return mav;
    	
	}

	

}
