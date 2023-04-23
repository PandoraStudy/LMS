<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready( function() {
	$("#search_btn").click(
		function(e) {
			e.preventDefault();
			$.ajax({
				url : "/search",
				type : "POST",
				dataType : "json",
				data : $("#search_form").serialize(),
				success : function(data) {
					$('#tableBody').empty();
					$('#cnt_list').empty();
					var result = data;
					var str = "";
					$.each(result, function(i, info) {
						str += '<tr><td>' + info.procedure
								+ '</td><td>' + info.admission
								+ '</td><td>' + info.student_no
								+ '</td><td>' + info.name
								+ '</td><td>' + info.birth
								+ '</td><td>' + info.gender
								+ '</td><td>' + info.department
								+ '</td><td>' + info.day_and_night
								+ '</td><td>' + info.grade
								+ '</td><td>' + info.division
								+ '</td><td>' + info.academic_status
								+ '</td><td>' + info.date_of_admission
								+ '</td></tr>';
					});
					$('#tableBody').append(str);
					$('#cnt_list').append(result.length);
				}
			});
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
<script type="text/javascript">
function modalSearch() {
    var modal = document.getElementById("modal_opacity");
    if (modal.style.display === "none" || modal.style.display === "") {
        modal.style.display = "block";
        $("#modal_opacity").load("/studentListModal");
    } else {
        modal.style.display = "none";
    }
}
</script>
<div id="main_container_load">
	<div class="main_container_title">
		<img class="title_img" alt="title" src="/img/icon/title.png">학생명부조회
	</div>

	<form id="search_form">
		<div class="main_container_interspace">
			<input type="button" value="조회" id="search_btn" class="search_btn">
		</div>
		<div class="main_container_search">
			<div>학번(이름)</div>
			<input name="name">
			<div>학적상태</div>
			<select name="academic_status">
				<option value="">(전체)</option>
				<option value="재학" selected>재학</option>
				<option value="휴학">휴학</option>
				<option value="제적">제적</option>
				<option value="수료">수료</option>
				<option value="졸업">졸업</option>
				<option value="유보">유보</option>
			</select>
			<div>소속학과</div>
			<span class="div_input">
			<input class="div_input_left" disabled value="">
			<input class="div_input_right" name="department">
			<img alt="magnifyingBtn" src="/img/icon/magnifyingBtn.png" class="magnifyingBtn" onclick="modalSearch()">
			</span>
		</div>
	</form>

	<div class="main_container_subtitle">
		<div class="blue_bar"></div>
		학생 정보
	</div>
	<div style="font-size: 14px; color: gray; position: relative; float: left; top: 20px;">
		<span id="cnt_list"></span>건이 조회되었습니다.
	</div>
	<div class="main_content">
		<table id="main_table" class="main_table">
			<thead>
				<tr>
					<th onclick="sortTable(0, main_table)">과정</th>
					<th onclick="sortTable(1, main_table)">입학</th>
					<th onclick="sortTable(2, main_table)">학번</th>
					<th onclick="sortTable(3, main_table)">이름</th>
					<th onclick="sortTable(4, main_table)">생년월일</th>
					<th onclick="sortTable(5, main_table)">성별</th>
					<th onclick="sortTable(6, main_table)">소속학과</th>
					<th onclick="sortTable(7, main_table)">주야</th>
					<th onclick="sortTable(8, main_table)">학년</th>
					<th onclick="sortTable(9, main_table)">분반</th>
					<th onclick="sortTable(10, main_table)">학적상태</th>
					<th onclick="sortTable(11, main_table)">입학일자</th>
				</tr>
			</thead>
			<tbody id="tableBody">
			
			</tbody>
		</table>
	</div>
</div>