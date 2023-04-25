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
		<div class="main_container_subtitle" style="width: 120px;">
		<div class="blue_bar"></div>
		소속학과 정보
		</div>
		<div style="font-size: 14px; color: gray; position: relative; float: left; top: 20px;">
		<span id="cnt_departmentModal"></span>건이 조회되었습니다.
		</div>
		<div class="main_content">
			<table id="main_table_departmentModal" class="main_table">
				<thead>
					<tr>
						<th onclick="sortTable(0, main_table_departmentModal)">코드</th>
						<th onclick="sortTable(1, main_table_departmentModal)">소속학과</th>
						<th onclick="sortTable(2, main_table_departmentModal)">주야</th>
						<th onclick="sortTable(3, main_table_departmentModal)">부서구분</th>
						<th onclick="sortTable(4, main_table_departmentModal)">사용</th>
					</tr>
				</thead>
				<tbody id="tableBody_departmentModal">
				</tbody>
			</table>
		</div>
	</div>
</div>