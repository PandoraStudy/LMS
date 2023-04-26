package com.pandora.lms.controller;


import com.google.api.client.auth.oauth2.Credential;
import com.pandora.lms.service.YoutubeService;
import com.pandora.lms.ytbUtil.OAuth;
import lombok.AllArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Controller
@AllArgsConstructor
public class YouTubeController {
    private final OAuth oAuth;
    private final YoutubeService youtubeService;
    @Autowired
    private  SqlSession sqlSession;

    @GetMapping("/lecture")
    public ModelAndView lecture(@RequestParam Map<String, Object> userInfo, HttpSession session) throws JSONException {
        ModelAndView view = new ModelAndView("/youtube/lecture");

        if(session.getAttribute("appl_no") == null && session.getAttribute("instr_no") == null) {
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

        if(session.getAttribute("appl_no") == null && session.getAttribute("instr_no") == null) {
            view.setViewName("redirect:/login");
            return view;
        }

        lectureInfo.put("appl_no", session.getAttribute("appl_no"));
        List<Map<String, Object>> lectList = sqlSession.selectList("youtube.lectList", lectureInfo);

        for(Map<String, Object> lectInfo : lectList) {
            if( lectInfo.get("FILE_SN") != null ) {
                int FILE_LENGTH = String.valueOf(lectInfo.get("FILE_SN_SEQ")).split(",").length;
                String[] PHYS_FILE_NM, FILE_SN_SEQ, FILE_EXTN_NM, FILE_SZ;

                FILE_SN_SEQ = String.valueOf(lectInfo.get("FILE_SN_SEQ")).split(",");
                PHYS_FILE_NM = String.valueOf(lectInfo.get("PHYS_FILE_NM")).split(",");
                FILE_EXTN_NM = String.valueOf(lectInfo.get("FILE_EXTN_NM")).split(",");
                FILE_SZ = String.valueOf(lectInfo.get("FILE_SZ")).split(",");

                for(int i = 0; i < FILE_LENGTH; i++) {
                    lectInfo.put("PHYS_FILE_NM" + i, PHYS_FILE_NM[0]);
                    lectInfo.put("FILE_SN_SEQ" + i, FILE_SN_SEQ[0]);
                    lectInfo.put("FILE_EXTN_NM" + i, FILE_EXTN_NM[0]);
                    lectInfo.put("FILE_SZ" + i, FILE_SZ[0]);
                }

                lectInfo.remove("PHYS_FILE_NM");
                lectInfo.remove("FILE_SN_SEQ");
                lectInfo.remove("FILE_EXTN_NM");
                lectInfo.remove("FILE_SZ");
            }
        }


        System.out.println(lectList);

        view.addObject("sbjct_no", lectureInfo.get("sbjct_no"));
        view.addObject("lectList", lectList);

        return view;
    }

    @GetMapping("/lectureDetail")
    public ModelAndView lectureDetail(@RequestParam Map<String, Object> userInfo, HttpSession session) {
        ModelAndView view = new ModelAndView("youtube/lectureDetail");

        if(session.getAttribute("appl_no") == null && session.getAttribute("instr_no") == null) {
            view.setViewName("redirect:/login");
            return view;
        }

        userInfo.put("appl_no", session.getAttribute("appl_no"));
        Map<String, Object> lectureInfo = sqlSession.selectOne("youtube.lectDetail", userInfo);

        view.addObject("lectureInfo", lectureInfo);

        return view;
    }

    @PostMapping("/getPlayTime")
    @ResponseBody
    public Integer getPlayTime(@RequestParam Map<String, Object> userInfo, HttpSession session) {
        userInfo.put("appl_no", session.getAttribute("appl_no"));
        System.out.println("조회 : " + userInfo);
        return sqlSession.selectOne("youtube.getPlayTime", userInfo);
    }

    @PostMapping("/playTimeSave")
    @ResponseBody
    public String playTimeSave(@RequestParam Map<String, Object> userInfo, HttpSession session) {
        userInfo.put("appl_no", session.getAttribute("appl_no"));
        System.out.println("저장 : " + userInfo);
        int result = sqlSession.update("youtube.playTimeSave", userInfo);
        String msg = (result == 1) ? userInfo.get("curr_time") + "초 저장 완료" : "저장 실패";

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