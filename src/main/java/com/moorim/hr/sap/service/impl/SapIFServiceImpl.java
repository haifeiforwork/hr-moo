package com.moorim.hr.sap.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.moorim.hr.sap.adapter.SAPInterfaceAdaptor;
import com.moorim.hr.sap.service.SapIFService;

@Service(value="sapjco.SapIFServiceImpl")
public class SapIFServiceImpl implements SapIFService{

    public Map<?, ?> retrieveInsa(HashMap<String, Object> param) throws Exception{
    	SAPInterfaceAdaptor sapApt = SAPInterfaceAdaptor.getInstance();
        
        Map<?, ?> mapResult = sapApt.rfcFunctionCall("ZHR_IF_EDU_INSA", param, null, null);

        return mapResult;
    }
    
    public Map<?, ?> retrieveOrg(HashMap<String, Object> param) throws Exception{
    	SAPInterfaceAdaptor sapApt = SAPInterfaceAdaptor.getInstance();
        
        Map<?, ?> mapResult = sapApt.rfcFunctionCall("ZHR_IF_EDU_ORG", param, null, null);

        return mapResult;
    }
    
}
