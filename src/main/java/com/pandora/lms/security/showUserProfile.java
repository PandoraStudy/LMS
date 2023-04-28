package com.pandora.lms.security;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import com.pandora.lms.dto.securityinfo;
import com.pandora.lms.service.LoginService;

public class showUserProfile {
	
	private String username , user_id;
	private int applno , instrno , userno;
	private String division;
	
	public int getApplno() {
		return applno;
	}

	public void setApplno(int applno) {
		this.applno = applno;
	}

	public int getInstrno() {
		return instrno;
	}

	public void setInstrno(int instrno) {
		this.instrno = instrno;
	}

	
	public String getUsername() {
		return username;
	}

	public showUserProfile() {		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Object principal = authentication.getPrincipal();
		if (principal instanceof UserDetails) {
            securityinfo userDetails = (securityinfo) principal;
            this.setUser_id(userDetails.getUsername());
            Collection<? extends GrantedAuthority> authorities = userDetails.getAuthorities();
            for (GrantedAuthority grantedAuthority : authorities) {
            	String authority = grantedAuthority.getAuthority();
            	System.out.println("권한은?? : " + authority);
            	this.applno=userDetails.getAPPL_NO();
            	this.instrno=userDetails.getINSTR_NO();
            	this.division = authority;
            	this.username = userDetails.getUser_name();
            	this.userno = userDetails.getUserno();
            String password = userDetails.getPassword();

            // 사용자 정보 출력
            System.out.println("Username: " + username);
            System.out.println("Password: " + password);

        }
	}

	}

	public int getUserno() {
		return userno;
	}

	public void setUserno(int userno) {
		this.userno = userno;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}	
}
