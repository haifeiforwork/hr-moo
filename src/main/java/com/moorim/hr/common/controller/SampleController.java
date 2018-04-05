package com.moorim.hr.common.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.moorim.hr.client.controller.QnaController;
import com.moorim.hr.common.service.EmailSendService;
import com.moorim.hr.common.service.SmsSendService;
import com.moorim.hr.common.vo.EmailVO;
import com.moorim.hr.common.vo.PagingCommonVO;
import com.moorim.hr.common.vo.SmsVO;

@Controller
public class SampleController {
	private static Logger log = LoggerFactory.getLogger(SampleController.class);
	
	
	@Autowired
	private SmsSendService smsService;
	@Autowired
	private EmailSendService emailService;
	
	
	@RequestMapping(value = "/sample/smsTest")
	public String testSns() throws Exception 
	{
		SmsVO vo = new SmsVO();
		vo.setMSG("채용 sms 전송 테스트");
		vo.setPHONE_NO("01090280441");
		vo.setSENDER_NO("0234851500");
		vo.setTITLE("채용 test");
		int result = smsService.sendSms(vo);
		log.debug("sms 전송 결과 ::::::::::::::::"+result);
		return result+"";
	}
	
	@RequestMapping(value = "/sample/emailTest")
	public String testEmail() throws Exception 
	{
		EmailVO ev = new EmailVO();
		ev.setR_EMAIL("rashunu@gmail.com");
		ev.setS_EMAIL("admin@moorim.co.kr");
		ev.setTITLE("제목 테스트");
		
		emailService.sendEmail(ev);
		
		return "";
		
	}
	


}
