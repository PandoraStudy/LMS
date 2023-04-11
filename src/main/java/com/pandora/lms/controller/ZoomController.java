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

        FormBody formBody = new FormBody.Builder()
                .add("code", code) // 1단계에서 받은 code 값
                .add("redirect_uri", "http://localhost/_new/support/reservation/zoomApi") //등록 된 uri
                .add("grant_type", "authorization_code") // 문서에 명시 된 grant_type
                .add("code_verifier", DecEncUtil.encode(code)) // code를 SHA-256 방식으로 암호화하여 전달
                .build();

        System.err.println(code);

        return "zoom";
    }



}

