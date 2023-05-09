package com.pandora.lms.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pandora.lms.dto.ApplCrclmWrapperDTO;
import com.pandora.lms.dto.ApplInfoDTO;
import com.pandora.lms.dto.CrclmInfoDTO;
import com.pandora.lms.dto.InstrInfoDTO;
import com.pandora.lms.dto.OnLectNmDTO;
import com.pandora.lms.dto.SearchDTO;
import com.pandora.lms.dto.UserApplViewDTO;
import com.pandora.lms.service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	UserApplViewDTO adminDTO;
	
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
	public List<ApplCrclmWrapperDTO> studentList(@RequestParam("name") String name
							, @RequestParam("academic_status") String academic_status
							, @RequestParam("department") String CRCLM_NM
			) {
		
		System.out.println(name + ":" +academic_status + ":" + CRCLM_NM + "dd");
		ApplCrclmWrapperDTO applCrc = new ApplCrclmWrapperDTO();
		
//		ApplInfoDTO appl = new ApplInfoDTO();
//		
//		CrclmInfoDTO crc = new CrclmInfoDTO();
		applCrc.setCRCLM_NM(CRCLM_NM);
		int crcCD;
		if (CRCLM_NM != "") {
			crcCD = adminService.crcList(applCrc);
			System.out.println(crcCD +"dddd");
			applCrc.setCRCLM_CD(crcCD);
		}
		applCrc.setKORN_FLNM(name);
		applCrc.setACADEMIC_STATUS(academic_status);
		applCrc.setCRCLM_NM(CRCLM_NM);
		
		
		List<ApplCrclmWrapperDTO> studentList = adminService.applList(applCrc);
		System.out.println(studentList + "adad");
		
		for (ApplCrclmWrapperDTO applCrcInfo : studentList) {
			System.out.println(applCrcInfo.getGENDER_CD() + "yy");
			int gender = applCrcInfo.getGENDER_CD();
			if (gender == 1) {
				applCrcInfo.setGENDER("남자");
			}else {
				applCrcInfo.setGENDER("여자");
			}
		}
		
		return studentList;
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
		    if (thirdDigit == 0) {
		        crclmInfo.setDepartment("학부");
		    } else {
		        crclmInfo.setDepartment("학과");
		    }
		}
		return departmentModal;
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
		
		for (ApplInfoDTO applInfo : studentsModal) {
			int gender = applInfo.getGENDER_CD();
			if (gender == 1) {
				applInfo.setGENDER("남자");
			}else {
				applInfo.setGENDER("여자");
			}
		}
		return studentsModal;
	}
	
	@GetMapping("/instructorModal")
	public String instructorModal() {
		return "instructorModal";
	}
	
	@ResponseBody
	@PostMapping("/search/instructorModal")
	public List<InstrInfoDTO> instructorModal(@RequestParam("name") String name){
		
		InstrInfoDTO instr = new InstrInfoDTO();
		
		instr.setKORN_FLNM(name);
		
		List<InstrInfoDTO> instructorModal = adminService.instructorModal(instr);
		
		for (InstrInfoDTO instrInfo : instructorModal) {
			int gender = instrInfo.getGENDER_CD();
			if (gender == 10) {
				instrInfo.setGENDER("남자");
			}else {
				instrInfo.setGENDER("여자");
			}
		}
		System.out.println(instructorModal + "ㅇㅇ");
		return instructorModal;
	}
}


