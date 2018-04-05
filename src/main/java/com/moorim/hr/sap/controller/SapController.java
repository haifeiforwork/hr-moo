package com.moorim.hr.sap.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.moorim.hr.sap.service.SapIFService;

import net.sf.json.JSON;
import net.sf.json.JSONSerializer;

@Controller
public class SapController {

//	private static final Logger log = LoggerFactory.getLogger(SampleController.class);
	private static Logger log = Logger.getLogger( SapController.class );
    @Resource(name="sapjco.SapIFServiceImpl")
    private SapIFService sapIFService;
    
    @RequestMapping("/retrieveInsa")
    public ModelAndView retrieveEduInsa(@RequestParam Map params, ModelMap model, HttpServletRequest request) throws Exception{
        
        HashMap<String, Object> rfcParamMap = new HashMap<String, Object>();
        
        rfcParamMap.put("I_DATUM", request.getParameter("I_DATUM"));
        
        Map<?, ?> result = sapIFService.retrieveInsa(rfcParamMap);
        
        String eParam = (String) result.get("E_RESULT");
        
        System.err.println(eParam);
        
        List<Map<?, ?>> outt0101 = (List) result.get("ET_RESULT");
        outt0101.remove(0);
        for( Map<?, ?> rowMap : outt0101 ){
            //XML에 설정된 FILED 이름과 동일한 키값
        	log.info("-----------------------------------------");
//        	System.err.println("-----------------------------------------");
            System.err.println("이름 : " + rowMap.get("ENAME"));
            System.err.println("사번 : " + rowMap.get("PERNR"));
            System.err.println("이메일 : " + rowMap.get("EMAIL"));
            System.err.println("SAP ID : " + rowMap.get("SAPID"));
            System.err.println("휴대폰번호 : " + rowMap.get("CELLPHONE"));
            System.err.println("회사전화번호 : " + rowMap.get("COMPPHONE"));
            System.err.println("직급명 : " + rowMap.get("TRFTEXT"));
            log.info("-----------------------------------------");
        }
        
        //HashMap<?, ?> outt0101 = (HashMap<?, ?>) result.get("ET_RESULT");
        
        //HashMap<String, Object> returnMap = new HashMap<String, Object>();
        
       // returnMap.put("ET_RESULT", outt0101);
        JSON json = JSONSerializer.toJSON( outt0101 );
        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject( "json", json );
        return mav;
    }
    
    @RequestMapping("/retrieveEduOrg")
    public ModelAndView retrieveEduOrg(@RequestParam Map params, ModelMap model, HttpServletRequest request) throws Exception{
        
        HashMap<String, Object> rfcParamMap = new HashMap<String, Object>();
        
//        rfcParamMap.put("I_DATUM", request.getParameter("I_DATUM"));
        rfcParamMap.put("I_DATUM", "20151123");
        
        Map<?, ?> result = sapIFService.retrieveOrg(rfcParamMap);
        
        String eParam = (String) result.get("E_RESULT");
        
        System.err.println(eParam);
        
        List<Map<?, ?>> outt0101 = (List) result.get("ET_RESULT");
       
        for( Map<?, ?> rowMap : outt0101 ){
            //XML에 설정된 FILED 이름과 동일한 키값
        	System.err.println("-----------------------------------------");
            System.err.println("부서코드 : " + rowMap.get("OBJID"));
            System.err.println("부서명 : " + rowMap.get("STEXT"));
            System.err.println("상위부서코드 : " + rowMap.get("HIGHOBJ"));
            System.err.println("부서장 사번 : " + rowMap.get("PERNR"));
            System.err.println("-----------------------------------------");
        }
        
        //HashMap<?, ?> outt0101 = (HashMap<?, ?>) result.get("ET_RESULT");
        
        HashMap<String, Object> returnMap = new HashMap<String, Object>();
        
        returnMap.put("ET_RESULT", outt0101);
        
        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject( "json", returnMap );
        return mav;
    }
   
}
