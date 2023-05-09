package com.pandora.lms.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.pandora.lms.service.NoticeService;
import com.pandora.lms.util.TextChangeUtil;
import com.pandora.lms.util.socket.IPGetter;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Controller
public class IndexController {

    private final NoticeService noticeService;
    private final TextChangeUtil textChangeUtil;
    private final IPGetter ipGetter;
  
    @GetMapping("/")
    public ModelAndView main(HttpSession session){
            ModelAndView mv = new ModelAndView("/index");
            int totalCount = noticeService.mainNoticCnt();
            List<Map<String, Object>> list = noticeService.mainNoticeList();
            for (Map<String, Object> m : list) {
                m.put("notice_title", textChangeUtil.changeText((String) m.get("notice_title")));
            }
            System.err.println(ipGetter.getIP());
            mv.addObject("list", list);
            mv.addObject("totalCount", totalCount);
            mv.addObject("myIp",ipGetter.getIP());            
            return mv;
   }

    @GetMapping("/index")
    public ModelAndView index(HttpSession session) {
        
            ModelAndView mv = new ModelAndView("/index");
            int totalCount = noticeService.mainNoticCnt();
            List<Map<String, Object>> list = noticeService.mainNoticeList();
            for (Map<String, Object> m : list) {
                m.put("notice_title", textChangeUtil.changeText((String) m.get("notice_title")));
            }
            System.err.println(ipGetter.getIP());
            mv.addObject("list", list);
            mv.addObject("totalCount", totalCount);
            mv.addObject("myIp",ipGetter.getIP());
            return mv;
    }

}
