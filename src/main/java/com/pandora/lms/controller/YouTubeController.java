package com.pandora.lms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class YouTubeController {
	
	@GetMapping("/youtube")
	public String YouTube() {
		
		return "youtube/youtube";
	}
	
}