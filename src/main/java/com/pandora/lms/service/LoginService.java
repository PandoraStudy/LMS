package com.pandora.lms.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.pandora.lms.dao.LoginDAO;
import com.pandora.lms.dto.LoginDTO;
import com.pandora.lms.dto.UserInfoDto;
import com.pandora.lms.dto.securityinfo;

import lombok.AllArgsConstructor;
@AllArgsConstructor
@Service
public class LoginService implements UserDetailsService{

    private final LoginDAO loginDAO;
    public LoginDTO login(LoginDTO loginInfo) {
        return loginDAO.login(loginInfo);
    }

    public String instrNo(int userNo) { return loginDAO.instrNo(userNo); }

    public String applNo(int userNo) { return loginDAO.applNo(userNo); }
    
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserInfoDto user = loginDAO.findByUsername(username);
        securityinfo newone = new securityinfo(user);
        newone.setUserno(user.getUSER_NO());
        int no;
        if(user.getUSER_GROUP_CD() == 20 ) {
    		no = loginDAO.getINSTR(user.getUSER_NO());
    		System.out.println("no는?"+no);
    		newone.setINSTR_NO(no);
    	} else if (user.getUSER_GROUP_CD() == 10) {
    		no = loginDAO.getAPPL(user.getUSER_NO());
    		System.out.println("no는?"+no);
    		newone.setAPPL_NO(no);
    	}					
        System.out.println("메소드명 : loadUserByUsername");
        return newone;
    }

	public int getAPPL(int user_NO) {
		return loginDAO.getAPPL(user_NO);
		
	}

	public int getINSTR(int user_NO) {
		
		return loginDAO.getINSTR(user_NO);
	}

	public int save(UserInfoDto userInfoDto) {
		return loginDAO.save(userInfoDto);
		
	}
}
