package com.pandora.lms.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.pandora.lms.DAO.loginDAO;

@Service
public class loginService {
	
	@Autowired
	private loginDAO logindao;

	public int CheckStudent(String user_id, String user_pass) {

		return logindao.CheckStudent(user_id , user_pass);
	}
	
    public ModelAndView showAlert() {
    	ModelAndView mv = new ModelAndView();
        String message = "아이디가 존재하지 않거나 비밀번호가 일치하지 않습니다.";
        String script = "<script>alert('" + message + "');</script>";
        mv.addObject("sc", script);
        mv.setViewName("login");
        return mv;
    }
    
    
}
