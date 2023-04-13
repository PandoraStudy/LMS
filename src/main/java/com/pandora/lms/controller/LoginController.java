package com.pandora.lms.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import com.pandora.lms.Service.loginService;

@Controller
public class LoginController {

	@Autowired
	private loginService loginservice;

	@GetMapping("/login")
	public String loginpage() {
		System.out.println("로그인 페이지 접속");

		return "login";
	}

	@PostMapping("/slogin")
	public ModelAndView slogin(HttpServletRequest request) {
		String user_id = request.getParameter("user");
		String user_pass = request.getParameter("pass");

		ModelAndView mv = new ModelAndView();

		int usercheck = loginservice.CheckStudent(user_id, user_pass);

		if (usercheck == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("id", user_id);
			mv.setViewName("index");
			return mv;
		} else {
			mv = loginservice.showAlert();
		}
		return mv;
	}

	@PostMapping("/tlogin")
	public ModelAndView tlogin(HttpServletRequest request) {
		String user_id = request.getParameter("user");
		String user_pass = request.getParameter("pass");

		ModelAndView mv = new ModelAndView();

		int usercheck = loginservice.CheckStudent(user_id, user_pass);

		if (usercheck == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("id", user_id);
			mv.setViewName("index");
			return mv;
		} else {
			mv = loginservice.showAlert();
			return mv;
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/index";
	}
}
