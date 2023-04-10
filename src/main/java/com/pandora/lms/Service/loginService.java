package com.pandora.lms.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pandora.lms.DAO.loginDAO;

@Service
public class loginService {
	
	@Autowired
	private loginDAO logindao;
	
	public int checkID(String user_name) {
		
		return logindao.checkID(user_name);
	}

}
