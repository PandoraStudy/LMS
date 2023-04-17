package com.pandora.lms.security;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
//세션에 접근하여 필요한 정보를 획득하기 위한 세션조회클래스
public class callnowsession {
	
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	String username; //유저 ID
	List<String> usergroup; //유저 권한
	
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