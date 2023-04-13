package com.pandora.lms.service;

import okhttp3.*;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

@Service
public class ZoomService {

    public String meeting(String accessToken) throws IOException {
        OkHttpClient client = new OkHttpClient(); /*통신을 위한 OkHttp*/

        String meetingUrl = "https://api.zoom.us/v2/users/date810@naver.com/meetings"; // date810@naver.com :사용자 ID 필요함

        // Zoom API 요청에 필요한 회의 개설내용 정의
        JSONObject jsonBody = new JSONObject();
        jsonBody.put("topic", "줌 회의 첫 개설 2023_04_13");  //회의 이름
        jsonBody.put("type", 2);// 회의 타입  >> 0: 기본 회0의, 1: 일회성 회의, 2: 반복 회의
        //jsonBody.put("start_time", "2023-04-12T22:00:00");    //회의 시작시간_기본 현재시간
        jsonBody.put("duration", 40);   //회의 시간 (40분)
        jsonBody.put("password", "1234");
        // settings 객체 생성
        JSONObject settings = new JSONObject();
        settings.put("join_before_host", true);   // 호스트가 입장하기 전에 참여 가능 여부
        settings.put("auto_approve", true);       // 참여 요청 승인 설정
        jsonBody.put("settings", settings);


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
            System.err.println(responseBody);
            String meeting_no = Long.toString(responseBody.getLong("id"));
            String meeting_ps = responseBody.getString("h323_password");
            System.err.println("미팅 참가 번호 : "+meeting_no);
            System.err.println("미팅 참가 비번 : "+meeting_ps);

            String joinUrl = responseBody.getString("join_url");

            System.err.println("Join URL: " + joinUrl);
            return joinUrl;
        } else { //요청 실패시 에러메시지 반환
            String errorMessage = response.body().string();
            System.err.println("Error: " + errorMessage);
            return errorMessage;
        }
    }

   /* public void userlist(String accessToken, String meetingid) throws IOException {

        // Zoom API 엔드포인트 URL 생성
        String url = String.format("https://api.zoom.us/v2/users/meetings/%s/participants", meetingid);

        // HTTP GET 요청 생성 및 설정
        HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", "Bearer " + accessToken);
        con.setRequestProperty("Content-Type", "application/json");

        // 응답 코드 확인
        int status = con.getResponseCode();
        if (status == HttpURLConnection.HTTP_OK) {
            // 응답 데이터 읽기
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();
            response.append("{");
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // JSON 파싱
            JSONObject jsonResponse = new JSONObject(response.toString());
            JSONArray participants = jsonResponse.getJSONArray("participants");
            // 모든 참여자 정보 출력
            for (int i = 0; i < participants.length(); i++) {
                JSONObject participant = participants.getJSONObject(i);
                String name = participant.getString("name");
                String joinTime = participant.getString("join_time");
                String leaveTime = participant.getString("leave_time");
                System.out.println("참여자 이름: " + name);
                System.out.println("참여 시간: " + joinTime);
                System.out.println("나간 시간: " + leaveTime);
            }
        } else {
            // 오류 발생
            System.err.println("Zoom API 오류: " + con.getResponseMessage());
        }
        con.disconnect();
  }*/



}