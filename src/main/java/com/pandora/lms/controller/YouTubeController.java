package com.pandora.lms.controller;


//github.com/PandoraStudy/LMS.git

import java.awt.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.InvocationTargetException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import lombok.Value;
import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.api.client.auth.oauth2.Credential;
import com.pandora.lms.service.YoutubeService;
import com.pandora.lms.ytbUtil.OAuth;

import lombok.AllArgsConstructor;
import org.springframework.web.servlet.config.annotation.CorsRegistry;

@Controller
@AllArgsConstructor
public class YouTubeController {
    private final OAuth oAuth;
    private final YoutubeService youtubeService;
    private final SqlSession sqlSession;

    @GetMapping("/lecture")
    public ModelAndView lecture(@RequestParam Map<String, Object> userData) throws JSONException {
        ModelAndView mv = new ModelAndView("/youtube/lecture");


        List<Map<String, Object>> lectureInfo = sqlSession.selectList("youtube.lectureInfo", userData);

        JSONArray jAlectureInfo = new JSONArray(lectureInfo);
        JSONObject json = new JSONObject();
        json.put("jAlectureInfo", jAlectureInfo);

        mv.addObject("lectureInfo", json);

        return mv;
    }

    @GetMapping("/lectureList")
    public ModelAndView youtubeList(@RequestParam(name = "playlist_id") String playlistId) {
        ModelAndView view = new ModelAndView();
        view.addObject("playlistId", playlistId);
        view.setViewName("youtube/lectureList");
        System.out.println(playlistId);
        return view;
    }

    @GetMapping("/lectureDetail")
    public ModelAndView lectureDetail(@RequestParam Map<String, Object> userData) {
        ModelAndView view = new ModelAndView("youtube/lectureDetail");
        /* 추후 세션이나 사용자 인증 아이디 값으로 변경 */
        userData.put("student_no", "131");
        userData.put("video_id", userData.get("video_id"));
        int playTime = sqlSession.selectOne("youtube.getPlayTime", userData);
        view.addObject("playTime", playTime);
        view.addObject("videoId", userData.get("video_id"));

        return view;
    }

    @PostMapping("/getPlayTime")
    @ResponseBody
    public Integer getPlayTime(@RequestParam Map<String, Object> userData) {
        return sqlSession.selectOne("youtube.getPlayTime", userData);
    }

    @PostMapping("/playTimeSave")
    @ResponseBody
    public String playTimeSave(@RequestParam Map<String, Object> userData) {
        int result = sqlSession.update("youtube.playTimeSave", userData);
        String msg = (result == 1) ? userData.get("curr_time") + "초 저장 완료" : "저장 실패";

        return msg;
    }

    @GetMapping("/uploadVideo")
    public String uploadVideo() {
        return "youtube/uploadVideo";
    }

    @PostMapping("/youtubeAccess")
    @ResponseBody
    public String youtubeAccess() throws IOException {
        List<String> scopes = new ArrayList<>();
        scopes.add("https://www.googleapis.com/auth/youtube");

        try {
            Credential credential = oAuth.authorize(scopes);

            if(credential != null) {
                System.out.println("결과 : " + credential.getAccessToken());
                return credential.getAccessToken();
            } else {
                return null;
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}