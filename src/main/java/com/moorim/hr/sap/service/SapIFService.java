package com.moorim.hr.sap.service;

import java.util.HashMap;
import java.util.Map;

public interface SapIFService {

	public Map<?, ?> retrieveInsa(HashMap<String, Object> param) throws Exception;
	
	public Map<?, ?> retrieveOrg(HashMap<String, Object> param) throws Exception;
	
}