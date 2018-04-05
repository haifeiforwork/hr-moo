package com.moorim.hr.client.controller;

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

import com.moorim.hr.client.service.FaqService;
import com.moorim.hr.common.service.EmailSendService;
import com.moorim.hr.common.service.SmsSendService;
import com.moorim.hr.common.vo.PagingCommonVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class FaqController {
	private static Logger log = LoggerFactory.getLogger(FaqController.class);
	 
	@Autowired
	private FaqService faqService;
	@Autowired
	private SmsSendService smsService;
	@Autowired
	private EmailSendService emailService;
	
	
	@SuppressWarnings("rawtypes")
	private Map resultMap = null;
	
	
	
	@RequestMapping(value= "/client/faq")
	public String faq(ModelMap model, @ModelAttribute("pCommon") PagingCommonVO vo, HttpServletRequest request) throws Exception
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
		List<Map> rsList = faqService.listFaq(vo);
		
		int cnt = faqService.cntFaq(vo);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute( "rsList", rsList );
		
		return "/client/faq/faq";
	}

}
