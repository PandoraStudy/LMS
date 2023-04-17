package com.pandora.lms.controller;

import com.pandora.lms.service.NoticeService;
import com.pandora.lms.util.TextChangeUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@AllArgsConstructor
@Controller
public class NoticeController {

    private final NoticeService noticeService;
    private final TextChangeUtil textChangeUtil;
    @GetMapping("/noticeIframe")
    public String noticeIframe(){ return "/notice/noticeIframe"; }
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
            for(Map<String, Object> m : list) { m.put("notice_title", textChangeUtil.changeText((String)m.get("notice_title"))); }
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
        mv.addObject("noticeDetail",noticeDetail);
        return mv;
    }
    @GetMapping("/noticeWrite")
    public String noticeWrite(HttpSession session) {
//        if(session.getAttribute("id") == null) {
//            return	"redirect:/notice";
//        }
        return "/notice/noticeWrite";
    }
    @PostMapping("/noticeWrite")
    public String noticeWrite(HttpServletRequest request, HttpSession session) {
        String notice_title = request.getParameter("writeTitle");
        notice_title = textChangeUtil.changeText(notice_title);
        String notice_content = request.getParameter("writeContent");
        notice_content = textChangeUtil.changeText(notice_content);
        String notice_no = request.getParameter("notice_no");
//        String admin_id = (String)session.getAttribute("id");
        if(notice_no==null) {
//			String member_no = request.getParameter("member_no");
            Map<String,Object> map = new HashMap<String, Object>();
            map.put("notice_title", notice_title);
            map.put("notice_content", notice_content);
//            map.put("admin_id", admin_id);
            noticeService.noticeWrite(map);
            return"redirect:/notice";
        }else {
            Map<String,Object> map = new HashMap<String, Object>();
            map.put("notice_title", notice_title);
            map.put("notice_content", notice_content);
            map.put("notice_no", notice_no);
            noticeService.noticeUpdate(map);
            return "redirect:/noticeDetail?notice_no="+notice_no;
        }
    }
    @GetMapping("/noticeUpdate")
    public ModelAndView noticeUpdate(@RequestParam String notice_no) {
        ModelAndView mv = new ModelAndView("/notice/noticeWrite");
        Map<String, Object> noticeDetail = noticeService.noticeDetail(notice_no);
        mv.addObject("noticeDetail",noticeDetail);
        return mv;
    }
    @GetMapping("/noticeDelete")
    public String noticeDelete(String notice_no) {
        int result = noticeService.noticeDelete(notice_no);
        System.out.println(result+" 개의 공지글이 비활성화 되었습니다.");
        return "redirect:/notice";
    }


}
