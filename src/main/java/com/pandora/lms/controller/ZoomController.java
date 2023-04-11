package com.pandora.lms.controller;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ZoomController {

    @GetMapping("/zoom")/*줌 관리 페이지 띄우기용*/
    public String zoom() {
        return "zoom";
    }

    @GetMapping("/zoom/token")/*토큰 발급 받고 코드 값을 가져옴*/
    public String get_token(@RequestParam("code") String code) throws IOException {
        OkHttpClient client = new OkHttpClient(); /*통신을 위한 OkHttp*/
        ObjectMapper mapper = new ObjectMapper();/*Json 처리를 위하여 생성*/

        String zoomUrl = "https://zoom.us/oauth/token"; //Access token 을 받는 zoom api 호출 url

        FormBody formBody = new FormBody.Builder()/*http 요청 바디를 만듬*/
                .add("code", code) // 1단계에서 받은 code 값
                .add("redirect_uri", "http://localhost/zoom/token") //등록 된 uri
                .add("grant_type", "authorization_code") // 문서에 명시 된 grant_type
                /*.add("code_verifier", DecEncUtil.encode(code))*/ // 나중에 시간이 된다면 code를 SHA-256 방식으로 암호화하여 전달할 예정
                .build();

        Request zoomRequest = new Request.Builder()/*http 요청을 생성하기 위해 만듬*/
                .url(zoomUrl) // 호출 url
                .addHeader("Content-Type", "application/x-www-form-urlencoded") // 공식 문서에 명시 된 type
                .addHeader("Authorization", "Basic") // Client_ID:Client_Secret 을  Base64-encoded 한 값
                .post(formBody)
                .build();


        Response zoomResponse = client.newCall(zoomRequest).execute();/*client를 사용하여 zoomRequest를 서버로 보내고 응답 받은 내용을  zoomResponse에 저장*/
        String zoomText = zoomResponse.body().string();/*zoomResponse 응답 받은 내용을 문자열로 바꿔줌*/


        mapper.configure(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY, true);/*위에서 생성한  ObjectMapper에 벨류값을 배열 타입으로 만들어줌*/
        Map<String, Object> list = new HashMap<String, Object>();
        list = mapper.readValue(zoomText, new TypeReference<HashMap<String, Object>>() {});
        System.out.println("response :: " + list);// model.addAttribute("response", list.get(0));


        //model.addAttribute("code", code);
        return "";
    }



}

