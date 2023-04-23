<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<style>
.narrow{
width: 940px;
float: left;
margin-right: 10px;
}
.narrow2{
width: 225px;
float: left;
}
</style>
<div id="main_container_load">
	<div class="main_container_title">
		<img class="title_img" alt="title" src="/img/icon/title.png">출석부조회(학생용)
	</div>

	<form id="attendance_form">
		<div class="main_container_interspace">
			<input type="button" value="조회" id="attendance_btn" class="search_btn">
		</div>
		<div class="main_container_search">
			<div>학년도</div>
			<span class="div_input">
			<input class="div_input_left" name="grade">
			<select class="div_select_right" name="">
				<option value="1학기" selected>1학기</option>
				<option value="2학기">2학기</option>
			</select>
			</span>
			<div>학번/성명</div>
			<span class="div_input">
			<input class="div_input_left" disabled value="">
			<input class="div_input_right" name="department">
			<img alt="magnifyingBtn" src="/img/icon/magnifyingBtn.png" class="magnifyingBtn">
			</span>
			<div>소속학과</div>
			<input disabled="disabled" value="">
		</div>
	</form>
	<div class="main_container_subtitle">
		<div class="blue_bar"></div>
		학생 정보
	</div>
	<div style="font-size: 14px; color: gray; position: relative; float: left; top: 20px; margin-right: 735px;">
		<span id="cnt_attendance"></span>건이 조회되었습니다.
	</div>
	<div class="main_container_subtitle">
		<div class="blue_bar"></div>
		학생 정보
	</div>
	<div style="font-size: 14px; color: gray; position: relative; float: left; top: 20px;">
		<span id="cnt_attendance"></span>건
	</div>
	<div class="main_content narrow">
		<table id="main_table_attendance" class="main_table">
			<thead>
				<tr>
					<th onclick="sortTable(0, main_table_attendance)">개설학과</th>
					<th onclick="sortTable(1, main_table_attendance)">주야</th>
					<th onclick="sortTable(2, main_table_attendance)">학년</th>
					<th onclick="sortTable(3, main_table_attendance)">과목코드</th>
					<th onclick="sortTable(4, main_table_attendance)">개설과목</th>
					<th onclick="sortTable(5, main_table_attendance)">분반</th>
					<th onclick="sortTable(6, main_table_attendance)">이수구분</th>
					<th onclick="sortTable(7, main_table_attendance)">학점</th>
					<th onclick="sortTable(8, main_table_attendance)">담당교수</th>
					<th onclick="sortTable(9, main_table_attendance)">출석</th>
					<th onclick="sortTable(10, main_table_attendance)">지각</th>
				</tr>
			</thead>
			<tbody id="tableBody_attendance">
			</tbody>
		</table>
	</div>
	<div class="main_content narrow2">
		<table id="main_table_attendance2" class="main_table">
			<thead>
				<tr>
					<th onclick="sortTable(0, main_table_attendance2)">개설학과</th>
					<th onclick="sortTable(1, main_table_attendance2)">주야</th>
					<th onclick="sortTable(2, main_table_attendance2)">학년</th>
				</tr>
			</thead>
			<tbody id="tableBody_attendance2">
			</tbody>
		</table>
	</div>
</div>