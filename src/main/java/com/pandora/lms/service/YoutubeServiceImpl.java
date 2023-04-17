package com.pandora.lms.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.pandora.lms.dao.YoutubeDAO;

@Service
public class YoutubeServiceImpl implements YoutubeService {

	private YoutubeDAO youtubeDAO;
	
	//public List<Map<String, Object>> lectureInfo() {
	//	return youtubeDAO.lectureInfo();
	//}
}
