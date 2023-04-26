package com.pandora.lms.controller;

import com.pandora.lms.service.NoticeService;
import com.pandora.lms.util.TextChangeUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@AllArgsConstructor
@Controller
public class IndexController {

    private final NoticeService noticeService;
    private final TextChangeUtil textChangeUtil;
  
    @GetMapping("/")
    public ModelAndView main(HttpSession session){
        if(session.getAttribute("user_no") == null){
            ModelAndView mv = new ModelAndView("/login/login");
            return mv;
        }else{
            ModelAndView mv = new ModelAndView("/index");
            int totalCount = noticeService.mainNoticCnt();
            List<Map<String, Object>> list = noticeService.mainNoticeList();
            for (Map<String, Object> m : list) {
                m.put("notice_title", textChangeUtil.changeText((String) m.get("notice_title")));
            }
            mv.addObject("list", list);
            mv.addObject("totalCount", totalCount);
            return mv;
        }

    }

    @GetMapping("/index")
    public ModelAndView index(HttpSession session) {
        if (session.getAttribute("user_no") == null) {
            ModelAndView mv = new ModelAndView("/login/login");
            return mv;
        } else {
            ModelAndView mv = new ModelAndView("/index");
            int totalCount = noticeService.mainNoticCnt();
            List<Map<String, Object>> list = noticeService.mainNoticeList();
            for (Map<String, Object> m : list) {
                m.put("notice_title", textChangeUtil.changeText((String) m.get("notice_title")));
            }
            mv.addObject("list", list);
            mv.addObject("totalCount", totalCount);
            return mv;
        }
    }

}
