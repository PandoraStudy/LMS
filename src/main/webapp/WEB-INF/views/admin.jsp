<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Student</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap">
<!-- grid -->
<!-- <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" /> -->
<!-- <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
body{
margin: 0;
font-family: 'Nanum Gothic', sans-serif;
min-width: 1245px;
}
.top_menu{
width: 100%;
height: 85px;
background-color: lightblue;
}
.banner{
width: 200px;
height: 65px;
position: relative;
left: 20px;
bottom: -20px;
background-color: blue;
}
.menu{
top: -30px;
width: calc(100% - 200px);
height: 40px;
left: 200px;
bottom: 20px;
position: relative;
background-color: lightgreen;
}
.menu > ul{
margin: 0;
}
.menu > ul >li{
width: inherit;
min-width: 38px;
padding-left: 16px;
padding-right: 16px;
height: 40px;
list-style: none;
float: left;
font-size: 18px;
line-height: 40px;
font-weight: 700;
}
.top_search_bar{
position: absolute;
top: 0;
right: 330px;
}
.top_search{
margin-right: 5px;
width: 150px;
height: 25px;
position: relative;
border: 1px solid lightgray;
}
.top_search_btn{
width: 50px;
height: 31px;
position: relative;
top: 1px;
border: 1px solid lightgray;
}
.user_menu{
width: 310px;
height: 32px;
background-color: #f7f6f6;
position: absolute;
right: 0;
top: 0;
clip-path: polygon(0% 0, 100% 0, 95% 100%, 5% 100%);
line-height: 32px;
font-size: 14px;
}
.user_menu > ul{
margin: 0;
}
.user_menu > ul >li{
width: 90px;
height: 20px;
list-style: none;
float: left;
}
.user_menu > ul >li:not(:last-child):after{
    content: "\00a0\00a0\00a0|";
}
.menu_divider{
width: 100%;
/* min-width: 1280px; */
height: 40px;
background-color: black;
/* display: flex; */
justify-content : right;
position: relative;
}
.tab_bar{
width: calc(100% - 260px);
min-width: 1020px;
height: 30px;
/* background-color: blue; */
position: absolute;
bottom: 0;
right: 20px;
font-size: 14px;
}
.tab_bar > input{
display: none;
}
.tab_bar > label{
width: 112px;
height: 30px;
background-color: black;
border-radius: 5px 5px 0 0;
line-height: 30px;
text-align: center;
display: block;
vertical-align: text-bottom;
float: left;
color: gray;
}
.tab_bar input:checked + label {
/* 해당 메뉴가 선택된 상태인지 아닌지를 사용자에게 알려줄 수 있음 */
font-weight: bold;
background-color: white;
}
.tabs{
width: 112px;
height: 30px;
background-color: white;
border-radius: 5px 5px 0 0;
line-height: 30px;
text-align: center;
}
.main_body{
height: calc(100vh - 125px);
background-color: skyblue;
display: flex;
}
.side_menu{
width: 200px;
height: calc(100vh - 85px);
background-color: pink;
position: relative;
top: -40px;
left: 20px;
font-size: 14px;
}
.side_menu_title{
width: 200px;
height: 80px;
background-color: #0060af;
color: white;
font-size: 18px;
line-height: 80px;
font-weight: 700;
text-align: center;
}
.side_menu > ul{
padding: 0;
margin: 0;
}
.side_menu > ul > li{
list-style: none;
/* width: 182px; 														슬라이드바를 쓸 경우	*/
width: 200px;
/* height: 33px; */
border: 1px solid black;
line-height: 31px;
float: right;
box-sizing: border-box;
padding-left: 19px;
}
.side_submenu{
padding: 0;
margin: 0;
}
.side_submenu > li{
list-style: none;
/* width: 182px; 														슬라이드바를 쓸 경우	*/
width: 200px;
/* height: 33px; */
border: 1px solid black;
line-height: 31px;
float: right;
box-sizing: border-box;
padding-left: 38px;
display: none;
}
.side_submenu_sub{
padding: 0;
margin: 0;
}
.side_submenu_sub > li{
list-style: none;
/* width: 182px; 														슬라이드바를 쓸 경우	*/
width: 200px;
/* height: 33px; */
border: 1px solid black;
line-height: 31px;
float: right;
box-sizing: border-box;
padding-left: 57px;
display: none;
}
.side_submenu_sub > li:before {
	content: "\25AA";
}
.main_container{
padding-left: 20px;
padding-right: 20px;
width: calc(100% - 260px);
height: calc(100vh - 125px);
/* float: right; */
background-color: skyblue;
position: relative;
right: -20px;
/* display: none; */
}
.title_img{
width: 16px;
height: 16px;
margin-right: 5px;
}
.main_container_title {
padding-bottom: 5px;
width: 100%;
/* min-width: 1040px; */
height: 34px;
border-bottom: 1px solid gray;
font-size: 16px;
font-weight: 600;
display: flex;
flex-direction: row;
align-items: flex-end;
/* flex-direction 속성을 row로 적용하면 이미지 및 텍스트 요소가 가로로(행으로) 
정렬되고 align-items: flex-end는 두 요소를 컨테이너 하단에 정렬합니다. */
}
.main_container_interspace{
width: 100%;
/* min-width: 1040px; */
height: 48px;
background-color: red;
position: relative;
}
.search_btn{
position: absolute;
right: 10px;
top: 10px;
width: 50px;
height: 28px;
}
.main_container_search{
width: 100%;
/* min-width: 1020px; */
height: 40px;
border: 1px solid gray;
position: relative;
box-sizing: border-box;
}
.main_container_search > div{
width: 119px;
/* width: calc((100% / 3) * (1 - 0.62)); */
min-width: 119px;
height: 26px;
line-height: 28px;
font-size: 14px;
text-align: right;
margin-left: 10px;
margin-right: 10px;
float: left;
position: relative;
top: 6px;
}
.main_container_search > input{
width: 195px;
/* width: calc((100% / 3) * (1 - 0.43)); */
min-width: 190px;
height: 23px;
float: left;
position: relative;
top: 5px;
}
.main_container_search > select{
width: 195px;
/* width: calc((100% / 3) * (1 - 0.41)); */
min-width: 195px;
height: 28px;
float: left;
position: relative;
top: 5px;
}
.div_input{
width: calc((100% / 3) * (1 - 0.43));
min-width: 190px;
height: 29px;
float: left;
position: relative;
right: 5px;
top: 5px;
display: block;
}
.div_input_left{
width: calc(100% * (1 - 0.55) - 30px);
height: 23px;
float: left;
}
.div_input_right{
width: calc(100% * (1 - 0.45) - 30px);
height: 23px;
float: left;
}
.magnifyingBtn{
width: 28px;
height: 28px;
float: left;
position: relative;
left: 5px;
}
.main_container_subtitle{
position: relative;
top: 20px;
width: 92px;
height: 20px;
background-color: red;
font-size: 16px;
float: left;
}
.blue_bar{
width: 4px;
height: 16px;
background-color: blue;
position: relative;
float: left;
margin-right: 3px;
}
.main_content{
width: 100%;
min-height: 450px;
/* min-height: calc(100vh - 400px;); */
border: 1px solid gray;
border-top: 2px solid blue;
position: relative;
top: 40px;
}
.main_table{
width: 100%;
/* min-height: 450px; */
/* min-height: calc(100vh - 400px;); */
border: 1px solid gray;
/* border-top: 2px solid blue; */
position: relative;
top: -20px;
font-size: 14px;
text-align: center;
line-height: inherit;
border-spacing: 0;
border-collapse: collapse;
}
.main_table > thead > tr{
height: 36px;
}
.main_table > thead > tr > th {
border: 1px solid gray;
box-sizing: border-box;
border-collapse: collapse;
background-color: lightgray;
}
.main_table > tbody > tr > td{
height: 36px;
min-height: 36px;
border: 1px solid gray;
box-sizing: border-box;
border-collapse: collapse;
}
.btnMenuX{
width: 13px;
height: 13px;
}
</style>
<script type="text/javascript">
function dp_menu() {
	event.stopPropagation(); // Prevent event bubbling
	let clickedLi = event.target.closest("li"); // Get the clicked <li> element
	let clickedLiLevel = parseInt(clickedLi.getAttribute("data_level"));

	let childLis = clickedLi.querySelectorAll("li");
	childLis.forEach(function(li) {
		let liLevel = parseInt(li.getAttribute("data_level"));

		// Check if the current <li> is a direct child of the clicked <li>
		if (liLevel === clickedLiLevel + 1) {
			if (li.style.display === "none") {
				li.style.display = "block";
				console.log("레벨 : " + liLevel);
				console.log("클릭레벨 : " + clickedLiLevel);
			} else {
				li.style.display = "none";
				console.log("레벨2 : " + liLevel);
				console.log("클릭레벨2 : " + clickedLiLevel);
			}

		} else {
			console.log("레벨3 : " + liLevel);
			console.log("클릭레벨3 : " + clickedLiLevel);
		}
	});
}
$(document).ready( function() {
$(".d").click(function(e){
// 	console.log("d");
	$(".dd").toggle();
// 	$(this).find('.dd').toggle();
    e.stopPropagation();
    e.preventDefault();
	});
});
$(document).ready( function() {
$(".dd").click(function(e){
// 	console.log("dd");
// 	$(".ddd").toggle();
	$(this).find('.ddd').toggle();
    e.stopPropagation();								//e.stopPropagation는 이벤트가 상위 엘리먼트에 전달되지 않게 막아 준다.
    e.preventDefault();									//e.preventDefault는 고유 동작을 중단시킨다.
	});
});
$(document).ready( function() {
	$(".ddd").click(function(e){
		alert("ddd");
	    e.stopPropagation();
	});
});
// /* 테이블 grid */
// $(document).ready( function () {
//     $('#main_table').DataTable();
// } );

