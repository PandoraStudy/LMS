package com.pandora.lms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.pandora.lms.dao.loginDAO;
import com.pandora.lms.dto.UserDTO;
import com.pandora.lms.security.userdatas;

@Service
public class loginService implements UserDetailsService{
	
	@Autowired
	private loginDAO logindao;


    public ModelAndView showAlert() {
    	ModelAndView mv = new ModelAndView();
        String message = "아이디가 존재하지 않거나 비밀번호가 일치하지 않습니다.";
        String script = "<script>alert('" + message + "');</script>";
        mv.addObject("sc", script);
        mv.setViewName("login");
        return mv;
    }

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserDTO userdto = logindao.checkID(username);
		if(userdto != null) {
			return new userdatas(userdto);
					}
		return null;
	}
    
    
}
