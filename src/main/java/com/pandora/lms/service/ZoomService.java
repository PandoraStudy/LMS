package com.pandora.lms.service;

import okhttp3.*;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
public class ZoomService {


    public String meeting(String accessToken) throws IOException  {
        OkHttpClient client = new OkHttpClient(); /*통신을 위한 OkHttp*/

        String meetingUrl = "https://api.zoom.us/v2/users/date810@naver.com/meetings"; // date810@naver.com :사용자 ID 필요함

        // Zoom API 요청에 필요한 회의 개설내용 정의
        JSONObject jsonBody = new JSONObject();
        jsonBody.put("topic", "줌 회의 첫 개설 2023_04_12");  //회의 이름
        jsonBody.put("type", 2);// 회의 타입  >> 0: 기본 회의, 1: 일회성 회의, 2: 반복 회의
        //jsonBody.put("start_time", "2023-04-12T22:00:00");    //회의 시작시간_기본 현재시간
        jsonBody.put("duration", 40);   //회의 시간 (40분)

        //Zoom API 요청에 필요한 HTTP 헤더를 정의
        String authHeader = "Bearer " + accessToken;
        MediaType mediaType = MediaType.parse("application/json");
        Headers headers = new Headers.Builder()
                .add("Authorization", authHeader)
                .add("Content-Type", "application/json")
                .build();

        //Zoom API 요청 생성
        RequestBody body = RequestBody.create(mediaType, jsonBody.toString());
        Request request = new Request.Builder()
                .url(meetingUrl)
                .headers(headers)
                .post(body)
                .build();

        //Zoom API 요청
        Response response = client.newCall(request).execute();
        //요청 성공시 회의 url 반환
        if (response.isSuccessful()) {
            JSONObject responseBody = new JSONObject(response.body().string());
            String joinUrl = responseBody.getString("join_url");
            System.err.println("Join URL: " + joinUrl);
            return joinUrl;
        } else { //요청 실패시 에러메시지 반환
            String errorMessage = response.body().string();
            System.err.println("Error: " + errorMessage);
            return errorMessage;
        }
    }
}
