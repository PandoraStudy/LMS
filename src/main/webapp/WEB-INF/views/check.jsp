<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<title>과목 화면</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
function search() {
  const year = document.getElementById("year").value;
  const semester = document.getElementById("semester").value;
  const studentNum = document.getElementById("student_num").value;
  const departmentName = document.getElementById("department_name").value;

  console.log(studentNum);
  console.log(departmentName);
  
  
  if(studentNum == ""){
	  alert("학번을 입력해주세요");
	  return;
  }
  
  const data = {
    year: year,
    semester: semester,
    studentNum: studentNum,
    departmentName : departmentName
  };

  const xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (xhr.readyState === XMLHttpRequest.DONE) {
      if (xhr.status === 200) {
        const result = document.getElementById("result").getElementsByTagName("tbody")[0];
        const response = JSON.parse(xhr.responseText);
        // 기존 테이블 내용 삭제
        result.innerHTML = "";
        
        console.log(response.data);

        // 데이터 출력
        for (let i = 0; i < response.data.length; i++) {
          const row = result.insertRow(-1);
          const CRCLM_NMCell = row.insertCell(0);//개설학과
          const SBJCT_NOCell = row.insertCell(1);//과목코드
          const SBJCT_NMCell = row.insertCell(2);//개설과목
          const CRCLM_CYCLCell1 = row.insertCell(3);//수강년도
          const CRCLM_CYCLCell2 = row.insertCell(4);//학기
          const ESNTL_YNCell = row.insertCell(5);//이수구분
          const KORN_FLNMCell = row.insertCell(6);//담당교수
          const ATNDDY_CNTCell = row.insertCell(7);//출석
          const ABSTDY_CNTCell = row.insertCell(8);//결석
          const LATE_CNTCell = row.insertCell(9);//지각
          
          const CRCLM_CYCL = response.data[i].CRCLM_CYCL.toString();
          
          CRCLM_CYCLCell1.innerHTML = CRCLM_CYCL.substr(0,4)+"년도";

          if(CRCLM_CYCL.substr(5) !== '1' && CRCLM_CYCL.substr(5) !== '2'){
        	  if(CRCLM_CYCL.substr(5) == '3'){
        		  CRCLM_CYCLCell2.innerHTML = "하계 계절학기";
        	  }else{
        		  CRCLM_CYCLCell2.innerHTML = "동계 계절학기";
        	  }
          }else{
        	  CRCLM_CYCLCell2.innerHTML = CRCLM_CYCL.substr(5)+"학기";        	  
          }
          CRCLM_NMCell.innerHTML = response.data[i].CRCLM_NM;
          SBJCT_NOCell.innerHTML = response.data[i].SBJCT_NO;
          SBJCT_NMCell.innerHTML = response.data[i].SBJCT_NM;
          ESNTL_YNCell.innerHTML = response.data[i].ESNTL_YN;
          KORN_FLNMCell.innerHTML = response.data[i].KORN_FLNM;
          ATNDDY_CNTCell.innerHTML = response.data[i].ATNDDY_CNT;
          ABSTDY_CNTCell.innerHTML = response.data[i].ABSTDY_CNT;
          LATE_CNTCell.innerHTML = response.data[i].LATE_CNT;
          
          // 이벤트 리스너 추가
          row.addEventListener('click', function() {
            const rowData = {
              year: categoryCell1.innerHTML.substr(0,4),
              semester: categoryCell2.innerHTML,
              subjectName: subjectNameCell.innerHTML,
              departmentName: departmentNameCell.innerHTML
            };
            sendAjax(rowData);
          });
       //여기까지
          
        }
      } else {
        console.error('Error:', xhr.statusText);
      }
    }
  };

  xhr.open('POST', '/studentCheck');
  xhr.setRequestHeader('Content-Type', 'application/json');
  xhr.send(JSON.stringify(data));
}


</script>
</head>
<style>
.second_area{
	width: 1000px;
	height: 200px;
	overflow-y: scroll;
}

#result thead {
  position: sticky;
  top: 0;
  z-index: 1;
  background-color: #fff;
}

.top_text{
	width: 90px;
	height: 25px;
}

select{
	height: 25px;
}

th{
	width:105px;
	text-align: center;
}

td{
	text-align: center;
}
</style>
<!DOCTYPE html>

<body>
    <h1>과목화면</h1>

학년도 <input type="text" class="top_text" id="year" name="year" value="2023">
		 <select id="semester">
		 	<option value="0">전체</option>
		 	<option value="01">1학기</option>
		 	<option value="02">2학기</option>
		 	<option value="03">하계 계절학기</option>
		 	<option value="04">동계 계절학기</option>
		 </select>&nbsp&nbsp&nbsp
성명/학번 :  <input type="text" id="student_name" name="student_name" disabled="disabled">
			<input type="text" id="student_num" name="student_num">&nbsp&nbsp&nbsp
소속학과 : <input type="text" class="top_text" id="department_name" name="department_name">&nbsp&nbsp&nbsp
<button class="btn btn-outline-info btn-sm" onclick="search()">조회</button>
<br><br><br>
==========================================================================================
<div class="second_area">
<table id="result">
  	<thead>
    	<tr>
			<th>개설학과</th>
			<th>과목코드</th>
			<th>개설과목</th>
			<th>수강년도</th>
			<th>학기</th>
			<th>이수구분</th>
			<th>담당교수</th>
			<th>출석</th>
			<th>결석</th>
			<th>지각</th>
    	</tr>
  	</thead>
  	<tbody></tbody>	
</table>
</div>
===========================================================================================


</body>
</html>