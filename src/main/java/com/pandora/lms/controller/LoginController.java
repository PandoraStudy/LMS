package com.pandora.lms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.pandora.lms.security.callnowsession;
import com.pandora.lms.service.loginService;

@Controller
public class LoginController {

	@GetMapping("/login")
	public String loginpage() {
		System.out.println("로그인 페이지 접속");

		return "login";
	}
	
	@GetMapping("/loginfail")
	public ModelAndView loginfailpage() {
		System.out.println("로그인 실패 페이지 접속");
		ModelAndView mv = new ModelAndView("/login");
		loginService loginservice = new loginService();
		mv = loginservice.showAlert();

		return mv;
	}
	
	//@Secured({"ROLE_USER" , "ROLE_ADMIN"}) 메소드의 사용 권한을 제한하는 어노테이션
	@GetMapping("/onlyuser")
	public String onlyuserpage() {
		callnowsession session = new callnowsession();
		System.out.println("접속자 아이디 : "+session.getsessionid());
		System.out.println("접속자 권한 : "+session.getsessionAuth());
		return "onlyuser";
	}
	
	//@Secured("ROLE_ADMIN")
	@GetMapping("/onlyadmin")
	public String onlyadminpage() {
		callnowsession session = new callnowsession();
		System.out.println("접속자 아이디 : "+session.getsessionid());
		System.out.println("접속자 권한 : "+session.getsessionAuth());
		return "onlyadmin";
	}
	
	//@Secured({"ROLE_INSTR" , "ROLE_ADMIN"})
	@GetMapping("/onlyinstr")
	public String onlyinstrpage() {
		callnowsession session = new callnowsession();
		System.out.println("접속자 아이디 : "+session.getsessionid());
		System.out.println("접속자 권한 : "+session.getsessionAuth());
		return "onlyinstr";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/index";
	}
}
