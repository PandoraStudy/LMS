package com.pandora.lms.controller;

import com.pandora.lms.service.NoticeService;
import com.pandora.lms.util.TextChangeUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@AllArgsConstructor
@Controller
public class NoticeController {

    private final NoticeService noticeService;
    private final TextChangeUtil textChangeUtil;


    @GetMapping("/notice")
        public ModelAndView noticeList(@RequestParam(value="pageNo", defaultValue = "1") int pageNo, HttpServletRequest request) {
            ModelAndView mv = new ModelAndView("/notice/notice");
            Map<String, Object> pages = new HashMap<String, Object>();
            String searchType = request.getParameter("searchType");
            String searchValue = request.getParameter("searchValue");
            pages.put("searchType", searchType);
            pages.put("searchValue", searchValue);
            int startPage = (pageNo*10)-10;
            int totalCount = noticeService.noticeCount(pages);
            int lastPage = (int)Math.ceil((double)totalCount/10);
            pages.put("startPage", startPage);
            pages.put("lastPage", lastPage);
            List<Map<String, Object>> list = noticeService.noticeList(pages);
            for(Map<String, Object> m : list) {
                m.put("notice_title", textChangeUtil.changeText((String)m.get("notice_title")));
            }
            mv.addObject("pages",pages);
            mv.addObject("list",list);
            mv.addObject("pageNo", pageNo);
            return mv;

    }
    @GetMapping("/noticeDetail")
    public ModelAndView noticeDetail(HttpServletRequest request, HttpSession session) {
        ModelAndView mv = new ModelAndView("/notice/noticeDetail");
        String notice_no = request.getParameter("notice_no");
        noticeService.noticeRead(notice_no);
        Map<String, Object> noticeDetail = noticeService.noticeDetail(notice_no);
        noticeDetail.put("notice_title", textChangeUtil.changeText((String)noticeDetail.get("notice_title")));
        noticeDetail.put("notice_content", textChangeUtil.changeText((String)noticeDetail.get("notice_content")));
//        List<Map<String,Object>> detailComments = noticeService.detailComment(notice_no);
//        for(Map<String, Object> m : detailComments) {
//            m.put("comment_content", textChangeUtil.changeText((String)m.get("comment_content")));
//        }

        mv.addObject("noticeDetail",noticeDetail);
//        mv.addObject("detailComments",detailComments);
        return mv;
    }
    @GetMapping("/noticeIframe")
    public String noticeIframe(){ return "/notice/noticeIframe"; }

}
