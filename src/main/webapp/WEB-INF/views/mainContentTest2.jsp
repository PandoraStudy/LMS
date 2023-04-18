<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
$(document).ready( function() {
	$("#search_btn2").click(
		function(e) {
			e.preventDefault();
			$.ajax({
				url : "/search2",
				type : "POST",
				dataType : "json",
				data : $("#search-form2").serialize(),
				success : function(data) {
					$('#tableBody2').empty();
					$('#cnt2').empty();
					var result2 = data;
					var str2 = "";
					$.each(result2, function(i, info) {
						str2 += '<tr><td>' + info.procedure
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
					$('#tableBody2').append(str2);
					$('#cnt2').append(result2.length);
				}
			});
		});
	});
</script>
<script type="text/javascript">
var currentColumn = -1;
var currentDirection = '';

function sortTable(n) {
    var table, rows, switching, i, x, y, shouldSwitch, dir, switchCount = 0;
    table = document.getElementById("main_table");
    switching = true;
    dir = "asc";

    // 이전에 선택한 열이 있는 경우, ▲와 ▼ 기호를 제거합니다.
    if (currentColumn !== -1) {
        var header = table.getElementsByTagName("TH")[currentColumn];
        header.innerHTML = header.innerHTML.replace(/(▲|▼)$/, '');
    }

    // 같은 열을 다시 클릭한 경우 방향을 바꿉니다. 그렇지 않으면 기본 방향을 사용합니다.
    if (currentColumn === n) {
        dir = currentDirection === 'asc' ? 'desc' : 'asc';
    } else {
        dir = 'asc';
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
            }
        }
        if (shouldSwitch) {
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
            switching = true;
            switchCount++;
        } else {
            if (switchCount === 0 && dir === "asc") {
                dir = "desc";
                switching = true;
            }
        }
    }

    // 현재 열 및 방향을 저장하고, 해당하는 ▲ 또는 ▼ 기호를 추가합니다.
    currentColumn = n;
    currentDirection = dir;
    var header = table.getElementsByTagName("TH")[n];
    header.innerHTML += dir === 'asc' ? '▲' : '▼';
}
</script>
<div id="main_container_load">
	<div class="main_container_title">
		<img class="title_img" alt="title" src="/img/icon/title.png">학생명부조회2{side_submenu_sub}
	</div>

	<form id="search-form2">
		<div class="main_container_interspace">
			<input type="button" value="조회" id="search_btn2" class="search_btn">
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
			<span class="div_input"> <input class="div_input_left"
				disabled value=""><input class="div_input_right"
				name="department"> <img alt="magnifyingBtn"
				src="/img/icon/magnifyingBtn.png" class="magnifyingBtn">
			</span>
		</div>
	</form>

	<div class="main_container_subtitle">
		<div class="blue_bar"></div>
		학생정보
	</div>
	<div
		style="font-size: 14px; color: gray; position: relative; float: left; top: 20px;">
		<span id="cnt2"></span>건이 조회되었습니다.
	</div>
	<div class="main_content">
		<table id="main_table" class="main_table">
			<thead>
				<tr>
					<th onclick="sortTable(0)">과정</th>
					<th onclick="sortTable(1)">입학</th>
					<th onclick="sortTable(2)">학번</th>
					<th onclick="sortTable(3)">이름</th>
					<th onclick="sortTable(4)">생년월일</th>
					<th onclick="sortTable(5)">성별</th>
					<th onclick="sortTable(6)">소속학과</th>
					<th onclick="sortTable(7)">주야</th>
					<th onclick="sortTable(8)">학년</th>
					<th onclick="sortTable(9)">분반</th>
					<th onclick="sortTable(10)">학적상태</th>
					<th onclick="sortTable(11)">입학일자</th>
				</tr>
			</thead>
			<tbody id="tableBody2">
			</tbody>
		</table>
	</div>
</div>