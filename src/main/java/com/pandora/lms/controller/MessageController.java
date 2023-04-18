package com.pandora.lms.controller;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@AllArgsConstructor
@Controller
public class MessageControllor {

    @GetMapping("/Message")
    public String message(){
        return "/message/message";
    }

}
