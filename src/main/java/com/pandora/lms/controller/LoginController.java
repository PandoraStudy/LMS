package com.pandora.lms.controller;

import com.pandora.lms.dto.LoginDTO;
import com.pandora.lms.service.LoginService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@AllArgsConstructor
@Controller
public class LoginController {

    private final LoginService loginService;
    @GetMapping("/login")
    public String login(){
        //if(session.getAttribute("id").equals("")){ return "login/login"; }
       // else{ return "redirect:/index";  }
        return "login/login";
    }

    @PostMapping("/login")
    public String login(HttpServletRequest request){
        LoginDTO loginInfo = new LoginDTO();
        loginInfo.setUSER_ID(request.getParameter("id"));
        loginInfo.setPSWD(request.getParameter("pw"));
        loginInfo.setUSER_GROUP_CD(request.getParameter("division"));

        loginInfo = loginService.login(loginInfo);

        if(loginInfo != null) {

            HttpSession session = request.getSession();
            session.setAttribute("user_no",loginInfo.getUSER_NO());
            session.setAttribute("id",loginInfo.getUSER_ID());
            session.setAttribute("pw",loginInfo.getPSWD());
            session.setAttribute("division",loginInfo.getUSER_GROUP_CD());
            session.setAttribute("name",loginInfo.getKORN_FLNM());
            if(loginInfo.getUSER_GROUP_CD().equals("0020") ){
                String instr = loginService.instrNo(loginInfo.getUSER_NO());
                System.out.println("INSTR_NO : "+instr);
                session.setAttribute("instr_no",instr);
            }
            return "redirect:/index";
        }else{ return "redirect:/login"; }
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
