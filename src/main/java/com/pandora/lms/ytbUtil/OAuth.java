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
import com.google.api.client.util.Preconditions;
import com.google.api.services.youtube.YouTube;
import org.springframework.stereotype.Component;

import java.awt.*;
import java.awt.datatransfer.StringSelection;
import java.io.File;
import java.io.InputStreamReader;
import java.util.List;

/**
 * 사용자의 계정에 OAuth2를 사용하여 YouTube Data API (V3)를 통해 비디오를 업로드하는 데모입니다.
 * <p>
 * TODO : 주의, 비디오 파일을 이 애플리케이션으로 업로드하려면 프로젝트 폴더에 파일을 추가해야 합니다!
 *
 * @author Jeremy Walker
 */
@Component
public class OAuth {

    /**
     * HTTP 전송의 전역 인스턴스입니다.
     */
    public static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();

    /**
     * JSON 파싱을 위한 전역 인스턴스입니다.
     */
    public static final JsonFactory JSON_FACTORY = new JacksonFactory();

    /**
     * 설치된 애플리케이션이 사용자의 보호된 데이터에 액세스할 수 있도록 인증합니다.
     * @param scopes YouTube 업로드에 필요한 범위(scope) 목록입니다.
     */
    public static Credential authorize(List<String> scopes) throws Exception {
        // 클라이언트 시크릿을 로드합니다.
        GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(
                JSON_FACTORY, new InputStreamReader(OAuth.class.getResourceAsStream("/client_secrets.json")));


        // 기본값이 대체되었는지 확인합니다 (기본값 = "여기에 X 입력").
        if (clientSecrets.getDetails().getClientId().startsWith("Enter")
                || clientSecrets.getDetails().getClientSecret().startsWith("Enter ")) {
            System.out.println(
                    "Enter Client ID and Secret from https://console.developers.google.com/project/_/apiui/credential"
                            + "into youtube-cmdline-uploadvideo-sample/src/main/resources/client_secrets.json");
            System.exit(1);
        }

        // 파일 자격 증명 저장소를 설정합니다.
        FileCredentialStore credentialStore = new FileCredentialStore(
                new File(System.getProperty("user.home"), ".credentials/youtube-api-uploadvideo.json"), JSON_FACTORY);

        // 권한 코드 플로우를 설정합니다.
        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, scopes).setCredentialStore(credentialStore).build();

        // 로컬 서버를 빌드하고 9000 포트에 바인드합니다.
        LocalServerReceiver localReceiver = new LocalServerReceiver.Builder().setPort(9000).build();

        System.out.println("내일 확인해볼 목록 : " + Preconditions.checkNotNull(flow) );

        // 인증합니다.
        return new AuthorizationCodeInstalledApp(flow, localReceiver).authorize("user");
    }

}