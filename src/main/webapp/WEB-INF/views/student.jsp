<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Student</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
body{
margin: 0;
font-family: 'Nanum Gothic', sans-serif;
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
height: 40px;
background-color: black;
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
.main_content{
width: calc(100% - 220px);
height: calc(100vh - 125px);
/* float: right; */
background-color: skyblue;
position: relative;
right: -20px;
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
    													//이제 ddd에 iframe을 띄우면서 상위 엘리먼트에 전달되지 않게 막는게 되나?
	});
});
$(document).ready( function() {
	$(".ddd").click(function(e){
		alert("ddd");
	    e.stopPropagation();
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
<div class="menu_divider"></div>
<div class="main_body">
		<div class="side_menu">
			<div class="side_menu_title">입시</div>
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
		<div class="main_content">
		
	</div>
</div>
</body>
</html>