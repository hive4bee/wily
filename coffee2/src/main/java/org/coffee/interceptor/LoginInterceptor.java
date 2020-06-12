package org.coffee.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter implements SessionNames {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("preeeeeeeeeeeeeeeeeeeeeeee");
		System.out.println("preeeeeeeeeeeeeeeeeeeeeeee: " + request.getRequestURI());
		System.out.println("preeeeeeeeeeeeeeeeeeeeeeee: " + handler);
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("mid");
		if(obj == null) {
			request.getSession().setAttribute("prevPage", request.getRequestURI());
			response.sendRedirect("/members/loginForm");
			return false;
		}
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("afterrrrrrrrrrrrrrrrrrrrrrrrr");
		System.out.println("//////////////////////////"+modelAndView.getViewName());
		System.out.println("after : " + request.getRequestURI());
	}
}
