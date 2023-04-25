<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready( function() {
	$("#search_btn_modal").click(
		function(e) {
			$.ajax({
				url : "/search/studentsModal",
				type : "POST",
				dataType : "json",
				data : $("#studentsModal_form").serialize(),
				success : function(data) {
					$('#tableBody_studentsModal').empty();
					$('#cnt_studentsModal').empty();
					alert(data);
					var result = data;
					var str = "";
					$.each(result, function(i, info) {
						str += '<tr><td>' + info.appl_NO
								+ '</td><td>' + info.korn_FLNM
								+ '</td><td>' + info.gender_CD
								+ '</td><td>' + info.user_BRDT
								+ '</td><td>' + info.telno
								+ '</td></tr>';
					});
					$('#tableBody_studentsModal').append(str);
					$('#cnt_studentsModal').append(result.length);
				}
			});
		});
	});
</script>
<style>
.modal_search{
height: 38px;
}
.modal_search > div {
width: 90px;
line-height: 26px;
}
.modal_search > input {
width: 170px;
min-width: 170px;
}
</style>
<div id="modal_students" class="modal_department">
	<div class="modal_top_bar">학생검색(SL9999P)</div>
	<div class="modal_main">
		<div class="modal_main_btn">
			<input type="submit" value="닫기" id="close_btn_modal" class="search_btn noMargin" onclick="close_modal(modal_students)">
			<input type="submit" value="선택" id="select_btn_modal" class="search_btn noMargin">
			<input type="submit" value="조회" id="search_btn_modal" class="search_btn noMargin">
		</div>
			<form id="studentsModal_form">
				<div class="main_container_search modal_search">
					<div>학생(이름)</div>
					<input name="name">
				</div>
			</form>
		<div class="main_container_subtitle" style="width: 120px;">
		<div class="blue_bar"></div>
		소속학과 정보
		</div>
		<div style="font-size: 14px; color: gray; position: relative; float: left; top: 20px;">
		<span id="cnt_studentsModal"></span>건이 조회되었습니다.
		</div>
		<div class="main_content">
			<table id="main_table_studentsModal" class="main_table">
				<thead>
					<tr>
						<th onclick="sortTable(0, main_table_studentsModal)">학번</th>
						<th onclick="sortTable(1, main_table_studentsModal)">이름</th>
						<th onclick="sortTable(2, main_table_studentsModal)">성별</th>
						<th onclick="sortTable(3, main_table_studentsModal)">생년월일</th>
						<th onclick="sortTable(4, main_table_studentsModal)">연락처</th>
					</tr>
				</thead>
				<tbody id="tableBody_studentsModal">
				</tbody>
			</table>
		</div>
	</div>
</div>