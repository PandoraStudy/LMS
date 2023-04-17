package com.pandora.lms.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.pandora.lms.dto.UserDTO;
//스프링시큐리티의 로그인 프로세스에서 반드시 요구하는 객체로 로그인한 사용자의 DTO 객체를 이 클래스파일로 가지고 와서 아이디 , 비밀번호 , 권한 등을 얻어감
public class userdatas implements UserDetails {
	
	private UserDTO userdto;
	
	public userdatas(UserDTO userdto)
	{
		this.userdto = userdto;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> collect = new ArrayList<GrantedAuthority>();
		collect.add(new GrantedAuthority() {
			
			@Override
			public String getAuthority() {
				// TODO Auto-generated method stub
				return userdto.getUSER_GROUP_CD();
			}
		});
		return collect;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return userdto.getPSWD();
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return userdto.getUSER_ID();
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
