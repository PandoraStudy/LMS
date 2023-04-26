package com.pandora.lms.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pandora.lms.dto.AdminDTO;
import com.pandora.lms.dto.ApplInfoDTO;
import com.pandora.lms.dto.CrclmInfoDTO;
import com.pandora.lms.dto.OnLectNmDTO;
import com.pandora.lms.dto.SearchDTO;
import com.pandora.lms.service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	AdminDTO adminDTO;
	
	@Autowired
	SearchDTO searchDTO;
	
	@Autowired
	OnLectNmDTO onlectnmDTO;
	
	@GetMapping("/admin")
	public String admin() {
//		ModelAndView mv = new ModelAndView("admin");
//		List<AdminDTO> adminList = adminService.adminList();
//		mv.addObject("list", adminList);
//		System.out.println(adminList.toString());
		return "admin";
	}
	
	@GetMapping("/studentList")
	public String studentList() {
	    return "studentList";
	}
	
	@ResponseBody
	@PostMapping("/search/studentList")
	public List<AdminDTO> search(@RequestParam("name") String name
							, @RequestParam("academic_status") String academic_status
							, @RequestParam("department") String department
			) {
		SearchDTO search = new SearchDTO();
		
		search.setName(name);
		search.setAcademic_status(academic_status);
		search.setDepartment(department);
		
		List<AdminDTO> searchList = adminService.searchList(search);
		
		return searchList;
	}

	@ResponseBody
	@PostMapping("/search/onlect")
	public List<Map<String, Object>> onlect(@RequestParam Map<String,String> formData){
		System.out.println(formData.toString());
		//{year=2023, department_name=, ON_SBJECT_NM=컴퓨터, ON_LECT_NM=, ON_INSTR_NM=}
		List<Map<String, Object>> rsl = adminService.onlectList(formData);
		for (Map<String, Object> map : rsl) {
			System.out.println(map.toString());
		}
		return rsl;
	}
	
	@GetMapping("/insertYoutube")
	public String insertYoutube() {
		return "insertYoutube";
	}
	
	@ResponseBody
	@PostMapping("/insertYoutube/save")
	public List<OnLectNmDTO> insertYoutube(@RequestParam("ON_LECT_URL") String ON_LECT_URL
											, @RequestParam("file_upload") MultipartFile fileUpload){
		
		OnLectNmDTO onLect = new OnLectNmDTO();
		onLect.setON_LECT_URL(ON_LECT_URL);
//		onLect.set
		
		List<OnLectNmDTO> insertYoutube = adminService.insertYoutube(onLect);
		
		return insertYoutube;
	}
	
	@GetMapping("/attendance")
	public String attendance() {
		return "attendance";
	}
	
	@GetMapping("/opacity")
	public String opacity() {
		return "opacity";
	}
	
	@GetMapping("/departmentModal")
	public String departmentModal() {
		return "departmentModal";
	}
	
	@GetMapping("/studentsModal")
	public String studentsModal() {
		return "studentsModal";
	}
	
	@ResponseBody
	@PostMapping("/search/studentsModal")
	public List<ApplInfoDTO> studentsModal(@RequestParam("name") String name
			) {
		ApplInfoDTO appl = new ApplInfoDTO();
		
		appl.setKORN_FLNM(name);
		
		List<ApplInfoDTO> studentsModal = adminService.studentsModal(appl);
		
		System.out.println(studentsModal+"컨트롤러");
		return studentsModal;
	}
	
	@ResponseBody
	@PostMapping("/search/departmentModal")
	public List<CrclmInfoDTO> departmentModal(@RequestParam("department") String department
			) {
		CrclmInfoDTO crclm = new CrclmInfoDTO();
		System.out.println("ddddd");
		crclm.setCRCLM_NM(department);
		
		List<CrclmInfoDTO> departmentModal = adminService.departmentModal(crclm);
		
		for (CrclmInfoDTO crclmInfo : departmentModal) {
		    int crclmCd = crclmInfo.getCRCLM_CD();
		    int thirdDigit = (crclmCd / 1000) % 10;
System.out.println(crclmCd + "ddd");
		    if (thirdDigit == 0) {
		        crclmInfo.setDepartment("학부");
		    } else {
		        crclmInfo.setDepartment("학과");
		    }
		}
		return departmentModal;
	}
	
	
	
	
	
	
	
	@GetMapping("/mainContentTest2")
	public String mainContentTest2() {
		return "mainContentTest2";
	}
	
	@ResponseBody
	@PostMapping("/search2")
	public List<AdminDTO> search2(@RequestParam("name") String name
			, @RequestParam("academic_status") String academic_status
			, @RequestParam("department") String department
			) {
		SearchDTO search = new SearchDTO();
		
		search.setName(name);
		search.setAcademic_status(academic_status);
		search.setDepartment(department);
		
		List<AdminDTO> searchList = adminService.searchList(search);
		
		return searchList;
	}
}


