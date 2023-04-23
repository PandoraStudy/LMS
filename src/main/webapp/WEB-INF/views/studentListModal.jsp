<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<div id="modal_department" class="modal_department">
	<div class="modal_top_bar">소속학과검색(CO0025P)</div>
	<div class="modal_main">
		<div class="modal_main_btn">
			<input type="submit" value="닫기" id="close_btn_modal" class="search_btn noMargin" onclick="close_modal(modal_department)">
			<input type="submit" value="선택" id="select_btn_modal" class="search_btn noMargin">
			<input type="submit" value="조회" id="search_btn_modal" class="search_btn noMargin">
		</div>
		<div class="main_container_search modal_search">
			<div>소속학과</div>
			<input>
		</div>
		<div class="main_container_subtitle">
		<div class="blue_bar"></div>
		소속학과 정보
		</div>
		<div style="font-size: 14px; color: gray; position: relative; float: left; top: 20px;">
		<span id="cnt_studentListModal"></span>건이 조회되었습니다.
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
				</tr>
			</thead>
			<tbody id="tableBody">
			
			</tbody>
		</table>
	</div>
	</div>
</div>