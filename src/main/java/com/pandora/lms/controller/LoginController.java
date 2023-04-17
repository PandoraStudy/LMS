package com.pandora.lms.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.server.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pandora.lms.dto.STDTO;
import com.pandora.lms.service.loginService;

@Controller
public class LoginController {
	
	@Autowired
	private loginService loginservice;
	
	@GetMapping("/login")
	public String loginpage() {
		System.out.println("로그인 페이지 접속");
		
		return "login";
	}
	
	@ResponseBody
	@PostMapping("/trylogin")
	public String Try_login(HttpServletRequest request , HttpSession session) {
		String user_id = request.getParameter("KORN_FLNM");
		System.out.println(request.getParameter("KORN_FLNM"));
		int rsl = loginservice.checkID(user_id);
		if(rsl == 1) {
		session.setAttribute("name", user_id);
		return "redirect:/index";
		}
		
		return "redirect:/login";
	}
	
	/*
	 * @ResponseBody
	 * 
	 * @GetMapping("/test") public List<STDTO> test() { List<STDTO> stdto = new
	 * ArrayList<STDTO>(); STDTO e = new STDTO(); STDTO e2 = new STDTO();
	 * e.setKORN_FLNM("1번"); e2.setKORN_FLNM("2번"); stdto.add(e); stdto.add(e2);
	 * 
	 * return stdto; }
	 */
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/index";
	}
}
