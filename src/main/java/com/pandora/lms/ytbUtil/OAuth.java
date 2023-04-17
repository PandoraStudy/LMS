package com.pandora.lms.ytbUtil;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.java6.auth.oauth2.FileCredentialStore;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.InputStreamReader;
import java.util.List;

public class OAuth {
    /* HTTP 전송 */
    public static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();

    /* JSON 파싱 */
    public static final JsonFactory JSON_FACTORY = new JacksonFactory();

    public Credential authorize(List<String> scopes) throws Exception {
        // 클라이언트 시크릿 JSON 파일 로드합니다.
        GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(
                JSON_FACTORY, new InputStreamReader(OAuth.class.getResourceAsStream("/client_secrets.json"))
        );

        // 자격 증명을 로컬에 저장합니다.
        FileCredentialStore credentialStore = new FileCredentialStore(
                new File(System.getProperty("user.home"), ".credentials/youtube-api-uploadvideo.json"), JSON_FACTORY);

        System.out.println("사용자 홈 디렉토리 : " + System.getProperty("user.home"));

        // 권한 코드 플로우를 설정합니다. (사용자 로그인, 권한 허용 후 코드 발급 준비)
        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, scopes)
                .setCredentialStore(credentialStore)
                .build();

        System.out.println("권한 플로우 : " + flow.newAuthorizationUrl());

        /* redirect_uri 주소의 포트 번호를 설정해줍니다
         * 현재는 localhost:9000/Callback으로 OAuth2.0에 설정됐기 때문에 9000으로 설정합니다.
         * Callback은 기본적으로 반환하는 주소입니다.
         */
        LocalServerReceiver localReceiver = new LocalServerReceiver.Builder()
                .setPort(9000)
                .build();

        System.out.println("Callback : " + localReceiver.getCallbackPath());
        System.out.println("Redirect_URI : " + localReceiver.getRedirectUri());

        /* 현재 위치에서 flow를 실행하여 받아온 코드 값을 이용하여 사용자가 승인한 권한에 대한 액세스 토큰을 발급 받습니다.*/
        return  new AuthorizationCodeInstalledApp(flow, localReceiver).authorize("user");
    }

}