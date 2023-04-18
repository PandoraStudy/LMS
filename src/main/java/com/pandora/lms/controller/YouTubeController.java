package com.pandora.lms.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.pandora.lms.service.YoutubeServiceImpl;
import com.pandora.lms.ytbUtil.OAuth;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class YouTubeController {
    private final SqlSession sqlSession;
    
    @GetMapping("/lecture")
    public ModelAndView lecture(@RequestParam Map<String, Object> userData) throws JSONException {
    	ModelAndView mv = new ModelAndView("/youtube/lecture");
    	
    	List<Map<String, Object>> lectureInfo = sqlSession.selectList("youtube.lectureInfo", userData);
    	
    	JSONArray jAlectureInfo = new JSONArray(lectureInfo);
        JSONObject json = new JSONObject();
        json.put("jAlectureInfo", jAlectureInfo);
        
    	System.out.println(lectureInfo);
    	
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

    @GetMapping("/OAuth")
    public String OAuthTest() {
        return "youtube/oauthTest";
    }

    @PostMapping("/OAuth")
    @ResponseBody
    public String youtubeUpload() {
        String access_token = "인증 코드를 발급 받아주세요.";

        OAuth oAuth = new OAuth();

        List<String> scopes = new ArrayList<>();
        scopes.add("https://www.googleapis.com/auth/youtube.upload");

        try {
            access_token = oAuth.authorize(scopes).getAccessToken();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return access_token;
    }

    @GetMapping("/youtubeUpload")
    public String yotubeUpload() {
        return "youtube/youtubeUpload";
    }

    @PostMapping("/videoUpload")
    public void videoUpload(@RequestParam Map<String, Object> userVideoInfo, @RequestPart(value = "lecture_video") MultipartFile userVideo) {
    }

}