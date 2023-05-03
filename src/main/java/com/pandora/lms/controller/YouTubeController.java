package com.pandora.lms.controller;


import com.google.api.client.auth.oauth2.Credential;
import com.pandora.lms.service.YoutubeService;
import com.pandora.lms.ytbUtil.OAuth;
import lombok.AllArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.json.JSONException;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.*;

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

        List<Map<String, Object>> lecture = null;

        if(session.getAttribute("appl_no") != null) {
            userInfo.put("appl_no", session.getAttribute("appl_no"));
            lecture = sqlSession.selectList("youtube.lecture", userInfo);

            for(Map<String, Object> data : lecture) {
                Float TOTAL_LECT_CNT = Float.parseFloat(String.valueOf(data.get("TOTAL_LECT_CNT")));
                Float APPL_ATND_CNT = Float.parseFloat(String.valueOf(data.get("APPL_ATND_CNT")));

                data.replace("TOTAL_LECT_CNT", TOTAL_LECT_CNT);
                data.replace("APPL_ATND_CNT", APPL_ATND_CNT);

                if(APPL_ATND_CNT != 0) {
                    Integer LECT_MAG = (int) ((APPL_ATND_CNT / TOTAL_LECT_CNT) * 100);
                    data.put("LECT_MAG", LECT_MAG);
                } else {
                    data.put("LECT_MAG", 0);
                }
            }
        } else if(session.getAttribute("instr_no") != null) {
            userInfo.put("instr_no", session.getAttribute("instr_no"));
            lecture = sqlSession.selectList("youtube.lecture", userInfo);
        }


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

                List<String> PHYS_FILE_NM_LS = new ArrayList<>();
                List<String> FILE_SN_SEQ_LS = new ArrayList<>();
                List<String> FILE_EXTN_NM_LS = new ArrayList<>();
                List<String> FILE_SZ_LS  = new ArrayList<>();

                lectInfo.put("FILE_LENGTH", FILE_LENGTH);
                for(int i = 0; i < FILE_LENGTH; i++) {
                    PHYS_FILE_NM_LS.add(PHYS_FILE_NM[i]);
                    FILE_SN_SEQ_LS.add(FILE_SN_SEQ[i]);
                    FILE_EXTN_NM_LS.add(FILE_EXTN_NM[i]);
                    FILE_SZ_LS.add(FILE_SZ[i]);
                }
                lectInfo.put("PHYS_FILE_NM_LS", PHYS_FILE_NM_LS);
                lectInfo.put("FILE_SN_SEQ_LS", FILE_SN_SEQ_LS);
                lectInfo.put("FILE_EXTN_NM_LS", FILE_EXTN_NM_LS);
                lectInfo.put("FILE_SZ_LS", FILE_SZ_LS);

                lectInfo.remove("PHYS_FILE_NM");
                lectInfo.remove("FILE_SN_SEQ");
                lectInfo.remove("FILE_EXTN_NM");
                lectInfo.remove("FILE_SZ");
            }
        }

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

        if(session.getAttribute("appl_no") != null) {
            int seconds = (Integer) lectureInfo.get("LAST_PLAY_TM");
            int minutes = seconds / 60;
            int remainingSeconds = seconds % 60;
            String LAST_PLAY_TM2 = minutes + "분 " + remainingSeconds + "초";

            lectureInfo.replace("LECT_PRGRS_RT", Math.ceil((Float) lectureInfo.get("LECT_PRGRS_RT")) );
            lectureInfo.put("LAST_PLAY_TM2", LAST_PLAY_TM2);
        }

        view.addObject("lectureInfo", lectureInfo);

        return view;
    }

    @PostMapping("/getPlayTime")
    @ResponseBody
    public Integer getPlayTime(@RequestParam Map<String, Object> userInfo, HttpSession session) {
        userInfo.put("appl_no", session.getAttribute("appl_no"));
        return sqlSession.selectOne("youtube.getPlayTime", userInfo);
    }

    @PostMapping("/playTimeSave")
    @ResponseBody
    public String playTimeSave(@RequestParam Map<String, Object> userInfo, HttpSession session) {
        userInfo.put("appl_no", session.getAttribute("appl_no"));

        // 종료 교시 코드 가져오기
        Map<String, Integer> clsCd = sqlSession.selectOne("youtube.getClsCd", userInfo);

        Integer today = Integer.parseInt(String.valueOf(userInfo.get("today")));
        Integer BGNG_CLS_CD = clsCd.get("BGNG_CLS_CD");
        Integer END_CLS_CD = clsCd.get("END_CLS_CD");

        // (1 <= 2) && (2 >= 2)
        if( (BGNG_CLS_CD <= today) && (END_CLS_CD >= today) ) {

        }

        int playTime = sqlSession.selectOne("youtube.getPlayTime", userInfo);
        int saveTime = Integer.parseInt(String.valueOf(userInfo.get("curr_time")));

        String msg;

        if ( (saveTime - playTime) > 5 ) {
            msg = "fail";
        } else {
            int result = sqlSession.update("youtube.playTimeSave", userInfo);
            msg = (result == 1) ? "success" : "fail";
        }
        return msg;
    }

    @PostMapping("/applATNDInsert")
    @ResponseBody
    public String applATNDInsert(@RequestParam Map<String, Object> userInfo, HttpSession session) {
        if(session.getAttribute("appl_no") == null && session.getAttribute("instr_no") == null) {
            return "fail";
        }
        userInfo.put("appl_no", session.getAttribute("appl_no"));

        Map<String, Object> lectInfo = sqlSession.selectOne("youtube.getLectInfo", userInfo);
        int result = sqlSession.insert("youtube.applATNDInsert", lectInfo);

        return "success";
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

    @PostMapping("/modalUpload")
    @ResponseBody
    public String modalUpload(@RequestParam Map<String, Object> modalInfo, @RequestPart(name = "file", required = false) MultipartFile file) {
        String uploadSelect = (String) modalInfo.get("upload-select");
        String result = null;

        if(uploadSelect.equals("assign")) {
            System.out.println("과제 등록");
            result = "success";
        } else if(uploadSelect.equals("file")) {
            if(file.getSize() == 0) {
                result = "empty_file";
            } else {
                Map<String, Object> fileInfo = new HashMap<>();
                fileInfo.put("FILE_SN", modalInfo.get("on_lect_sn"));
                Integer FILE_SN_SEQ = (Integer) sqlSession.selectOne("youtube.getFileSnSeq", modalInfo);
                if(FILE_SN_SEQ != null) fileInfo.put("FILE_SN_SEQ",  FILE_SN_SEQ + 1);
                else fileInfo.put("FILE_SN_SEQ",  1);
                fileInfo.put("PHYS_FILE_NM", modalInfo.get("title"));
                fileInfo.put("ORGNL_FILE_NM", FilenameUtils.getBaseName(file.getOriginalFilename()));
                fileInfo.put("FILE_PATH_NM", null);
                fileInfo.put("FILE_EXTN_NM", FilenameUtils.getExtension(file.getOriginalFilename()));
                fileInfo.put("FILE_SZ", file.getSize());

                System.out.println(fileInfo);
                int file_result = sqlSession.insert("youtube.insertFileInfo", fileInfo);

                if(file_result == 1) result = "success";
                else result = "error";
            }
        }

        return result;
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