package com.pandora.lms.controller;

import com.google.api.client.auth.oauth2.Credential;
import com.pandora.lms.service.YoutubeService;
import com.pandora.lms.service.YoutubeServiceImpl;
import com.pandora.lms.ytbUtil.OAuth;
import lombok.AllArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@AllArgsConstructor
public class YouTubeController {
    private final OAuth oAuth;
    private final YoutubeService youtubeService;
    private final SqlSession sqlSession;
    private YoutubeServiceImpl youtubeServiceImpl;

    @GetMapping("/lecture")
    public ModelAndView lecture(@RequestParam Map<String, Object> userData) {
    	ModelAndView mv = new ModelAndView("/youtube/lecture");

    	//List<Map<String, Object>> info = youtubeServiceImpl.lectureInfo();

		//mv.addObject("info", info);
    	List<Map<String, Object>> lectureInfo = sqlSession.selectList("youtube.lectureInfo", userData);
    	System.out.println(lectureInfo);
        mv.addObject("lectureInfo", lectureInfo);

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

    @PostMapping("/uploadVideo")
    public String uploadVideo(@RequestPart(value = "video_file") MultipartFile videoFile) {
        List<String> scopes = new ArrayList<>();
        scopes.add("https://www.googleapis.com/auth/youtube");
        try {
            Credential credential = oAuth.authorize(scopes);
            youtubeService.uploadVideo(credential, videoFile);
        } catch (Exception e) {
            System.out.println("에러..");
            throw new RuntimeException(e);
        }

//        String url = flow.newAuthorizationUrl().setRedirectUri("http://localhost:9000/Callback").build();

        return "index";
    }

}