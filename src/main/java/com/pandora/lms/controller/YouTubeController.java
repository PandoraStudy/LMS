package com.pandora.lms.controller;

import lombok.AllArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

@Controller
@AllArgsConstructor
public class YouTubeController {

    private final SqlSession sqlSession;

    @GetMapping("/youtube")
    public String YouTube() {
        return "youtube/youtube";
    }

    @GetMapping("/youtubeList")
    public ModelAndView youtubeList() {
        ModelAndView view = new ModelAndView();
        view.setViewName("youtube/youtubeList");
        return view;
    }

    @GetMapping("/youtubeDetail")
    public ModelAndView youtubeDetail() {
        ModelAndView view = new ModelAndView();

        /* 임시적으로 임의 값 넣고 진행 추후 수정해야 합니다. */
        Map<String, Object> userData = new HashMap<>();
        userData.put("video_id", "q2I2w4jksCQ");
        userData.put("student_no", "131");

        System.out.println(userData);

        int playTime = sqlSession.selectOne("youtube.getPlayTime", userData);

        view.addObject("playTime", playTime);
        view.setViewName("youtube/youtubeDetail");

        return view;
    }

    @PostMapping("/getPlayTime")
    @ResponseBody
    public Integer getPlayTime(@RequestParam Map<String, Object> userData) {
        System.out.println(userData);
        return sqlSession.selectOne("youtube.getPlayTime", userData);
    }

    @PostMapping("/playTimeSave")
    @ResponseBody
    public String playTimeSave(@RequestParam Map<String, Object> userData) {
        System.out.println(userData);
        int result = sqlSession.update("youtube.playTimeSave", userData);
        String msg = (result == 1) ? userData.get("curr_time") + "초 저장 완료" : "저장 실패";
        return msg;
    }

}