package com.pandora.lms.controller;

import com.pandora.lms.dto.LoginDTO;
import com.pandora.lms.service.LoginService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@AllArgsConstructor
@Controller
public class LoginController {

    //private final LoginService loginService;
    @GetMapping("/login")
    public String login(HttpSession session){
    	System.out.println("Controller - GET - login");
    	if(session.getAttribute("username") != null) {
    		return "/index";
    	}
         return "/login/login";

    }
//
//    @PostMapping("/login")
//    public String login(HttpServletRequest request){
//    	System.out.println("Controller - POST - login");
//        LoginDTO loginInfo = new LoginDTO();
//        loginInfo.setUSER_ID(request.getParameter("id"));
//        loginInfo.setPSWD(request.getParameter("pw"));
//        loginInfo.setUSER_GROUP_CD(request.getParameter("division"));
//
//        //loginInfo = loginService.login(loginInfo);
//
//        if(loginInfo != null) {
//
//            HttpSession session = request.getSession();
//            session.setAttribute("user_no",loginInfo.getUSER_NO());
//            session.setAttribute("id",loginInfo.getUSER_ID());
//            session.setAttribute("division",loginInfo.getUSER_GROUP_CD());
//            session.setAttribute("name",loginInfo.getKORN_FLNM());
//            if(loginInfo.getUSER_GROUP_CD().equals("20") ){
//                int instr = Integer.parseInt(loginService.instrNo(loginInfo.getUSER_NO()));
//                System.out.println("INSTR_NO : "+instr);
//                session.setAttribute("instr_no",instr);
//            }else if(loginInfo.getUSER_GROUP_CD().equals("10")){
//                String appl = loginService.applNo(loginInfo.getUSER_NO());
//                System.out.println("APPL_NO : "+appl);
//                session.setAttribute("appl_no",appl);
//            }
//            return "redirect:/index";
//        }else{ return "redirect:/login"; }
//    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