//1번탭 활성화
$(document).ready( function() {
	$("#tabs1, #li_content1").click(function(e){
	    $("#content1").css("display","block");
	    $("#tabs1").attr("checked", "checked");
	    
	});
});
//test include
$(document).ready( function() {
	$("#li_content4").click(function(e){
		alert("테스트");
		$("#content1").load("/mainContentTest");
	    $("#tabs1").attr("checked", "checked");
	    
	});
});
//탭 추가
$(document).ready( function() {
	$("#li_content3").click(function(e){
		var title = $("#li_content3").text();
		var tabs = $(".tab_bar").html();
		$(".tab_bar").empty();
	    $(".tab_bar").append(tabs + "<input type='radio' name='tabs' id='tabs3' checked><label for='tabs3'>"
	    		+ title 
	    		+"<img alt='btnMenuX' src='/img/btnMenuX.png' class='btnMenuX'></label>");
	});
});
</script>

</head>
<body>
<div class="top_menu">
	<div class="banner"></div>
	<div class="menu">
		<ul>
			<li>입시</li>
			<li>학사</li>
			<li>행정</li>
			<li>연구/사업</li>
			<li>경영정보</li>
			<li>시스템</li>
		</ul>
	</div>
	<div class="top_search_bar">
		<input type="text" class="top_search"><input type="button" value="검색" class="top_search_btn">
	</div>
	<div class="user_menu">
		<ul>
			<li>내이름</li>
			<li>즐겨찾기</li>
			<li>로그아웃</li>
		</ul>
	</div>
