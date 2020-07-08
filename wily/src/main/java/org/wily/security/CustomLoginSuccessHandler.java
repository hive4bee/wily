package org.wily.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.wily.security.domain.RedirectDTO;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		log.warn("Login Success");
		
		List<String> roleNames=new ArrayList<>();
		
		authentication.getAuthorities().forEach(authority->{
			roleNames.add(authority.getAuthority());
		});
		
		log.warn("ROLE NAMES: " + roleNames);
		
		if(roleNames.contains("ROLE_MEMBER")) {
			ObjectMapper objm = new ObjectMapper(); 
			RedirectDTO rdto = new RedirectDTO();
			rdto.setStatus("OK");
			rdto.setUrl("/wily/");
			response.getWriter().print(objm.writeValueAsString(rdto));
			response.getWriter().flush();
		}
		//response.sendRedirect("/wily/");
	}
}
