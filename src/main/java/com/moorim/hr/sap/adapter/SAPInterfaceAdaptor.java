/**
 * =================================================================================
 * @Project      : 
 * @Source       : SAPInterfaceAdaptor.java
 * @Description  : SAP Interface Manager
 * @Version      : v1.0
 *
 * Copyright(c) 2015 GM Solution All rights reserved
 * =================================================================================
 *  No    CSR ID   Req. No.         Req. Date     Author  Description
 * =================================================================================
 *  1.0                             2015/11/09    양승현    1.0 Release
 * =================================================================================
 */
package com.moorim.hr.sap.adapter;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.xerces.parsers.DOMParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.moorim.hr.admin.controller.AdminCodeController;
import com.sap.conn.jco.JCoContext;
import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoDestinationManager;
import com.sap.conn.jco.JCoException;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoFunctionTemplate;
import com.sap.conn.jco.JCoRepository;
import com.sap.conn.jco.JCoStructure;
import com.sap.conn.jco.JCoTable;
import com.sap.conn.jco.ext.DestinationDataProvider;
/**
 *
 * SAPInterfaceAdaptor는 RFC(Remote Function Call) 통신을 통하여 SAP가 인터페이스하는 Class이다.
 *
 * @author 양승현
 *
 */
public class SAPInterfaceAdaptor {

	public static Map<?, ?> sapInterface = null;
	Map<?, ?> jcoRepositories = null;
	Map<?, ?> functions = null;

	static boolean hasPools = false;
	static SAPInterfaceAdaptor jco = null;

	private static Logger log = LoggerFactory.getLogger(SAPInterfaceAdaptor.class);
	String SAP_SERVER ="";
	
	/**
	 * sapinterface.xml 파일 절대 경로로 수정
	 */
	private String webapproot = System.getProperty("webapp.root");
	
	private String xmlFilePath = webapproot+"/WEB-INF/classes/config/sap/sapinterface.xml";
	
	
	//server
//	private String xmlFilePath = "D:/apache-tomcat-7.0.65-windows-x64/apache-tomcat-7.0.65/webapps/moorim/WEB-INF/classes/conf/sapinterface/sapinterface.xml";
	

	private JCoRepository SAP_repos;
	private JCoDestination SAP_dest;
	private Properties SAP_properties;

    @SuppressWarnings({ "unchecked", "rawtypes" })
	private SAPInterfaceAdaptor() throws Exception{
    	log.debug("===========webapp.root:"+webapproot);
    	
    	sapInterface = makeHashMapWithXml(xmlFilePath, "cData");

    	hasPools     = getRfcConnection();

        functions   = ArrayList2Map((ArrayList) sapInterface.get("function"), "name");
    }
    
    /**
     * HashMap을 ArrayList
     *  parameter로 넘어갈 ArrayList의 element는 HashMap이여야 한다.
     * 
     */
    @SuppressWarnings("unchecked")
	public static Map<String, Object> ArrayList2Map(ArrayList<Object> al, Object hashKey) {
    
        HashMap<String, Object> hm = new HashMap<String, Object>();
        
        for(int i=0;i<al.size();i++) {
            HashMap<String, Object> hm2 = (HashMap<String, Object>)al.get(i);
            hm.put((String)hm2.get(hashKey), hm2);
        }
        return Collections.synchronizedMap(hm);
    }
    
    /**
     * XML의 설정 값을 HashMap과 ArrayList로 
     * 저장한 후 HashMap을 Return한다.
     * <p>
     * HashMap에는 해당 노드의 Attribute와 Element들을 가진다.
     * <ul>
     * <li>Attribute의 경우 Attribute의 name과 value는 HashMap element의 key와 value가 된다.
     * <li>Element의 경우 같은 이름의 element끼리 ArrayList로 구성되며, 
     *            Element name은 HashMap의 키로 하며, 
     *            value는 Element들의 ArrayList 객체를 가진다.
     * </ul>
     * @param xmlName system.properties에 설정한 xml파일명을 가지고 있는 keyName
     * @param cDataName CDATA형태로 처리한 부분에 대한 keyName을 정해주기 위한 parameter, null인 경우 parent 노드명을 keyName으로 가진다.
     * @return HashMap 매소드 설명 참조
     */
    @SuppressWarnings({ "finally", "unchecked", "rawtypes" })
	public Map makeHashMapWithXml(String xmlName, String cDataName){
        HashMap reHm = null;
        
        try{
            DOMParser parser = new DOMParser(); 

            Document xmlDoc = getDocument(parser, xmlName);

            Node dynamicSql = xmlDoc.getFirstChild() ;
            if(cDataName==null) reHm = makeHashMapWithNode(dynamicSql);
            else reHm = makeHashMapWithNode(dynamicSql, cDataName);

        }catch(Exception e){
            
        }finally{       
            return  Collections.synchronizedMap(reHm);                      
        }
                
    }
    
    /**
	 * xml 파일처리를 위한 Document를 얻는다.
	 * 
	 * @param parser  파서
	 * @param xmlFile  경로를 포함한 xml파일명     
	 * 
	 * @return Document xmlDocument
	 */
	private Document getDocument(DOMParser parser,String xmlFile){
		try{			
			parser.parse(xmlFile);
		}catch(Exception e){	
			e.printStackTrace();
		}		
		return parser.getDocument();
	}
	
	/**
	 * Node의 내용을 HashMap으로 구성
	 * 
	 * HashMap에는 해당 노드의 Attribute와 Element들을 가진다. Attribute의 경우 Attribute의 name이
	 * HashMap element의 key가 되며, value는 HashMap해당 key의 value가 된다. 해당노드의
	 * Element들은 같은 이름끼리 각 node를 HashMap으로 구성한 ArrayList로 구성되며, Element name은
	 * HashMap의 키로 하며, value는 Element들의 ArrayList 객체를 가진다.
	 * 
	 * @param xmlNode
	 *            , cDataKey
	 * @return HashMap 매소드 설명 참조
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public HashMap makeHashMapWithNode(Node xmlNode, String cDataKey) {

		HashMap rsHm;

		NodeList nl = xmlNode.getChildNodes();

		rsHm = showNodeAtt(xmlNode);
		for (int i = 0; i < nl.getLength(); i++) {
			Node nd = nl.item(i);
			if (nd.getNodeType() == Node.CDATA_SECTION_NODE) {
				rsHm.put(cDataKey, nd.getNodeValue());
			}
			if (nd.getNodeType() == Node.ELEMENT_NODE) {
				String nodeName = nd.getNodeName().trim();
				if (rsHm.containsKey(nodeName)) {
					ArrayList al = (ArrayList) rsHm.get(nodeName);
					al.add(makeHashMapWithNode(nd, cDataKey));
				} else {
					ArrayList al = new ArrayList();
					al.add(makeHashMapWithNode(nd, cDataKey));
					rsHm.put(nodeName, al);
				}
			}
		}
		return rsHm;
	}

	/**
	 * Node의 내용을 HashMap으로 구성
	 * 
	 * HashMap에는 해당 노드의 Attribute와 Element들을 가진다. Attribute의 경우 Attribute의 name이
	 * HashMap element의 key가 되며, value는 HashMap해당 key의 value가 된다. 해당노드의
	 * Element들은 같은 이름끼리 각 node를 HashMap으로 구성한 ArrayList로 구성되며, Element name은
	 * HashMap의 키로 하며, value는 Element들의 ArrayList 객체를 가진다.
	 * 
	 * @author csy
	 * @param xmlNode
	 *            , cDataKey
	 * @return HashMap 매소드 설명 참조
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public HashMap makeHashMapWithNode(Node xmlNode) {

		HashMap rsHm;

		NodeList nl = xmlNode.getChildNodes();

		rsHm = showNodeAtt(xmlNode);
		for (int i = 0; i < nl.getLength(); i++) {
			Node nd = nl.item(i);
			NodeList childNodes = nd.getChildNodes();
			Node childCdataNode = null;
			for (int j = 0, listSize = childNodes.getLength(); j < listSize; j++) {
				Node cNode = childNodes.item(j);
				if (cNode.getNodeType() == Node.CDATA_SECTION_NODE) {
					childCdataNode = cNode;
				}
			}
			if (childCdataNode != null) {
				String nodeName = nd.getNodeName().trim();
				rsHm.put(nodeName, childCdataNode.getNodeValue());
				log.debug("makeHashMapWithNode(node)---> childCdataNode=" + childCdataNode);
				continue;
			}
			if (nd.getNodeType() == Node.ELEMENT_NODE) {
				String nodeName = nd.getNodeName().trim();
				if (rsHm.containsKey(nodeName)) {
					ArrayList al = (ArrayList) rsHm.get(nodeName);
					al.add(makeHashMapWithNode(nd));
				} else {
					ArrayList al = new ArrayList();
					al.add(makeHashMapWithNode(nd));
					rsHm.put(nodeName, al);
				}
			}
		}
		return rsHm;
	}
	
	/*
	 * 해당노드를 주면 그 노드에 속한 Attribute리스트를 해쉬맵에 담아서 리턴한다.
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public HashMap showNodeAtt(Node xmlnode) {

		HashMap hm = new HashMap();
		/*
		 * Set keys = hm.keySet();
		 * 
		 * Iterator it = keys.iterator(); while(it.hasNext()){ String str =
		 * (String)it.next();
		 * 
		 * }
		 */

