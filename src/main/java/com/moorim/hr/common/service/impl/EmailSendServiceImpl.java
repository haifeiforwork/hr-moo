package com.moorim.hr.common.service.impl;

import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.mail.HtmlEmail;
import org.apache.velocity.app.VelocityEngine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.moorim.hr.common.service.EmailSendService;
import com.moorim.hr.common.vo.EmailVO;

@Repository
public class EmailSendServiceImpl implements EmailSendService {
	private static Logger log = LoggerFactory.getLogger(EmailSendServiceImpl.class);
		
	@Value("${mailServer.dev}")
	private String serverUrl;
	@Value("${mail.defaultSender}")
	private String defaultSender;
	
	@Autowired
	private VelocityEngine velocityEngine;
	
	@Override
	public int sendEmail(EmailVO vo) {
		String mailContent = "";
        String result = "";
        
        try {
        	HtmlEmail email = new HtmlEmail();
        	email.setCharset("UTF-8");
        	email.setHostName( serverUrl ); // 서버 URL
        	
        	if( vo.getS_EMAIL()==null || "".equals(vo.getS_EMAIL())) {
        		email.setFrom(defaultSender);
        	} else {
        		email.setFrom(vo.getS_EMAIL());
        	}
        	
        	if( null == vo.getR_EMAIL() || "".equals(vo.getR_EMAIL()) ) {
                throw new Exception("Email Validator : Receiver email is null!");
            } else {
                
                String toUser[] = new String[0];
                toUser = vo.getR_EMAIL().split(";");
                for( int i = 0; i < toUser.length ; i++ ) {
                    email.addTo(toUser[i].toString());
                }
            }
        	//ccUserName
            //참조자 설정
//            if( !StringUtil.isEmpty(param.getString("ccUser")) ) {
//                String ccUser[] = new String[0];
//                ccUser = param.getString("ccUser").split(";");
//                for( int i = 0; i < ccUser.length ; i++ ) {
//                    email.addCc(ccUser[i].toString());
//                }
//            }

            //비밀 참조자 설정
//            if( !StringUtil.isEmpty(param.getString("bccUser")) ) {
//                String bccUser[] = new String[0];
//                bccUser = param.getString("bccUser").split(";");
//                for( int i = 0; i < bccUser.length ; i++ ) {
//                    email.addBcc(bccUser[i].toString());
//                }
//            }
        	
        	// 파일 첨부 로직 필요하면 추가!
        	

            // 메일 제목
            email.setSubject(vo.getTITLE());
            
            Map params = BeanUtils.describe(vo);
            log.debug(params.toString());
            
            // 메일 본문
            mailContent = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine,"email-template.vm", BeanUtils.describe(vo));
            log.debug("mailContent : " + mailContent);
            email.setHtmlMsg(mailContent);
            
            email.send();
            result = "success";
                    	
        	
        } catch (Exception e) {
            
            String errMessage = e.getMessage();
            if( errMessage != null ) {
                log.error("[EmailSendServiceImpl] ".concat(errMessage));
            }
            result = "fail";
        }

        
		return 0;
//		return smsDao.insertSms(vo);
	}
	

}