</div>
<div class="menu_divider">
	<div class="tab_bar">
	
<!-- 		<div class="tabs">학생일정관리<img alt="btnMenuX" src="/img/btnMenuX.png" style="width: 13px; height: 13	px;"></div> -->
		<input type="radio" name="tabs" id="tabs1">
		<label for="tabs1">학생명부조회
		<img alt="btnMenuX" src="/img/btnMenuX.png" class="btnMenuX">
		</label>
		
		<input type="radio" name="tabs" id="tabs2">
		<label for="tabs2">강사일정관리
		<img alt="btnMenuX" src="/img/btnMenuX.png" class="btnMenuX">
		</label>
		
	</div>
</div>
<div class="main_body">
		<div class="side_menu">
			<div class="side_menu_title">학사</div>
			<ul>
				<li onclick="dp_menu()" data_level="1">학생관리
					<ul class="side_submenu" id="side_submenu">
						<li onclick="dp_menu()" data_level="2">학생명단조회
							<ul class="side_submenu_sub">
								<li data_level="3">학생명부조회</li>
							</ul>
						</li>
						<li onclick="dp_menu()" data_level="2">학생성적조회
							<ul class="side_submenu_sub">
								<li data_level="3">학생성적조회</li>
								<li data_level="3">학생성적조회</li>
							</ul>
						</li>
					</ul>
				</li>
				<li class="d">수업관리
					<ul class="side_submenu">
						<li class="dd">학생관리
							<ul class="side_submenu_sub">
								<li class="ddd" id="li_content1">학생명부조회</li>
								<li class="ddd" id="li_content4">학생일정관리</li>
								<li class="ddd" id="li_content3">출결관리</li>
								<li class="ddd">강사일정관리</li>
							</ul>
						</li>
						<li class="dd">강의주차관리
							<ul class="side_submenu_sub">
								<li class="ddd">1주차</li>
								<li class="ddd">2주차</li>
								<li class="ddd">3주차</li>
							</ul>
						</li>
						<li class="dd">개설강좌관리
							<ul class="side_submenu_sub">
								<li class="ddd">1주차</li>
								<li class="ddd">2주차</li>
								<li class="ddd">3주차</li>
							</ul>
						</li>
						<li class="dd">강의출석관리
							<ul class="side_submenu_sub">
								<li class="ddd">1주차</li>
								<li class="ddd">2주차</li>
								<li class="ddd">3주차</li>
							</ul>
						</li>
					</ul>
				</li>
				<li>교직관리
					<ul class="side_submenu">
						<li></li>
					</ul>
				</li>
			</ul>
		</div>
<!-- 		<div class="main_container" id="content2" style="background-color: blue;"></div> -->
		<div class="main_container" id="content1">
			
		</div>
</div>
</body>
</html>