<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- tab1 -->

<div class="tabs" id="tab1">
<style>
.tabs > input{
display: none;
}
.tabs > label{
width: 112px;
height: 30px;
border-radius: 5px 5px 0 0;
line-height: 30px;
text-align: center;
display: block;
vertical-align: text-bottom;
float: left;
font-weight: bold;
background-color: white;
}
.tabs input:not(:checked) + label {
/* 해당 메뉴가 선택된 상태인지 아닌지를 사용자에게 알려줄 수 있음 */
color: gray;
background-color: black;
}
</style>
<input type="radio" name="tabs" id="tabs1" checked="checked">
<label for="tabs1">학생명부조회
<img alt="btnMenuX" src="/img/btnMenuX.png" class="btnMenuX">
</label>
</div>

<!-- main_container -->

<div id="main_container">
	<div class="main_container_title">
		<img class="title_img" alt="title" src="/img/icon/title.png">학생명부조회{side_submenu_sub}
	</div>

	<form id="search-form">
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
		<span id="cnt"></span>건이 조회되었습니다.
	</div>
	<div class="main_content">
		<table id="main_table" class="main_table">
			<thead>
				<tr>
					<th>과정</th>
					<th>입학</th>
					<th>학번</th>
					<th>이름</th>
					<th>생년월일</th>
					<th>성별</th>
					<th>소속학과</th>
					<th>주야</th>
					<th>학년</th>
					<th>분반</th>
					<th>학적상태</th>
					<th>입학일자</th>
				</tr>
			</thead>
			<tbody id="tableBody">
			</tbody>
		</table>
	</div>
</div>