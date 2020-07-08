package org.wily.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.wily.security.domain.RedirectDTO;

import com.fasterxml.jackson.databind.ObjectMapper;

public class CustomLoginFailureHandler implements AuthenticationFailureHandler {
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		ObjectMapper objm = new ObjectMapper();
		RedirectDTO rdto = new RedirectDTO();
		rdto.setStatus("FAIL");
		response.getWriter().print(objm.writeValueAsString(rdto));
		response.getWriter().flush();
		return;
	}
}
