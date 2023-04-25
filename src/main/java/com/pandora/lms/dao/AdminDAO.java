package com.pandora.lms.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.pandora.lms.dto.AdminDTO;
import com.pandora.lms.dto.ApplInfoDTO;
import com.pandora.lms.dto.OnLectNmDTO;
import com.pandora.lms.dto.SearchDTO;

@Repository
@Mapper
public interface AdminDAO {
	
	public List<AdminDTO> searchList(SearchDTO search);

	public List<Map<String, Object>> onlectList(OnLectNmDTO onLect);

	public List<OnLectNmDTO> insertYoutube(OnLectNmDTO onLect);

	public List<ApplInfoDTO> studentsModal(ApplInfoDTO appl);

}
