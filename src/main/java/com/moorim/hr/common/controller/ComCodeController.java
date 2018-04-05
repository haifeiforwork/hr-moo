package com.moorim.hr.common.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.moorim.hr.admin.controller.AdminCodeController;
import com.moorim.hr.common.dao.ComCodeDAO;

@EnableCaching 
@Controller
public class ComCodeController {
	private static Logger log = LoggerFactory.getLogger(AdminCodeController.class);
	
	@Autowired
	ComCodeDAO comCodeDao;
	
	@RequestMapping("/code/cache/{g_code}")
	@ResponseBody
	public ModelAndView getCodeCache(@PathVariable String g_code) throws Exception 
	{
		@SuppressWarnings("rawtypes")
		List<Map> rsList = comCodeDao.getCodeByGroup(g_code);
		
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("rows", rsList);
		mav.setViewName("jsonView");
    	return mav;
	}

}
