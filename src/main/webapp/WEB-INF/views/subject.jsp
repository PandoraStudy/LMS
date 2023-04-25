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
  const subjectName = document.getElementById("subject_name").value;
  const departmentName = document.getElementById("department_name").value;
  
  const data = {
    year: year,
    semester: semester,
    subjectName: subjectName,
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

        // 데이터 출력
        for (let i = 0; i < response.data.length; i++) {
          const row = result.insertRow(-1);
          const categoryCell1 = row.insertCell(0);
          const categoryCell2 = row.insertCell(1);
          const subjectNameCell = row.insertCell(2);
          const departmentNameCell = row.insertCell(3);
          const esntlYn = row.insertCell(4);
          const CRCLM_CYCL = response.data[i].CRCLM_CYCL.toString();
          categoryCell1.innerHTML = CRCLM_CYCL.substr(0,4)+"년도";

          if(CRCLM_CYCL.substr(5) !== '1' && CRCLM_CYCL.substr(5) !== '2'){
        	  if(CRCLM_CYCL.substr(5) == '3'){
        		categoryCell2.innerHTML = "하계 계절학기";
        	  }else{
        		categoryCell2.innerHTML = "동계 계절학기";
        	  }
          }else{
          		categoryCell2.innerHTML = CRCLM_CYCL.substr(5)+"학기";        	  
          }
          subjectNameCell.innerHTML = response.data[i].SBJCT_NM;
          departmentNameCell.innerHTML = response.data[i].CRCLM_NM;
          esntlYn.innerHTML = response.data[i].ESNTL_YN;
          
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

  xhr.open('POST', '/subjectFilter');
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
<html>
<body>
</body>
</html>
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
교과목명 : <input type="text" class="top_text" id="subject_name" name="subject_name">&nbsp&nbsp&nbsp
편성학과 : <input type="text" class="top_text" id="department_name" name="department_name">&nbsp&nbsp&nbsp
<button class="btn btn-outline-info btn-sm" onclick="search()">조회</button>
<br><br><br>
<h1>교육과정정보</h1>
==========================================================================================
<div class="second_area">
<table id="result">
  	<thead>
    	<tr>
			<th>교육년도</th>
			<th>학기</th>
			<th>교과목명</th>
			<th>편성학과</th>
			<th>교과구분</th>
    	</tr>
  	</thead>
  	<tbody></tbody>	
</table>
</div>
===========================================================================================
<h1>과목정보</h1>&nbsp&nbsp&nbsp
<form id="form">
<button type="button" class="btn btn-success" style="float:right" id="submit">수정</button>
학년도(2023)<input type="text" id="years" name="years"><br>
학과코드(30101111)<input type="text" id="departmentCd" name="departmentCd"><br> 
편성학과(경영학)<input type="text" id="departmentName" name="departmentName"><br>
편성학기(1학기)<input type="text" id="semesterName" name="semesterName"><br>
교과구분(전공)<input type="text" id="major" name="major"><br> 
과목코드<input type="text" id="subjectCd" name="subjectCd"><br>
과목명<input type="text" id="subjectName" name="subjectName"><br> 
비고(빈칸)<input type="text" id="note" name="note"><br>
</form>

   
</body>
<script>
function sendAjax(rowData) {
	  const xhr = new XMLHttpRequest();
	  
	  xhr.onreadystatechange = function() {
	    if (xhr.readyState === XMLHttpRequest.DONE) {
	      if (xhr.status === 200) {
	        //console.log(xhr.responseText);
	    	  const response = JSON.parse(xhr.responseText);
	          console.log(response);
	          
	          // 응답 데이터를 input 요소에 추가
	          const data = response.data[0];
	          //날짜
	          const yearsInput = document.getElementById("years");
	          const CRCLM_CYCL = data.CRCLM_CYCL.toString();
	          yearsInput.value = CRCLM_CYCL.substr(0,4);
	          
	          //학기 가공
	          if(CRCLM_CYCL.substr(5) != '1' && CRCLM_CYCL.substr(5) != '2'){
	        	  if(CRCLM_CYCL.substr(5) == '3'){
	          		const semesterNameInput = document.getElementById("semesterName");
	          		semesterNameInput.value = "하계 계절학기";
	          	  }else{
	          		const semesterNameInput = document.getElementById("semesterName");
	          		semesterNameInput.value = "동계 계절학기";
	          	  }
	          }else{
	        	  	const semesterNameInput = document.getElementById("semesterName");
	          		semesterNameInput.value = CRCLM_CYCL.substr(5)+"학기";
	          }
	          //학과명
	          const subjectNameInput = document.getElementById("subjectName");
	          subjectNameInput.value = data.SBJCT_NM;
	          //학과코드
	          const departmentCdInput = document.getElementById("departmentCd");
	          departmentCdInput.value = data.CRCLM_CD;
	          //편성학과
	          const departmentNameInput = document.getElementById("departmentName");
	          departmentNameInput.value = data.CRCLM_NM;
	          //과목코드
	          const subjectCdInput = document.getElementById("subjectCd");
	          subjectCdInput.value = data.SBJCT_NO;
	          //전공구분
	          const majorInput = document.getElementById("major");
 	          majorInput.value = data.ESNTL_YN;
	          
	      } else {
	        console.error('Error:', xhr.statusText);
	      }
	    }
	  };
	  
	  xhr.open('POST', '/detailSubject');
	  xhr.setRequestHeader('Content-Type', 'application/json');
	  xhr.send(JSON.stringify(rowData));
	}
	//데이터 수정
	 $(function(){
        $('#submit').on("click",function () {
            var form1 = $("#form").serialize();

            console.log(form1);
            var change = confirm("수정하시겠습니까?");
            
            $.ajax({
                type: "post",
                url: "submitUpdate",
                data: form1,
                dataType: 'json',
                success: function (data) {
                    alert("success");
                    console.log(data);
                },
                error: function (request, status, error) {
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

                }
            });
        });
    });
    
	
	
</script>
</html>
