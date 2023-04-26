package com.pandora.lms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pandora.lms.dao.AdminDAO;
import com.pandora.lms.dto.AdminDTO;
import com.pandora.lms.dto.ApplInfoDTO;
import com.pandora.lms.dto.OnLectNmDTO;
import com.pandora.lms.dto.SearchDTO;

@Service
public class AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	public List<AdminDTO> searchList(SearchDTO search) {
		return adminDAO.searchList(search);
	}

	public List<Map<String, Object>> onlectList(Map<String, String> formData) {
		return adminDAO.onlectList(formData);
	}

	public List<OnLectNmDTO> insertYoutube(OnLectNmDTO onLect) {
		return adminDAO.insertYoutube(onLect);
	}

	public List<ApplInfoDTO> studentsModal(ApplInfoDTO appl) {
		return adminDAO.studentsModal(appl);
	}
}
