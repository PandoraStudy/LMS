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
				data : $("#studentList_form").serialize(),
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
<div id="main_container_load">
	<div class="main_container_title">
		<img class="title_img" alt="title" src="/img/icon/title.png">학생명부조회
	</div>

	<form id="studentList_form">
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
			<img alt="magnifyingBtn" src="/img/icon/magnifyingBtn.png" class="magnifyingBtn" onclick="modalSearch('departmentModal')">
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