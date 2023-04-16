package com.pandora.lms.dto;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class AdminDTO {
//	int STUD_NO, AGE, TELNO, ZIP, USER_NO, CRCLM_CYCL;
//	String KORN_FLNM, GENDER_CD, EML_ADDR, REL_TELNO, REL_CD, ADDR, DADDR, CRCLM_CD, EDU_FNSH_YN;
//	byte[] PHOTO_FILE;
//	Date USER_BRDT;
	private int grade;
	private String procedure, admission, student_no, name, gender, department, day_and_night, division, academic_status;
	Date birth, date_of_admission;
}
