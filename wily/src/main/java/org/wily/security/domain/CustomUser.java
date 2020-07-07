package org.wily.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.wily.domain.MemberDTO;

public class CustomUser extends User {
	private static final long serialVersionUID=1L;
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username,password,authorities);
	}
	public CustomUser(MemberDTO dto) {
		super(dto.getMid(),dto.getMpw(),dto.getAuthList()
											.stream()
											.map(auth->new SimpleGrantedAuthority(auth.getAuth()))
											.collect(Collectors.toList())
		);
	}
}
