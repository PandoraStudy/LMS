<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
//조회
$(document).ready( function() {
	$("#search_btn_inYou").click(
		function(e) {
			e.preventDefault();
			$.ajax({
				url : "/search/onlect",
				type : "POST",
				dataType : "json",
				data : $("#search_form_inYou").serialize(),
				success : function(data) {
					$('#tableBody_inYou').empty();
					$('#cnt_inYou').empty();
					var result = data;
					var str = "";
					$.each(result, function(i, info) {
						str += '<tr><td>' + info.sbjct_NO
								+ '</td><td>' + info.crclm_CYCL
								+ '</td><td>' + info.lect_YMD
								+ '</td><td>' + info.on_LECT_SN
								+ '</td><td>' + info.on_LECT_NM
								+ '</td><td>' + info.on_LECT_CN
								+ '</td><td>' + info.on_LECT_TM
								+ '</td><td style="display:none;"><input type="hidden" class="on_LECT_URL" value="' + info.on_LECT_URL + '"></td></tr>';
								});
					$('#tableBody_inYou').append(str);
					$('#cnt_inYou').append(result.length);
				}
			});
		});
	});

//저장
$(document).ready( function() {
	$("#insert_btn_inYou").click(
		function(e) {
			$.ajax({
				url : "/insertYoutube/save",
				type : "POST",
				dataType : "json",
				data : $("#insert_form_inYou").serialize(),
				success : function(data) {
					$('#tableBody_inYou').empty();
					$('#cnt_inYou').empty();
					var result = data;
					var str = "";
					$.each(result, function(i, info) {
						str += '<tr><td>' + info.sbjct_NO
								+ '</td><td>' + info.crclm_CYCL
								+ '</td><td>' + info.lect_YMD
								+ '</td><td>' + info.on_LECT_SN
								+ '</td><td>' + info.on_LECT_NM
								+ '</td><td>' + info.on_LECT_CN
								+ '</td><td>' + info.on_LECT_TM
								+ '</td><td style="display:none;"><input type="hidden" class="on_LECT_URL" value="' + info.on_LECT_URL + '"></td></tr>';
								});
					$('#tableBody_inYou').append(str);
					$('#cnt_inYou').append(result.length);
				}
			});
		});
	});



//행을 클릭했을 때
$(document).ready(function() {
	$("#inYou_table").on("click", "tbody tr", function() {
		alert("d");
		  // Get the on_LECT_URL from the clicked row
		  var on_LECT_URL = $(this).find(".on_LECT_URL").val();
		alert(on_LECT_URL);

		  // Set the extra data to the corresponding input element
		  $("#on_LECT_URL").val(on_LECT_URL);
		});
});
</script>
<script type="text/javascript">
var columnSortingStates = {};

function sortTable(n, table) {
	  var rows, switching, i, x, y, shouldSwitch;
	  switching = true;

	  // 새 열을 클릭하면 다른 모든 columnSortingStates를 정의되지 않음으로 재설정
	  for (var key in columnSortingStates) {
	    if (key != n) {
	      columnSortingStates[key] = undefined;
	    }
	  }
	
	  // 오름차순, 내림차순, 정렬x 순으로 정렬
	  if (columnSortingStates[n] === undefined) {
	    columnSortingStates[n] = "asc";
	  } else if (columnSortingStates[n] === "asc") {
	    columnSortingStates[n] = "desc";
	  } else if (columnSortingStates[n] === "desc") {
	    columnSortingStates[n] = "none";
	  } else if (columnSortingStates[n] === "none") {
	    columnSortingStates[n] = "asc";
	  }
	  dir = columnSortingStates[n];

	  // 모든 th 요소에서 기호를 제거하십시오.
	  var thElements = table.getElementsByTagName("th");
	  for (var j = 0; j < thElements.length; j++) {
	    thElements[j].innerHTML = thElements[j].innerHTML.replace("▲", "").replace("▼", "");
	  }

	  while (switching) {
	    switching = false;
	    rows = table.rows;
	    for (i = 1; i < (rows.length - 1); i++) {
	      shouldSwitch = false;
	      x = rows[i].getElementsByTagName("TD")[n];
	      y = rows[i + 1].getElementsByTagName("TD")[n];

	      if (dir === "asc") {
	        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
	          shouldSwitch = true;
	          break;
	        }
	      } else if (dir === "desc") {
	        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
	          shouldSwitch = true;
	          break;
	        }
	      } else if (dir === "none") {
	        break;
	      }
	    }
	    if (shouldSwitch) {
	      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
	      switching = true;
	    }
	  }

	  // 정렬된 요소에 기호를 추가합니다.
	  if (dir === "asc") {
	    thElements[n].innerHTML += " ▲";
	  } else if (dir === "desc") {
	    thElements[n].innerHTML += " ▼";
	  }
	}

</script>
<div id="main_container_load">
	<div class="main_container_title">
		<img class="title_img" alt="title" src="/img/icon/title.png">일반교과목관리
	</div>

	<form id="search_form_inYou">
		<div class="main_container_interspace">
			<input type="submit" value="조회" id="search_btn_inYou" class="search_btn">
			<input type="submit" value="저장" id="insert_btn_inYou" class="search_btn">
		</div>
		<div class="main_container_search">
			<div>과목명</div>
			<input name="ON_SBJECT_NM">
			<div>강의명</div>
			<input name="ON_LECT_NM">
		</div>
	</form>

	<div class="main_container_subtitle">
		<div class="blue_bar"></div>
		과목정보
	</div>
	<div style="font-size: 14px; color: gray; position: relative; float: left; top: 20px;">
		<span id="cnt_inYou"></span>건이 조회되었습니다.
	</div>
	<div class="main_content short">
		<table id="inYou_table" class="main_table">
			<thead>
				<tr>
					<th onclick="sortTable(0, inYou_table)">과목번호</th>
					<th onclick="sortTable(1, inYou_table)">교육회차</th>
					<th onclick="sortTable(2, inYou_table)">강의일자</th>
					<th onclick="sortTable(3, inYou_table)">온라인일련번호</th>
					<th onclick="sortTable(4, inYou_table)">온라인강의명</th>
					<th onclick="sortTable(5, inYou_table)">강의요약내용</th>
					<th onclick="sortTable(6, inYou_table)">학습시간</th>
				</tr>
			</thead>
			<tbody id="tableBody_inYou">
			</tbody>
		</table>
	</div>
	<div class="main_container_search" id="insert_btn_inYou">
		<input type="hidden" id="">	
		<div>강의URL</div>
		<input id="on_LECT_URL" name="ON_LECT_URL">
		<div>파일 첨부</div>
  	    <input type="file" id="file_upload" accept="video/*" style="height: 24px; position: relative; top: 7px;">
  	    <div>학년도</div>
		<input id="years" name="years">
		<div>학과코드</div>
		<input type="text" id="departmentCd" name="departmentCd">
		<div>편성학과</div>
		<input type="text" id="departmentName" name="departmentName">
		<div>편성학기</div>
		<input type="text" id="semesterName" name="semesterName">
		<div>교과구분</div>
		<input type="text" id="major" name="major">
		<div>과목코드</div>
		<input type="text" id="subjectCd" name="subjectCd">
		<div>과목명</div>
		<input type="text" id="subjectName" name="subjectName">
		<div>비고</div>
		<input type="text" id="note" name="note">
	</div>
</div>