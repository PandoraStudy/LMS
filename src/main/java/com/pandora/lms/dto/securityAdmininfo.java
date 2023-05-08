package com.pandora.lms.dto;

import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class securityAdmininfo implements UserDetails{
	
	private AdminInfoDto userinfodto;
	private int userno;
	private int APPL_NO;
	private int INSTR_NO;
	private String user_name , user_id , division;
	@Override
	public boolean equals(Object obj) {
		if (obj instanceof securityAdmininfo) {
			return this.user_name.equals(((securityAdmininfo)obj).user_name);
		}
		return false;
	}
	
	@Override
	public int hashCode() {
		return this.user_name.hashCode();
		}

	public securityAdmininfo(AdminInfoDto userinfodto) {
		System.out.println("메소드명 : securityinfo");
		this.userno = userinfodto.getADMIN_NO();
		this.user_name = userinfodto.getKORN_FLNM();
		System.out.println(userno);
		
		this.userinfodto = userinfodto;

	}
	

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> collect = new ArrayList<GrantedAuthority>();
		collect.add(new GrantedAuthority() {
			
			@Override
			public String getAuthority() {
				
				return Integer.toString(userinfodto.getUSER_GROUP_CD());
			}
		});
		return collect;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return userinfodto.getPSWD();
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return userinfodto.getADMIN_ID();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
}
