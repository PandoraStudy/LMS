package com.pandora.lms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ZoomController {

    @GetMapping("/zoom")/*줌 관리 페이지 띄우기용*/
    public String zoom() {
        return "zoom";
    }

    @GetMapping("/zoom/gettoken")/*토큰 발급 받고 코드 값을 가져옴*/
    public String get_token(@RequestParam("code") String code) {

        String zoomUrl = "https://zoom.us/oauth/token";


        System.err.println(code);

        return "zoom";
    }



}

