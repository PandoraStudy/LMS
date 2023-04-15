package com.pandora.lms.controller;

import com.pandora.lms.service.YoutubeService;
import lombok.AllArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

@Controller
@AllArgsConstructor
public class YouTubeController {

    private final YoutubeService youtubeService;

    private final SqlSession sqlSession;

    @GetMapping("/lecture")
    public String lecture() {
        return "/youtube/lecture";
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

    /* 기능 미구현 상태
     *  @GetMapping("/OAuthTest")
     *     public String OAuthTest() {
     *         return "youtube/oauthTest";
     *     }
     *
     *  @GetMapping("/youtubeUpload") public String yotubeUpload() {
     *          return "youtube/youtubeUpload";
     *     }
     *
     *  @PostMapping("/youtubeUpload") public String youtubeUpload(@RequestParam Map<String, Object> lectureInfo, @RequestPart(name="lecture_video") MultipartFile lectureVideo) {
     *          System.out.println(lectureVideo);
     *          System.out.println(lectureInfo);
     *          return "";
     *     }
     */

}