		NamedNodeMap nnm = xmlnode.getAttributes();
		if (nnm != null) {
			for (int j = 0; j < nnm.getLength(); j++) {
				Node an2 = nnm.item(j);
				String aName = an2.getNodeName();
				String aValue = an2.getNodeValue();
				hm.put(aName, aValue);

				// log.debug("	[ATTRIBUTE]" + aName + ", " + aValue);
			}
		}

		return hm;
	}

 	/**
     * SAPInterfaceManager 객체를 리턴해 주는 Singleton메소드
     *
     * 객체를 생성하지 않고 얻어서 사용
     *
     * @return SAPInterfaceManager
     * @throws Exception
     */
    public static SAPInterfaceAdaptor getInstance() throws Exception{

        if(jco == null) {
            jco = new SAPInterfaceAdaptor();
            return jco;
        }else{
             return jco;
        }
    }

 	/**
     * getRfcConnection RFC Connection 정보를 생성하고
     *
     * Pool을 구성한다.
     *
     * @return boolean
     * @throws Exception
     */
	public boolean getRfcConnection() {

		SAP_properties = new Properties();
		try{

			List<?> clientList = (List<?>)sapInterface.get("connection");

			Map<?,?> clientMap = (Map<?,?>) clientList.get(0);

			SAP_SERVER = (String) clientMap.get("name"); //destination

			String SAP_POOL_CAPACITY = (String) clientMap.get("pool_capacity");
	        String SAP_PEAK_LIMIT	 = (String) clientMap.get("peak_limit");
	        String SAP_HOST_NAME = "";
	        String SAP_HOST_TYPE = "";

	        SAP_HOST_NAME = (String) clientMap.get("mshost");
	        SAP_HOST_TYPE = "MS";
	        
	        if( SAP_HOST_NAME == null || SAP_HOST_NAME.isEmpty() ){
	        	SAP_HOST_NAME = (String) clientMap.get("ashost");
	        	SAP_HOST_TYPE = "AS";
	        }

			String SAP_SYSTEM_NR	 = (String) clientMap.get("sysnr");
	        String SAP_CLIENT_NO	 = (String) clientMap.get("client");
	        String SAP_USER_ID		 = (String) clientMap.get("user");
	        String SAP_PASSWORD		 = (String) clientMap.get("passwd");
	        String SAP_LANGUAGE		 = (String) clientMap.get("lang");
	        String SAP_R3_NAME		 = (String) clientMap.get("r3name");
	        String SAP_GROUP		 = (String) clientMap.get("group");

	        SAP_properties.setProperty("ACTION", "CREATE");
	        SAP_properties.setProperty(DestinationDataProvider.JCO_DEST         , SAP_SERVER);

	        if( "MS".equals(SAP_HOST_TYPE) ){
	        	
	        	SAP_properties.setProperty(DestinationDataProvider.JCO_MSHOST , SAP_HOST_NAME);
	        } else if ( "AS".equals(SAP_HOST_TYPE) ){
	        	
	        	SAP_properties.setProperty(DestinationDataProvider.JCO_ASHOST , SAP_HOST_NAME);
	        }

	        SAP_properties.setProperty(DestinationDataProvider.JCO_SYSNR        , SAP_SYSTEM_NR);
	        SAP_properties.setProperty(DestinationDataProvider.JCO_CLIENT       , SAP_CLIENT_NO);
	        SAP_properties.setProperty(DestinationDataProvider.JCO_USER         , SAP_USER_ID);
	        SAP_properties.setProperty(DestinationDataProvider.JCO_PASSWD       , SAP_PASSWORD);
	        SAP_properties.setProperty(DestinationDataProvider.JCO_LANG         , SAP_LANGUAGE);
	        SAP_properties.setProperty(DestinationDataProvider.JCO_POOL_CAPACITY, SAP_POOL_CAPACITY);
	        SAP_properties.setProperty(DestinationDataProvider.JCO_PEAK_LIMIT   , SAP_PEAK_LIMIT);
	        SAP_properties.setProperty(DestinationDataProvider.JCO_R3NAME       , SAP_R3_NAME);
	        SAP_properties.setProperty(DestinationDataProvider.JCO_GROUP        , SAP_GROUP);

			MyDestinationDataProvider myProvider = new MyDestinationDataProvider();

			if (!com.sap.conn.jco.ext.Environment.isDestinationDataProviderRegistered()) {
				com.sap.conn.jco.ext.Environment.registerDestinationDataProvider(myProvider);
			}else{
				log.info("##########################isDestinationDataProviderRegistered");
			}
			if(SAP_properties==null){
				log.info("##########################SAP_properties is null");
				return false;
			}
			myProvider.changePropertiesForABAP_AS(SAP_properties);


			SAP_dest = JCoDestinationManager.getDestination(SAP_SERVER);
	        SAP_repos = SAP_dest.getRepository();
	       // SAP_dest.ping();

		} catch (JCoException e) {
	        log.error("Error "+e.getMessage());
			throw new RuntimeException(e);

		} catch(Exception e){
			e.printStackTrace();
		}

		return true;
	}

	/**
	 * Method getFunction read a SAP Function and return it to the caller. The
	 * caller can then set parameters (import, export, tables) on this function
	 * and call later the method execute.
	 *
	 * getFunction translates the JCo checked exceptions into a non-checked
	 * exceptions
	 */
	public JCoFunction getSAPFunction(String functionStr) {
		JCoFunction jcoFunc = null;
		try {
			jcoFunc = SAP_repos.getFunction(functionStr);
		} catch (Exception e) {
			e.printStackTrace();
	        log.error("getSAPFunction Error "+e.getMessage());
			throw new RuntimeException("Problem retrieving SAP JCO.Function object.");
		}
		if (jcoFunc == null) {
	        log.error("jcoFunc is null");
			throw new RuntimeException("Not possible to receive SAP function. ");
		}

		return jcoFunc;
	}


	/**
	 *
	 * function명과 import value에 대한 Map, table name을 파라메터로 넘겨서 해당 Row Data를 List로
	 * 리턴 받는다.
	 *
	 * import value는 필드명을 Key로하고, 필드값을 Value로 저장한 Map으로 구성한다.
	 *
	 * @param functionName
	 * @param importValues
	 * @param tableName
	 * @return
	 * @throws Exception
	 */
	public List<?> getResultList(String functionName, Map<?, ?> importValues, String tableName) throws Exception {
		return (List<?>) getResultMap(functionName, importValues).get(tableName);
	}

	/**
	 * function명과 table name을 파라메터로 넘겨서 해당 Row Data를 List로 리턴 받는다. import가 없는 경우
	 *
	 * @param functionName
	 * @param tableName
	 * @return
	 * @throws Exception
	 */
	public List<?> getResultList(String functionName, String tableName) throws Exception {
		return (List<?>) getResultMap(functionName).get(tableName);
	}

	/**
	 * function명과 import value에 대한 Map을 파라메터로 넘겨서 function의 각 테이블에 대한 각각의 Row
	 * Data를 Map에 List로 받아 리턴
	 *
	 * return된 Map은 각 테이블명을 Key로 Table의 RowData를 List 형태의 Value로 구성
	 *
	 * import value는 필드명을 Key로하고, 필드값을 Value로 저장한 Map으로 구성한다.
	 *
	 *
	 * @param functionName
	 * @param importValues
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map<?, ?> getResultMap(String functionName, Map<?, ?> importValues) throws Exception {

		JCoFunction jcoFunc = getSAPFunction(functionName);

		if (jcoFunc == null) {
			log.error("getRestulSets() -----------------------> function " + functionName + " not found in SAP.");
			return null;
		}

		//function layout 정보
		Map<?, ?> mapFunction = (Map<?, ?>) functions.get(functionName);

		List<?> imports = (List<?>) mapFunction.get("import");
		if (imports != null) {
			for (int i = 0, importCnt = imports.size(); i < importCnt; i++) {
				String importName = (String) ((Map<?, ?>) imports.get(i)).get("name");
				jcoFunc.getImportParameterList().setValue(importName, importValues.get(importName));
				log.info("getResultSet() ---------------> importValue = " + importValues.get(importName) + "importName = " + importName);
			}
		}

		jcoFunc.execute(SAP_dest);
		log.info("getResultMap()----> jcoFunc.execute(jcoDest)");

		/*
		 * 리턴 데이터 확인
		 */
		String returnStatus = null;
		String returnMessage = null;
		boolean isError = false;

		returnStatus  = jcoFunc.getExportParameterList().getString("E_RETURN");
		returnMessage = jcoFunc.getExportParameterList().getString("E_RETMSG");
		log.info("RESULT :[" + returnStatus + "]["+returnMessage+"]");
		if (!"S".equals(returnStatus)) {
			isError = true;
			returnStatus = "F";
		}

		List<?> exports = (List<?>) mapFunction.get("export");
		String exportName = "";

		HashMap<String,Object> tableDatas = new HashMap<String,Object>();

		if (exports != null) {
			for (int i = 0, exportCnt = exports.size(); i < exportCnt; i++) {
				exportName = (String) ((Map<?,?>) exports.get(i)).get("name");
				returnStatus = (String) jcoFunc.getExportParameterList().getValue(exportName);
				tableDatas.put(exportName, returnStatus);
				log.info("setDataMap() ---------------> exportName = [" + exportName + "] exportValue = [" + returnStatus + "]");
			}
		}

		List<?> structures = (List<?>) mapFunction.get("outputStructure");
		String structureName = "";
		if(structures != null){

			HashMap<String,Object> structureData = new HashMap<String,Object>();

			for(int i = 0; i<structures.size(); i++){

				Map<?,?> structure = (Map<?,?>)structures.get(i);
				structureName = (String)structure.get("name");
				JCoStructure jcoStructure = jcoFunc.getExportParameterList().getStructure(structureName);

				Map<?,?> fieldNames = getFieldNames(structure);
				Iterator keys = fieldNames.keySet().iterator();

				while(keys.hasNext()){
					String fieldName = (String) fieldNames.get((String) keys.next());
					structureData.put(fieldName, jcoStructure.getString(fieldName));
				}
			}
			tableDatas.put(structureName, structureData);
		}


		List<?> tables = (List<?>) mapFunction.get("outputTable");
		log.info("getResultMap()----> mapFunction.get(outputTable) ["+ tables.toString()+"]");

		if (tables != null) {
			for (Iterator<?> tableIter = tables.iterator(); tableIter.hasNext();) {
				Map<?,?> table = (Map<?,?>) tableIter.next();
				String tableName = (String) table.get("name");
				log.info("getResultMap() ----------> tableName ["+tableName+"]");

				log.info("getResultMap() ----------> tableName ["+jcoFunc.getTableParameterList().toString()+"]");

				ArrayList<Map<?,?>> rowDatas = new ArrayList<Map<?,?>>();
				JCoTable jcoTable = jcoFunc.getTableParameterList().getTable(tableName);
				log.info("getResultMap() ----------> jcoTable ["+jcoTable.toString()+"]");

				Map<?,?> fieldNames = getFieldNames(table);
				log.info("getResultMap() ----------> fieldNames ["+fieldNames.toString()+"]");
				rowDatas.add(fieldNames);

				if (!isError) {
					log.info("getResultMap() ----------> getProcessing ");
					for (int j = 0, rowCnt = jcoTable.getNumRows(); j < rowCnt; j++) {
						jcoTable.setRow(j);
						HashMap<String, Object> fieldDatas = new HashMap<String, Object>();
						for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {
							String fieldName = (String) fieldNames.get(k + "");
							fieldDatas.put(fieldName, jcoTable.getString(fieldName));
						}

						rowDatas.add(fieldDatas);
					}
					log.info("getResultMap() -------> " + table.get("name") + " Table is processed Compleately");
				}
				tableDatas.put(tableName, rowDatas);

				log.info("getResultMap()----> Total retrieve row count is " + jcoTable.getNumRows() + ".");
			}
		}

		Map<?, ?> returnValue = Collections.synchronizedMap(tableDatas);

		return returnValue;
	}


	/**
	 * function명과 import value에 대한 Map을 파라메터로 넘겨서 결과값 리턴
	 *
	 * import value는 필드명을 Key로하고, 필드값을 Value로 저장한 Map으로 구성한다.
	 *
	 *
	 * @param functionName
	 * @param importValues
	 * @return
	 * @throws Exception
	 */
	public HashMap<String,Object> getResult(String functionName, Map<?, ?> importValues) throws Exception {

		//function layout 정보
		Map<?, ?> mapFunction = (Map<?, ?>) functions.get(functionName);

		JCoFunction jcoFunc = getSAPFunction(functionName);
		if (jcoFunc == null) {
			log.error("getRestulSets() -----------------------> function " + functionName + " not found in SAP.");
			return null;
		}

		List<?> imports = (List<?>) mapFunction.get("import");
		if (imports != null) {
			for (int i = 0, importCnt = imports.size(); i < importCnt; i++) {
				String importName = (String) ((Map<?, ?>) imports.get(i)).get("name");
				jcoFunc.getImportParameterList().setValue(importName, importValues.get(importName));
				log.info("getResultSet() ---------------> importValue = " + importValues.get(importName) + "importName = " + importName);
			}
		}

		jcoFunc.execute(SAP_dest);
		log.info("getResultMap()----> jcoFunc.execute(jcoDest)");

		/*
		 * 리턴 데이터 확인
		 */

		List<?> exports = (List<?>) mapFunction.get("export");
		String returnStatus = "";
		String exportName = "";

		HashMap<String,Object> tableDatas = new HashMap<String,Object>();

		if (exports != null) {
			for (int i = 0, exportCnt = exports.size(); i < exportCnt; i++) {
				exportName = (String) ((Map<?,?>) exports.get(i)).get("name");
				returnStatus = (String) jcoFunc.getExportParameterList().getValue(exportName);
				tableDatas.put(exportName, returnStatus);
				log.info("getResult() ---------------> exportName = [" + exportName + "] exportValue = [" + returnStatus + "]");
			}
		}

		return tableDatas;
	}

	@SuppressWarnings("unchecked")
	public Map<?,?> getResultTable(String functionName, Map<?,?> inputTableValues) throws Exception {
		log.info("inputTableValues() --------> Map " + inputTableValues);

		Map<?,?> mapFunction = (Map<?,?>) functions.get(functionName);

		JCoFunction jcoFunc = getSAPFunction(functionName);
		if (jcoFunc == null) {
			log.error("getResult() -----------------------> function " + functionName + " not found in SAP.");
			return null;
		}

		// -------------------------------------------------------------
		// Input Table로 설정되었을 경우
		// -------------------------------------------------------------
		List<?> inputTables = (List<?>) mapFunction.get("inputTable");

		if (inputTables != null && inputTableValues != null) {
			log.info("inputTables.size() [" + inputTables.size() + "]");
			for (int i = 0, tableCnt = inputTables.size(); i < tableCnt; i++) {
				// ---------------------------------------------------------
				// XML 설정 inputTable 가져오기
				// ---------------------------------------------------------
				Map<?,?> table = (Map<?,?>) inputTables.get(i);
				String tableName = (String) table.get("name");

				// ---------------------------------------------------------
				// Input Table Value 설정
				// ---------------------------------------------------------
				List<?> inputList = (List<?>) inputTableValues.get(tableName);
				if (inputList == null)
					continue;

				log.info("input tableName [" + tableName + "]");

				JCoTable jcoTable = jcoFunc.getTableParameterList().getTable(tableName);
				Map<?,?> fieldNames = getFieldNames(table);

				log.debug("getResult() ----------> setProcessing ");
				for (int j = 0, rowCnt = inputList.size(); j < rowCnt; j++) {
					jcoTable.appendRow();

					HashMap<String, Object> fieldDatas = (HashMap<String, Object>) inputList.get(j);
					for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {
						String fieldName = (String) fieldNames.get(k + "");
						jcoTable.setValue(fieldName, fieldDatas.get(fieldName));
						log.debug("Values [" + fieldDatas.get(fieldName) + "] fieldName [" + fieldName + "]");

					}
					// log.info("getResult() ---------------> rowDatas = "+rowDatas);
					if (j % 1000 == 0) {
						log.debug(j / 1000 + "천");
					}
				}
				log.debug("getResult() -------> " + table.get("name") + " Table input is processed Compleately");

				log.debug("");
				log.info("getResult()----> Total insert row count is " + jcoTable.getNumRows() + ".");
			}
		}
		log.info("getResult()----> Total  " + jcoFunc);


		jcoFunc.execute(SAP_dest);
		log.info("getResult()----> jcoFunc.execute(jcoDest)");

		// -------------------------------------------------------------
		// output Table로 설정되었을 경우
		// -------------------------------------------------------------
		List<?> tables = (List<?>) mapFunction.get("outputTable");
		HashMap<String, Object> tableDatas = new HashMap<String, Object>();

		if (tables != null) {
			for (int i = 0, tableCnt = tables.size(); i < tableCnt; i++) {
				Map<?,?> table = (Map<?,?>) tables.get(i);
				String tableName = (String) table.get("name");
				log.debug("tableName [" + tableName + "]");

				ArrayList<Map<?,?>> rowDatas = new ArrayList<Map<?,?>>();
				JCoTable jcoTable = jcoFunc.getTableParameterList().getTable(tableName);
				Map<?,?> fieldNames = getFieldNames(table);
				rowDatas.add(fieldNames);

				log.debug("getResult() ----------> setProcessing ");
				for (int j = 0, rowCnt = jcoTable.getNumRows(); j < rowCnt; j++) {
					jcoTable.setRow(j);
					HashMap<String, Object> fieldDatas = new HashMap<String, Object>();
					for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {
						String fieldName = (String) fieldNames.get(k + "");
						fieldDatas.put(fieldName, jcoTable.getString(fieldName));
					}
					rowDatas.add(fieldDatas);
				}
				log.debug("getResult() -------> " + table.get("name") + " Table is processed Compleately");

				tableDatas.put(tableName, rowDatas);
				log.debug("");
				log.info("getResult()----> Total insert row count is " + jcoTable.getNumRows() + ".");
			}
		}

		Map<?,?> returnValue = Collections.synchronizedMap(tableDatas);

		return returnValue;
	}



	public Map<?, ?> getResultMap(String functionName) throws Exception {
		return getResultMap(functionName, null);
	}


	/**
	 * function명과 import value에 대한 Map을 파라메터로 넘겨서 function의 각 테이블에 대한 각각의 Row
	 * Data를 Map에 List로 받아 리턴
	 *
	 * return된 Map은 각 테이블명을 Key로 Table의 RowData를 List 형태의 Value로 구성
	 *
	 * import value는 필드명을 Key로하고, 필드값을 Value로 저장한 Map으로 구성한다.
	 *
	 *
	 * @param functionName
	 * @param inputTableValues
	 * @return
	 * @throws Exception
	 */
	public Map<?, ?> setDataMap(String functionName, Map<?, ?> inputTableValues) throws Exception {
		return setDataMap(functionName, null, null, inputTableValues, true);
	}

	/**
	 * function명과 import value에 대한 Map을 파라메터로 넘겨서 function의 각 테이블에 대한 각각의 Row
	 * Data를 Map에 List로 받아 리턴
	 *
	 * return된 Map은 각 테이블명을 Key로 Table의 RowData를 List 형태의 Value로 구성
	 *
	 * import value는 필드명을 Key로하고, 필드값을 Value로 저장한 Map으로 구성한다.
	 *
	 *
	 * @param functionName
	 * @param inputTableValues
	 * @return
	 * @throws Exception
	 */
	public Map<?,?> setDataMap(String functionName, Map<?,?> importValues, boolean bOutTable) throws Exception {
		return setDataMap(functionName, importValues, null, null, bOutTable);
	}

	/**
	 * function명과 import value에 대한 Map을 파라메터로 넘겨서 function의 각 테이블에 대한 각각의 Row
	 * Data를 Map에 List로 받아 리턴
	 *
	 * return된 Map은 각 테이블명을 Key로 Table의 RowData를 List 형태의 Value로 구성
	 *
	 * import value는 필드명을 Key로하고, 필드값을 Value로 저장한 Map으로 구성한다.
	 *
	 *
	 * @param functionName
	 * @param structureValues
	 * @param inputTableValues
	 * @return
	 * @throws Exception
	 */
	public Map<?,?> setDataMap(String functionName, Map<?,?> structureValues, Map<?,?> inputTableValues, boolean bOutTable) throws Exception {
		return setDataMap(functionName, null, structureValues, inputTableValues, bOutTable);
	}

	/**
	 * function명과 import value에 대한 Map을 파라메터로 넘겨서 function의 각 테이블에 대한 각각의 Row
	 * Data를 Map에 List로 받아 리턴
	 *
	 * return된 Map은 각 테이블명을 Key로 Table의 RowData를 List 형태의 Value로 구성
	 *
	 * import value는 필드명을 Key로하고, 필드값을 Value로 저장한 Map으로 구성한다.
	 *
	 *
	 * @param functionName
	 * @param importValues
	 * @param structureValues
	 * @param inputTableValues
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "unused" })
	public Map<?,?> setDataMap(String functionName, Map<?,?> importValues, Map<?,?> structureValues, Map<?,?> inputTableValues, boolean bOutTable) throws Exception {

		Map<?,?> mapFunction = (Map<?,?>) functions.get(functionName);

		JCoFunction jcoFunc = getSAPFunction(functionName);
		if (jcoFunc == null) {
			log.error("setDataMap() -----------------------> function " + functionName + " not found in SAP.");
			return null;
		}

		// ------------------------------------------------------------------
		// Import 로 설정되었을 경우
		// ------------------------------------------------------------------
		List<?> imports = (List<?>) mapFunction.get("import");
		if (imports != null) {
			for (int i = 0, importCnt = imports.size(); i < importCnt; i++) {
				String importName = (String) ((Map<?, ?>) imports.get(i)).get("name");
				jcoFunc.getImportParameterList().setValue(importName, importValues.get(importName));
				log.info("setDataMap() ---------------> importValue = " + importValues.get(importName) + "importName = " + importName);
			}
		}

		// ------------------------------------------------------------------
		// Structure로 설정되었을 경우
		// ------------------------------------------------------------------
		List<?> structures = (List<?>) mapFunction.get("structure");

		if (structures != null && structureValues != null) {
			for (int i = 0, structureCnt = structures.size(); i < structureCnt; i++) {
				Map<?,?> structure = (Map<?,?>) structures.get(i);
				String structureName = (String) structure.get("name");
				log.info("structureName [" + structureName + "]");

				// ---------------------------------------------------------
				// structure Value 설정
				// ---------------------------------------------------------
				List<?> structureList = (List<?>) structureValues.get(structureName);
				if (structureList == null)
					continue;

				JCoStructure jcoStructure= jcoFunc.getImportParameterList().getStructure(structureName) ;
				Map<?,?> fieldNames = getFieldNames(structure);

				HashMap<String, Object> fieldDatas = (HashMap<String, Object>) structureList.get(i);
				log.debug("setDataMap() ----------> getProcessing fieldNames.size [" + fieldNames.size() + "]");
				for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {
					String fieldName = (String) fieldNames.get(k + "");
					jcoStructure.setValue(fieldName, fieldDatas.get(fieldName));

					log.debug("Values [" + fieldDatas.get(fieldName) + "] fieldName [" + fieldName + "]");
				}
				log.info("setDataMap() -------> " + structure.get("name") + " structure is processed Compleately");
				log.info("setDataMap()----> Total insert field count is " + jcoStructure.getFieldCount() + ".");
			}

		}

		// -------------------------------------------------------------
		// Input Table로 설정되었을 경우
		// -------------------------------------------------------------
		List<?> inputTables = (List<?>) mapFunction.get("inputTable");

		if (inputTables != null && inputTableValues != null) {
			log.info("inputTables.size() [" + inputTables.size() + "]");
			for (int i = 0, tableCnt = inputTables.size(); i < tableCnt; i++) {
				// ---------------------------------------------------------
				// XML 설정 inputTable 가져오기
				// ---------------------------------------------------------
				Map<?,?> table = (Map<?,?>) inputTables.get(i);
				String tableName = (String) table.get("name");

				// ---------------------------------------------------------
				// Input Table Value 설정
				// ---------------------------------------------------------
				List<?> inputList = (List<?>) inputTableValues.get(tableName);
				if (inputList == null)
					continue;

				log.info("input tableName [" + tableName + "]");

				JCoTable jcoTable = jcoFunc.getTableParameterList().getTable(tableName);
				Map<?,?> fieldNames = getFieldNames(table);

				log.debug("setDataMap() ----------> setProcessing ");
				for (int j = 0, rowCnt = inputList.size(); j < rowCnt; j++) {
					jcoTable.appendRow();

					HashMap<String, Object> fieldDatas = (HashMap<String, Object>) inputList.get(j);
					for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {
						String fieldName = (String) fieldNames.get(k + "");
						jcoTable.setValue(fieldName, fieldDatas.get(fieldName));
						log.debug("Values [" + fieldDatas.get(fieldName) + "] fieldName [" + fieldName + "]");

					}
					// log.info("getResultSet() ---------------> rowDatas = "+rowDatas);
					if (j % 1000 == 0) {
						log.debug(j / 1000 + "천");
					}
				}
				log.debug("setDataMap() -------> " + table.get("name") + " Table input is processed Compleately");

				log.debug("");
				log.info("setDataMap()----> Total insert row count is " + jcoTable.getNumRows() + ".");
			}
		}
		log.info("setDataMap()----> Total  " + jcoFunc);


		jcoFunc.execute(SAP_dest);
		log.info("getResultMap()----> jcoFunc.execute(jcoDest)");

		boolean isError = false;
		List<?> exports = (List<?>) mapFunction.get("export");
		String returnStatus = "";
		String exportName = "";

		HashMap<String,Object> tableDatas = new HashMap<String,Object>();

		if (exports != null) {
			for (int i = 0, exportCnt = exports.size(); i < exportCnt; i++) {
				exportName = (String) ((Map<?,?>) exports.get(i)).get("name");
				returnStatus = (String) jcoFunc.getExportParameterList().getValue(exportName);
				tableDatas.put(exportName, returnStatus);
				log.info("setDataMap() ---------------> exportName = [" + exportName + "] exportValue = [" + returnStatus + "]");
			}
			if (returnStatus.equals("")) {
				// log.error("setDataMap() ---------------> error Message = "+myFunction.getExportParameterList().getString(exportName));
				isError = true;
			}
		}

		// -------------------------------------------------------------
		// output Table로 설정되었을 경우
		// -------------------------------------------------------------
		List<?> tables = (List<?>) mapFunction.get("outputTable");

		String rtnCode = "S";
		String rtnMessage = "Success!!";

		if (isError || bOutTable) {
			if (tables != null) {
				for (int i = 0, tableCnt = tables.size(); i < tableCnt; i++) {
					Map<?,?> table = (Map<?,?>) tables.get(i);
					String tableName = (String) table.get("name");
					log.debug("tableName [" + tableName + "]");

					ArrayList<Map<?,?>> rowDatas = new ArrayList<Map<?,?>>();
					JCoTable jcoTable = jcoFunc.getTableParameterList().getTable(tableName);
					Map<?,?> fieldNames = getFieldNames(table);
					rowDatas.add(fieldNames);

					log.debug("setDataMap() ----------> setProcessing ");
					for (int j = 0, rowCnt = jcoTable.getNumRows(); j < rowCnt; j++) {
						jcoTable.setRow(j);
						HashMap<String, Object> fieldDatas = new HashMap<String, Object>();
						for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {
							String fieldName = (String) fieldNames.get(k + "");
							fieldDatas.put(fieldName, jcoTable.getString(fieldName));
							// log.debug("fieldName ["+fieldName+"]");
							if (fieldName.equals("TYPE")) {
								rtnCode = jcoTable.getString(fieldName);
							} else if (fieldName.equals("MESSAGE")) {
								rtnMessage = jcoTable.getString(fieldName);
							}
						}
						// log.info("getResultSet() ---------------> rowDatas = "+rowDatas);
						rowDatas.add(fieldDatas);
					}
					log.debug("setDataMap() -------> " + table.get("name") + " Table is processed Compleately");

					tableDatas.put(tableName, rowDatas);
					log.debug("");
					log.info("setDataMap()----> Total insert row count is " + jcoTable.getNumRows() + ".");
				}
			}
		}

		Map<?,?> returnValue = Collections.synchronizedMap(tableDatas);

		return returnValue;
	}

	@SuppressWarnings("unchecked")
	public Map<?,?> setDataMap(String functionName, Map<?,?> importValues, Map<?,?> inputTableValues) throws Exception {
		log.info("importValues() ------------> Map " + importValues);
		log.info("inputTableValues() --------> Map " + inputTableValues);

		Map<?,?> mapFunction = (Map<?,?>) functions.get(functionName);

		JCoFunction jcoFunc = getSAPFunction(functionName);
		if (jcoFunc == null) {
			log.error("getRestulSets() -----------------------> function " + functionName + " not found in SAP.");
			return null;
		}

		// ------------------------------------------------------------------
		// Import 로 설정되었을 경우
		// ------------------------------------------------------------------
		List<?> imports = (List<?>) mapFunction.get("import");
		if (imports != null) {
			for (int i = 0, importCnt = imports.size(); i < importCnt; i++) {
				String importName = (String) ((Map<?, ?>) imports.get(i)).get("name");
				jcoFunc.getImportParameterList().setValue(importName, importValues.get(importName));
				log.info("getResultSet() ---------------> importValue = " + importValues.get(importName) + "importName = " + importName);
			}
		}

		// -------------------------------------------------------------
		// Input Table로 설정되었을 경우
		// -------------------------------------------------------------
		List<?> inputTables = (List<?>) mapFunction.get("inputTable");

		if (inputTables != null && inputTableValues != null) {
			log.info("inputTables.size() [" + inputTables.size() + "]");
			for (int i = 0, tableCnt = inputTables.size(); i < tableCnt; i++) {
				// ---------------------------------------------------------
				// XML 설정 inputTable 가져오기
				// ---------------------------------------------------------
				Map<?,?> table = (Map<?,?>) inputTables.get(i);
				String tableName = (String) table.get("name");

				// ---------------------------------------------------------
				// Input Table Value 설정
				// ---------------------------------------------------------
				List<?> inputList = (List<?>) inputTableValues.get(tableName);
				if (inputList == null)
					continue;

				log.info("input tableName [" + tableName + "]");

				JCoTable jcoTable = jcoFunc.getTableParameterList().getTable(tableName);
				Map<?,?> fieldNames = getFieldNames(table);

				log.debug("setDataMap() ----------> setProcessing ");
				for (int j = 0, rowCnt = inputList.size(); j < rowCnt; j++) {
					jcoTable.appendRow();

					HashMap<String, Object> fieldDatas = (HashMap<String, Object>) inputList.get(j);
					for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {
						String fieldName = (String) fieldNames.get(k + "");
						jcoTable.setValue(fieldName, fieldDatas.get(fieldName));
						log.debug("Values [" + fieldDatas.get(fieldName) + "] fieldName [" + fieldName + "]");

					}
					// log.info("getResultSet() ---------------> rowDatas = "+rowDatas);
					if (j % 1000 == 0) {
						log.debug(j / 1000 + "천");
					}
				}
				log.debug("setDataMap() -------> " + table.get("name") + " Table input is processed Compleately");

				log.debug("");
				log.info("setDataMap()----> Total insert row count is " + jcoTable.getNumRows() + ".");
			}
		}
		log.info("setDataMap()----> Total  " + jcoFunc);


		jcoFunc.execute(SAP_dest);
		log.info("setDataMap()----> jcoFunc.execute(jcoDest)");

		// -------------------------------------------------------------
		// output Table로 설정되었을 경우
		// -------------------------------------------------------------
		List<?> tables = (List<?>) mapFunction.get("outputTable");
		HashMap<String, Object> tableDatas = new HashMap<String, Object>();

		if (tables != null) {
			for (int i = 0, tableCnt = tables.size(); i < tableCnt; i++) {
				Map<?,?> table = (Map<?,?>) tables.get(i);
				String tableName = (String) table.get("name");
				log.debug("tableName [" + tableName + "]");

				ArrayList<Map<?,?>> rowDatas = new ArrayList<Map<?,?>>();
				JCoTable jcoTable = jcoFunc.getTableParameterList().getTable(tableName);
				Map<?,?> fieldNames = getFieldNames(table);
				rowDatas.add(fieldNames);

				log.debug("setDataMap() ----------> setProcessing ");
				for (int j = 0, rowCnt = jcoTable.getNumRows(); j < rowCnt; j++) {
					jcoTable.setRow(j);
					HashMap<String, Object> fieldDatas = new HashMap<String, Object>();
					for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {
						String fieldName = (String) fieldNames.get(k + "");
						fieldDatas.put(fieldName, jcoTable.getString(fieldName));
					}
					rowDatas.add(fieldDatas);
				}
				log.debug("setDataMap() -------> " + table.get("name") + " Table is processed Compleately");

				tableDatas.put(tableName, rowDatas);
				log.debug("");
				log.info("setDataMap()----> Total insert row count is " + jcoTable.getNumRows() + ".");
			}
		}

		Map<?,?> returnValue = Collections.synchronizedMap(tableDatas);

		return returnValue;
	}

    /**
     * SAP 처리 프로세스 (순서 반드시 지킬 것)
     * 1. getMapFunction   : SAP Interface Pool 정보 생성
     * 2. getFunction      : SAP Interface 수행을 위한 Function 생성
     * 3. getConnection    : SAP Function 수행을 위한 getConnection
     * 4. setRFCMessage    : SAP Interface Message 설정
     * 5. rollBackTrans    : 오류 발생 시 SAP Transaction Rollback 처리 Function 실행
     * 6. commitTrans      : 오류 발생 시 SAP Transaction Commit 처리 Function 실행
	 */

	/**
	 *
	 * sapInterfaceMap 정보 획득 return (String)
	 * mapFunction.get("defaultConnection")
	 *
	 * @param functionName
	 *
	 * @return (Map) functions.get(functionName)
	 */
	public Map<?, ?> getMapFunction(String functionName) throws Exception {
		log.info("getMapFunction()-----> " + functionName);
		log.debug("test here5-7" + functionName);

		return (Map<?, ?>) functions.get(functionName);
	}

	public JCoFunction getJCoFunction(String functionStr, JCoRepository jcoRepo) {
		JCoFunction jcoFunc = null;
		try {
			jcoFunc = jcoRepo.getFunction(functionStr);
		} catch (Exception e) {
			e.printStackTrace();
	        log.error("getJCoFunction Error "+e.getMessage());
			throw new RuntimeException("Problem retrieving SAP JCO.Function object.");
		}
		if (jcoFunc == null) {
	        log.error("getJCoFunction jcoFunc is null");
			throw new RuntimeException("Not possible to receive SAP function. ");
		}

		return jcoFunc;
	}

	public LinkedHashMap<String, JCoFunction> getJCoFunction(List<String> functionList, JCoRepository jcoRepo) {
		LinkedHashMap<String, JCoFunction> jcoFuncs = new LinkedHashMap<String, JCoFunction>();
		try {
			for(int i=0; i< functionList.size(); i++){
				jcoFuncs.put(functionList.get(i), jcoRepo.getFunction(functionList.get(i)));
			}
		} catch (Exception e) {
			e.printStackTrace();
	        log.error("getSAPFunction Error "+e.getMessage());
			throw new RuntimeException("Problem retrieving SAP JCO.Function object.");
		}

		return jcoFuncs;
	}

	/**
	 *
	 * mapFunction 중 defaultConnection 정보 추출 return (String)
	 * mapFunction.get("defaultConnection")
	 *
	 * @param mapFunction
	 *
	 * @return (String) mapFunction.get("defaultConnection")
	 */
	public String getConnectString(Map<?, ?> mapFunction) {
		return (String) mapFunction.get("defaultConnection");
	}


	/**
	 *
	 * SAP RFC 실행을 위한 Function 객체 생성 return JCoDestination
	 *
	 * @param connectString
	 *
	 * @return jcoDest
	 */
	public JCoDestination getJCoDestination(){
		return this.SAP_dest;
	}

	/**
	 *
	 * SAP RFC 실행을 위한 Function 객체 생성 return JCoRepository
	 *
	 * @param connectString
	 *
	 * @return jcoDest
	 */
	public JCoRepository getJCoRepository(JCoDestination jcoDest) throws Exception {

		return this.SAP_repos;
	}

	public void executeFunctions(LinkedHashMap<String, JCoFunction> jcoFuncs, JCoDestination jcoDest) throws JCoException {
		JCoContext.begin(jcoDest);
		try {
			for (int k = 0; k < jcoFuncs.size(); k++) {
				jcoFuncs.get(k+"").execute(jcoDest);
			}
		} finally {
			log.debug("SAP RFC END");
			JCoContext.end(jcoDest);
		}
	}

	/**
	 *
	 * SAP Interface Message 설정 및 RFC 실행 후 return 처리결과 Map
	 *
	 * @param functionName
	 * @param mapFunction
	 * @param jcoDest
	 * @param jcoFunc
	 * @param importValues
	 * @param structureValues
	 * @param inputTableValues
	 * @param bOutTable
	 *
	 * @return Map
	 */
	@SuppressWarnings({ "unchecked", "unused" })
	public Map<?, ?> setRFCMessage( String functionName
			                      , Map<?, ?> mapFunction
                                  , JCoDestination jcoDest
			                      , JCoFunction jcoFunc
			                      , Map<?, ?> importValues
			                      , Map<?, ?> structureValues
			                      , Map<?, ?> inputTableValues
			                      , boolean bOutTable) throws Exception {
		// ------------------------------------------------------------------
		// Import 로 설정되었을 경우
		// ------------------------------------------------------------------
		List<?> imports = (List<?>) mapFunction.get("import");

		if (imports != null && importValues != null) {
			for (int i = 0, importCnt = imports.size(); i < importCnt; i++) {
				String importName = (String) ((Map<?, ?>) imports.get(i)).get("name");
				jcoFunc.getImportParameterList().setValue(importName, importValues.get(importName));
				log.debug("getResultSet() ---------------> importValue = " + importValues.get(importName) + "importName = " + importName);
			}
		}

		// ------------------------------------------------------------------
		// Structure로 설정되었을 경우
		// ------------------------------------------------------------------
		List<?> structures = (List<?>) mapFunction.get("structure");

		if (structures != null && structureValues != null) {
			for (int i = 0, structureCnt = structures.size(); i < structureCnt; i++) {
				Map<?, ?> structure = (Map<?, ?>) structures.get(i);
				String structureName = (String) structure.get("name");
				log.debug("structureName [" + structureName + "]");

				// ---------------------------------------------------------
				// structure Value 설정
				// ---------------------------------------------------------
				List<?> structureList = (List<?>) structureValues.get(structureName);
				if (structureList == null)
					continue;

				JCoStructure jcoStructure = jcoFunc.getImportParameterList().getStructure(structureName);
				Map<?, ?> fieldNames = getFieldNames(structure);

				HashMap<?, ?> fieldDatas = (HashMap<?, ?>) structureList.get(i);
				log.debug("setDataMap() ----------> getProcessing fieldNames.size [" + fieldNames.size() + "]");
				for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {
					String fieldName = (String) fieldNames.get(k + "");
					jcoStructure.setValue(fieldName, fieldDatas.get(fieldName));
					log.debug("Values [" + fieldDatas.get(fieldName) + "] fieldName [" + fieldName + "]");

				}
				log.info("setDataMap() -------> " + structure.get("name") + " structure is processed Compleately");
				log.info("setDataMap()----> Total insert field count is " + jcoStructure.getFieldCount() + ".");
			}

		}

		// -------------------------------------------------------------
		// Input Table로 설정되었을 경우
		// -------------------------------------------------------------
		List<?> inputTables = (List<?>) mapFunction.get("inputTable");

		if (inputTables != null && inputTableValues != null) {
			log.info("inputTables.size() [" + inputTables.size() + "]");
			for (int i = 0, tableCnt = inputTables.size(); i < tableCnt; i++) {
				// ---------------------------------------------------------
				// XML 설정 inputTable 가져오기
				// ---------------------------------------------------------
				Map<?,?> table = (Map<?,?>) inputTables.get(i);
				String tableName = (String) table.get("name");

				// ---------------------------------------------------------
				// Input Table Value 설정
				// ---------------------------------------------------------
				List<?> inputList = (List<?>) inputTableValues.get(tableName);
				if (inputList == null)
					continue;

				log.info("input tableName [" + tableName + "]");

				JCoTable jcoTable = jcoFunc.getTableParameterList().getTable(tableName);
				Map<?,?> fieldNames = getFieldNames(table);

				log.debug("setDataMap() ----------> setProcessing ");
				for (int j = 0, rowCnt = inputList.size(); j < rowCnt; j++) {
					jcoTable.appendRow();

					HashMap<String, Object> fieldDatas = (HashMap<String, Object>) inputList.get(j);
					for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {
						String fieldName = (String) fieldNames.get(k + "");
						jcoTable.setValue(fieldName, fieldDatas.get(fieldName));
						log.debug("Values [" + fieldDatas.get(fieldName) + "]fieldName [" + fieldName + "]");
					}
					// log.info("getResultSet() ---------------> rowDatas = "+rowDatas);
					if (j % 1000 == 0) {
						log.debug(j / 1000 + "천");
					}
				}
				log.debug("setDataMap() -------> " + table.get("name") + " Table input is processed Compleately");

				log.debug("");
				log.info("setDataMap()----> Total insert row count is " + jcoTable.getNumRows() + ".");
			}
		}
		// log.info("setDataMap()----> Total  "+myFunction);

		jcoFunc.execute(jcoDest);

		boolean isError = false;
		List<?> exports = (List<?>) mapFunction.get("export");
		String returnStatus = "";
		String exportName = "";

		HashMap<String, Object> tableDatas = new HashMap<String, Object>();

		if (exports != null) {
			for (int i = 0, exportCnt = exports.size(); i < exportCnt; i++) {
				exportName = (String) ((Map<?,?>) exports.get(i)).get("name");
				returnStatus = (String) jcoFunc.getExportParameterList().getValue(exportName);
				tableDatas.put(exportName, returnStatus);
				log.info("setDataMap() ---------------> exportName = [" + exportName + "] exportValue = [" + returnStatus + "]");
			}
			if (returnStatus.equals("")) {
				// log.error("setDataMap() ---------------> error Message = "+myFunction.getExportParameterList().getString(exportName));
				isError = true;
			}
		}

		// -------------------------------------------------------------
		// output Table로 설정되었을 경우
		// -------------------------------------------------------------
		List<?> tables = (List<?>) mapFunction.get("outputTable");

		String rtnCode = "S";
		String rtnMessage = "Success!!";

		if (isError || bOutTable) {
			if (tables != null) {
				for (int i = 0, tableCnt = tables.size(); i < tableCnt; i++) {
					Map<?,?> table = (Map<?,?>) tables.get(i);
					String tableName = (String) table.get("name");
					log.debug("tableName [" + tableName + "]");

					ArrayList<Map<?,?>> rowDatas = new ArrayList<Map<?,?>>();
					JCoTable jcoTable = jcoFunc.getTableParameterList().getTable(tableName);
					Map<?,?> fieldNames = getFieldNames(table);
					rowDatas.add(fieldNames);

					log.debug("setDataMap() ----------> setProcessing ");
					for (int j = 0, rowCnt = jcoTable.getNumRows(); j < rowCnt; j++) {
						jcoTable.setRow(j);
						HashMap<String, String> fieldDatas = new HashMap<String, String>();
						for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {
							String fieldName = (String) fieldNames.get(k + "");
							fieldDatas.put(fieldName, jcoTable.getString(fieldName));
							// log.debug("fieldName ["+fieldName+"]");
							if (fieldName.equals("TYPE")) {
								rtnCode = jcoTable.getString(fieldName);
							} else if (fieldName.equals("MESSAGE")) {
								rtnMessage = jcoTable.getString(fieldName);
							}
						}
						// log.info("getResultSet() ---------------> rowDatas = "+rowDatas);
						rowDatas.add(fieldDatas);
					}
					log.debug("setDataMap() -------> " + table.get("name") + " Table is processed Compleately");

					tableDatas.put(tableName, rowDatas);
					log.debug("");
					log.info("setDataMap()----> Total insert row count is " + jcoTable.getNumRows() + ".");
				}
			}
		}

		return Collections.synchronizedMap(tableDatas);
	}

	/**
	 *
	 * SAP Rollback 함수 실행
	 *
	 * @param jcoDest
	 * @param jcoRepo
	 * @return void
	 */
	public void rollBackTrans(JCoDestination jcoDest, JCoRepository jcoRepo) throws Exception {

		JCoFunction jcoFunc = jcoRepo.getFunction("BAPI_TRANSACTION_COMMIT");

		if (jcoFunc == null) {
			log.error("getRestulSets() -----------------------> function TRANSACTION_ROLLBACK not found in SAP.");
		}

		jcoFunc.execute(jcoDest);
	}

	/**
	 *
	 * SAP Commit 함수 실행
	 *
	 * @param myClient
	 * @return void
	 */
	public void commitTrans(JCoDestination jcoDest, JCoRepository jcoRepo) throws Exception {

		JCoFunction jcoFunc = jcoRepo.getFunction("BAPI_TRANSACTION_COMMIT");

		if (jcoFunc == null) {
			log.error("getRestulSets() -----------------------> function TRANSACTION_COMMIT not found in SAP.");
		}
		jcoFunc.execute(jcoDest);
	}

	/**
	 *
	 * 테이블 구성 정보를 담은 Map에서 필드정보들을 담을 맵으로 구성해서 Return
	 *
	 * return되는 Map은 필드 순서가 key
	 *
	 * @param table
	 * @return
	 */
	private Map<?,?> getFieldNames(Map<?,?> table) {

		List<?> fields = (List<?>) table.get("field");
		HashMap<String, Object> fieldNames = new HashMap<String, Object>();

		for (int i = 0, fieldCnt = fields.size(); i < fieldCnt; i++) {
			fieldNames.put(i + "", ((Map<?,?>) fields.get(i)).get("name"));
		}
		return Collections.synchronizedMap(fieldNames);
	}

	public JCoFunction createFunction(String name, JCoRepository mRepository) throws Exception {

		JCoFunctionTemplate ft = mRepository.getFunctionTemplate(name.toUpperCase());
		if (ft == null)
			return null;
		return ft.getFunction();
	}




	/**
	 * 최종 메서드
	 * @param functionName
	 * @param importValues
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<?, ?> rfcFunctionCall(String functionName, Map<?, ?> importValues, Map<?,?> inputTableValues, Map<?,?> inputStructureValues) throws Exception {

		JCoFunction jcoFunc = getSAPFunction(functionName);

		if (jcoFunc == null) {
			log.error("rfcFunctionCall() -----------------------> function " + functionName + " not found in SAP.");
			return null;
		}

		//function layout 정보
		Map<?, ?> mapFunction = (Map<?, ?>) functions.get(functionName);

		List<?> imports = (List<?>) mapFunction.get("import");
		if (imports != null) {
			for (int i = 0, importCnt = imports.size(); i < importCnt; i++) {
				String importName = (String) ((Map<?, ?>) imports.get(i)).get("name");
				jcoFunc.getImportParameterList().setValue(importName, importValues.get(importName));
				log.info("rfcFunctionCall() ---------------> importValue = " + importValues.get(importName) + "importName = " + importName);
			}
		}

		List<?> inputTables = (List<?>) mapFunction.get("inputTable");

		if (inputTables != null && inputTableValues != null) {
			log.info("inputTables.size() [" + inputTables.size() + "]");
			for (int i = 0, tableCnt = inputTables.size(); i < tableCnt; i++) {
				// ---------------------------------------------------------
				// XML 설정 inputTable 가져오기
				// ---------------------------------------------------------
				Map<?,?> table = (Map<?,?>) inputTables.get(i);
				String tableName = (String) table.get("name");

				// ---------------------------------------------------------
				// Input Table Value 설정
				// ---------------------------------------------------------
				List<?> inputList = (List<?>) inputTableValues.get(tableName);
				if (inputList == null)
					continue;

				log.info("input tableName [" + tableName + "]");

				JCoTable jcoTable = jcoFunc.getTableParameterList().getTable(tableName);
				Map<?,?> fieldNames = getFieldNames(table);

				for (int j = 0, rowCnt = inputList.size(); j < rowCnt; j++) {
					jcoTable.appendRow();

					HashMap<String, Object> fieldDatas = (HashMap<String, Object>) inputList.get(j);
					for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {
						String fieldName = (String) fieldNames.get(k + "");
						jcoTable.setValue(fieldName, fieldDatas.get(fieldName));
						log.debug("Values [" + fieldDatas.get(fieldName) + "] fieldName [" + fieldName + "]");

					}

					if (j % 1000 == 0) {
						log.debug(j / 1000 + "천");
					}
				}
				log.info("rfcFunctionCall() -------> " + table.get("name") + " Table input is processed Compleately");
				log.info("");
				log.info("rfcFunctionCall()----> Total insert row count is " + jcoTable.getNumRows() + ".");
			}
		}

		// ------------------------------------------------------------------
		// input structure로 설정되었을 경우
		// ------------------------------------------------------------------
		List<?> inputStructure = (List<?>) mapFunction.get("inputStructure");

		if (inputStructure != null && inputStructureValues != null) {
			for (int i = 0, structureCnt = inputStructure.size(); i < structureCnt; i++) {
				Map<?,?> structure = (Map<?,?>) inputStructure.get(i);
				String structureName = (String) structure.get("name");
				log.info("structureName [" + structureName + "]");

				// ---------------------------------------------------------
				// input structure Value 설정
				// ---------------------------------------------------------
				List<?> structureList = (List<?>) inputStructureValues.get(structureName);
				if (structureList == null)
					continue;

				JCoStructure jcoStructure= jcoFunc.getImportParameterList().getStructure(structureName) ;
				Map<?,?> fieldNames = getFieldNames(structure);

				HashMap<String, Object> fieldDatas = (HashMap<String, Object>) structureList.get(i);
				log.debug("rfcFunctionCall() ----------> getProcessing fieldNames.size [" + fieldNames.size() + "]");
				for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {
					String fieldName = (String) fieldNames.get(k + "");
					jcoStructure.setValue(fieldName, fieldDatas.get(fieldName));

					log.debug("Values [" + fieldDatas.get(fieldName) + "] fieldName [" + fieldName + "]");
				}
				log.info("rfcFunctionCall() -------> " + structure.get("name") + " structure is processed Compleately");
				log.info("rfcFunctionCall()----> Total insert field count is " + jcoStructure.getFieldCount() + ".");
			}

		}

		log.info("rfcFunctionCall()----> Total  " + jcoFunc);

		jcoFunc.execute(SAP_dest);

		log.info("rfcFunctionCall()----> jcoFunc.execute(jcoDest)");

		HashMap<String, Object> tableDatas = new HashMap<String, Object>();

		List<?> exports = (List<?>) mapFunction.get("export");
		String returnStatus = "";
		String exportName = "";


		if (exports != null) {
			for (int i = 0, exportCnt = exports.size(); i < exportCnt; i++) {
				exportName = (String) ((Map<?,?>) exports.get(i)).get("name");
				returnStatus = (String) jcoFunc.getExportParameterList().getValue(exportName);
				tableDatas.put(exportName, returnStatus);
				log.info("rfcFunctionCall() ---------------> exportName = [" + exportName + "] exportValue = [" + returnStatus + "]");
			}
		}

		// -------------------------------------------------------------
		// output Structure로 설정되었을 경우
		// -------------------------------------------------------------
		List<?> structures = (List<?>) mapFunction.get("outputStructure");
		String structureName = "";
		if(structures != null){

			HashMap<String,Object> structureData = new HashMap<String,Object>();

			for(int i = 0; i<structures.size(); i++){

				Map<?,?> structure = (Map<?,?>)structures.get(i);
				structureName = (String)structure.get("name");
				JCoStructure jcoStructure = jcoFunc.getExportParameterList().getStructure(structureName);

				Map<?,?> fieldNames = getFieldNames(structure);
				Iterator keys = fieldNames.keySet().iterator();

				while(keys.hasNext()){
					String fieldName = (String) fieldNames.get((String) keys.next());
					structureData.put(fieldName, jcoStructure.getString(fieldName));
				}
			}
			tableDatas.put(structureName, structureData);
		}

		// -------------------------------------------------------------
		// output Table로 설정되었을 경우
		// -------------------------------------------------------------
		List<?> tables = (List<?>) mapFunction.get("outputTable");

		if (tables != null) {
			for (int i = 0, tableCnt = tables.size(); i < tableCnt; i++) {
				Map<?,?> table = (Map<?,?>) tables.get(i);
				String tableName = (String) table.get("name");
				log.info("tableName [" + tableName + "]");

				ArrayList<Map<?,?>> rowDatas = new ArrayList<Map<?,?>>();
				JCoTable jcoTable = jcoFunc.getTableParameterList().getTable(tableName);

				Map<?,?> fieldNames = getFieldNames(table);
				rowDatas.add(fieldNames);

				for (int j = 0, rowCnt = jcoTable.getNumRows(); j < rowCnt; j++) {
					jcoTable.setRow(j);
					HashMap<String, String> fieldDatas = new HashMap<String, String>();
					for (int k = 0, fieldCnt = fieldNames.size(); k < fieldCnt; k++) {

						String fieldName = (String) fieldNames.get(k + "");
						fieldDatas.put(fieldName, jcoTable.getString(fieldName));

					}

					rowDatas.add(fieldDatas);
				}
				log.info("rfcFunctionCall() -------> " + table.get("name") + " Table is processed Compleately");

				tableDatas.put(tableName, rowDatas);
				log.info("");
				log.info("rfcFunctionCall()----> Total row count is " + jcoTable.getNumRows() + ".");
			}
		}

		Map<?, ?> returnValue = Collections.synchronizedMap(tableDatas);

		return returnValue;
	}

}