package com.pandora.lms.service;

import okhttp3.*;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
public class ZoomService {


    public String meeting(String accessToken) throws IOException  {
        OkHttpClient client = new OkHttpClient(); /*통신을 위한 OkHttp*/
        String meetingUrl = "https://api.zoom.us/v2/users/date810@naver.com/meetings";
        System.out.println(meetingUrl);

        JSONObject jsonBody = new JSONObject();
        jsonBody.put("topic", "줌 회의 첫 개설 2023_04_12");
        jsonBody.put("type", 2);
        //jsonBody.put("start_time", "2023-04-12T22:00:00");
        jsonBody.put("duration", 40);



        String authHeader = "Bearer " + accessToken;

        MediaType mediaType = MediaType.parse("application/json");

        Headers headers = new Headers.Builder()
                .add("Authorization", authHeader)
                .add("Content-Type", "application/json")
                .build();


        RequestBody body = RequestBody.create(mediaType, jsonBody.toString());

        Request request = new Request.Builder()
                .url(meetingUrl)
                .headers(headers)
                .post(body)
                .build();

        Response response = client.newCall(request).execute();

        if (response.isSuccessful()) {
            JSONObject responseBody = new JSONObject(response.body().string());
            String joinUrl = responseBody.getString("join_url");
            System.out.println("Join URL: " + joinUrl);
            return joinUrl;
        } else {
            String errorMessage = response.body().string();
            System.out.println("Error: " + errorMessage);
            return errorMessage;
        }
    }
}
