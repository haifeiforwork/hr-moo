package com.moorim.hr.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		
		String requestURI = request.getRequestURI();
		HttpSession session = request.getSession();
		
		boolean isPermittedURL = false;
		
		if(null == session.getAttribute("user")){
			if("/admin/home".equals(requestURI) || requestURI.indexOf("epLoginRequest") >= 0
					|| "/admin/loginRequest".equals(requestURI)){
				isPermittedURL = true;
			}
			
			if(!isPermittedURL){
				ModelAndView modelAndView = new ModelAndView("redirect:/admin/home");			
				throw new ModelAndViewDefiningException(modelAndView);
			}else{				 
				return true;
			}
		}else{				 
			return true;
		}
	}

	/*@Override
	public void postHandle(	HttpServletRequest request, HttpServletResponse response,
			Object handler, ModelAndView modelAndView) throws Exception {
		System.out.println("############### postHandle executed---");
	}
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
			Object handler, Exception ex) throws Exception {
		System.out.println("############### afterCompletion Completed---");
	}*/
}
