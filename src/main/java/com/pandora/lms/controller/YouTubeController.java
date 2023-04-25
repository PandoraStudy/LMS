package com.pandora.lms.controller;


import com.google.api.client.auth.oauth2.Credential;
import com.pandora.lms.service.YoutubeService;
import com.pandora.lms.ytbUtil.OAuth;
import lombok.AllArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@AllArgsConstructor
public class YouTubeController {
    private final OAuth oAuth;
    private final YoutubeService youtubeService;
    private final SqlSession sqlSession;

    @GetMapping("/lecture")
    public ModelAndView lecture(@RequestParam Map<String, Object> userInfo, HttpSession session) throws JSONException {
        ModelAndView view = new ModelAndView("/youtube/lecture");

        if(session.getAttribute("appl_no") == null) {
            view.setViewName("redirect:/login");
            return view;
        }

        userInfo.put("appl_no", Integer.parseInt((String) session.getAttribute("appl_no")) );
        List<Map<String, Object>> lecture = sqlSession.selectList("youtube.lecture", userInfo);

        view.addObject("lecture", lecture);
        return view;
    }

    @GetMapping("/lectureList")
    public ModelAndView youtubeList(@RequestParam Map<String, Object> lectureInfo, HttpSession session) {
        ModelAndView view = new ModelAndView("youtube/lectureList");

        if(session.getAttribute("appl_no") == null) {
            view.setViewName("redirect:/login");
            return view;
        }

        List<Map<String, Object>> lectList = sqlSession.selectList("youtube.lectList", lectureInfo);
        view.addObject("lectList", lectList);

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
    public ModelAndView uploadVideo() throws Exception {
        ModelAndView view = new ModelAndView("youtube/uploadVideo");

        List<String> scopes = new ArrayList<>();
        scopes.add("https://www.googleapis.com/auth/youtube");

        Credential credential = oAuth.authorize(scopes, true);

        if (credential != null) {
            view.addObject("auth", true);
        } else {
            view.addObject("auth", false);
        }

        return view;
    }

    @PostMapping("/uploadVideo")
    public String uploadVideo(@RequestParam Map<String, Object> videoInfo, @RequestPart(name = "video_file") MultipartFile videoFile) throws Exception {
        System.out.println("동영상 정보 : " + videoInfo);
        System.out.println("동영상 파일 : " + videoFile);

        List<String> scopes = new ArrayList<>();
        scopes.add("https://www.googleapis.com/auth/youtube");

        oAuth.authorize(scopes, true);

        return "redirect:/uploadVideo";
    }

    @PostMapping("/youtubeAccess")
    @ResponseBody
    public String youtubeAccess() throws Exception {
        List<String> scopes = new ArrayList<>();
        scopes.add("https://www.googleapis.com/auth/youtube");

        Credential credential = oAuth.authorize(scopes, false);
        if (credential != null) {
            return "인증이 완료 됐습니다.";
        } else {
            return null;
        }
    }

}