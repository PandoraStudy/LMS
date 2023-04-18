package com.pandora.lms.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pandora.lms.dto.AdminDTO;
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
	
	@GetMapping("/admin")
	public String admin() {
//		ModelAndView mv = new ModelAndView("admin");
//		List<AdminDTO> adminList = adminService.adminList();
//		mv.addObject("list", adminList);
//		System.out.println(adminList.toString());
		return "admin";
	}
	
	@ResponseBody
	@PostMapping("/search")
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
	@GetMapping("/mainContentTest")
	public String mainContentTest() {
	    return "mainContentTest";
	}
	@GetMapping("/mainContentTest2")
	public String mainContentTest2() {
		return "mainContentTest2";
	}
}
