package com.pandora.lms.security;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

public class callnowsession {
	
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String username;
	List<String> usergroup;
	
	public callnowsession() {
		if (principal instanceof UserDetails) {
			this.username = ((UserDetails) principal).getUsername();
			this.usergroup = ((UserDetails) principal).getAuthorities().stream().map(GrantedAuthority::getAuthority)
					.collect(Collectors.toList());
			;
			System.out.println("현재 로그인한 사용자의 아이디: " + username);
			System.out.println("현재 로그인한 사용자의 권한: " + usergroup);
		} else {
			this.username = principal.toString();

			System.out.println("현재 로그인한 사용자의 이름: " + username);

		}
	}
	
	
	public String getsessionid() {

		return this.username;
	}
	
	public String getsessionAuth() {

		return this.usergroup.toString();
	}
}