package com.moorim.hr.common;

import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 *  세션 유틸
 */
public class SessionUtil {
	
	private final static Logger logger = LoggerFactory.getLogger(SessionUtil.class);

	/**
	 * 세션값 세팅
	 * @param HttpServletRequest request
	 * @param String key
	 * @param Object value
	 * @return 
	 */
	public static void setProperty(HttpServletRequest request, String key, Object value) {
		HttpSession session = request.getSession();		
		session.setAttribute(key, value);
	}
	
	/**
	 * 세션값 가져오기
	 * @param HttpServletRequest request
	 * @param String key
	 * @return Object
	 */
	public static Object getProperty(HttpServletRequest request, String key) {
		HttpSession session = request.getSession(false);		
		return session == null?null:session.getAttribute(key);
	}
	
	/**
	 * 세션 가져오기
	 * @param HttpServletRequest request
	 * @return HttpSession
	 */
	public static HttpSession getSession(HttpServletRequest request){
		HttpSession session = request.getSession(false);		
		return session;
	}

	/**
	 * 세션값 삭제
	 * @param HttpServletRequest request
	 * @param String key
	 * @return 
	 */
	public static void removeProperty(HttpServletRequest request, String key) {
		HttpSession session = request.getSession();		
		session.removeAttribute(key);
	}

	/**
	 * 세션값 보기
	 * @param HttpServletRequest request
	 * @param String key
	 * @return 
	 */
	public static void viewSessionString(HttpServletRequest request) {		
		HttpSession session = request.getSession(false);
		Enumeration se = session.getAttributeNames();
		while(se.hasMoreElements()){
			String att = (String)se.nextElement();
			logger.debug(att+":"+session.getAttribute(att));
		}
	}
	
	/**
	 * 세션 여부
	 * @param HttpServletRequest request
	 * @return HttpSession
	 */
	public static boolean isSession(HttpServletRequest request){
		HttpSession session = request.getSession(false);
		if(session==null)return false;
		Map user = (Map)getProperty(request, "user");
		if(user == null) return false;
		return true;
	}
	
	/**
	 * 세션 로그인 여부
	 * @param HttpServletRequest request
	 * @return HttpSession
	 */
	public static boolean isHomeLogin(HttpServletRequest request){
		Map user = (Map)getProperty(request, "user");
		if(user == null)return false;
		return false;
	}
	
	/**
	 * 세션 로그인 명
	 * @param HttpServletRequest request
	 * @return HttpSession
	 */
	public static String getHomeLoginName(HttpServletRequest request){
		Map user = (Map)getProperty(request, "user");
		if(user == null) return "";
		String   usernm      = (String) user.get("USER_NAME");
		return usernm;
	}
	
	/**
	 * 세션 로그인 아이디
	 * @param HttpServletRequest request
	 * @return HttpSession
	 */
	public static String getHomeLoginId(HttpServletRequest request){
		Map user = (Map)getProperty(request, "user");
		if(user == null) return "";
		String   userId      = (String) user.get("USER_ID");
		return userId;
	}
	
}