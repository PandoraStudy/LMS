package com.pandora.lms.controller;

import lombok.AllArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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

		int num = sqlSession.selectOne("youtube.test");

		view.addObject("student_time", num);
		view.setViewName("youtube/youtubeDetail");

		return view;
	}

	@PostMapping("/getStudentTime")
	@ResponseBody
	public Integer getStudentTime() {
		int num = sqlSession.selectOne("youtube.test");
		return num;
	}

	@PostMapping("/studentTimeSave")
	@ResponseBody
	public String studentTimeSave(@RequestParam Map<String, Object> userData) {
		int result = sqlSession.update("youtube.studentTimeSave", userData);

		String msg = "저장 실패";
		if(result == 1) msg = "저장 완료";

		return msg;
	}

}