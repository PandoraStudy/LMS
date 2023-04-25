<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Pandora University</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
body{
margin: 0;
font-family: 'Nanum Gothic', sans-serif;
color: #303030;
min-width: 1245px;
}
.top_menu{
width: 100%;
height: 85px;
/* background-color: lightblue; */
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
/* background-color: lightgreen; */
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
border: 1px solid #c7ced2;
}
.top_search_btn{
width: 50px;
height: 31px;
position: relative;
top: 1px;
border: 1px solid #c7ced2;
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
background-color: #303030;
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
width: auto;
padding-left: 10px;
padding-right: 10px;
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
.tab_bar label{
cursor: pointer;
}
.tab_bar label:hover{
text-decoration-line: underline;
}
.tab_bar input:not(:checked) + label{
/* 해당 메뉴가 선택된 상태인지 아닌지를 사용자에게 알려줄 수 있음 */
color: gray;
background-color: #303030;
}
/* .tabs{ */
/* width: 112px; */
/* height: 30px; */
/* background-color: white; */
/* border-radius: 5px 5px 0 0; */
/* line-height: 30px; */
/* text-align: center; */
/* } */
.main_body{
height: calc(100vh - 125px);
/* background-color: skyblue; */
display: flex;
}
.side_menu{
width: 200px;
height: calc(100vh - 85px);
/* background-color: pink; */
position: relative;
top: -40px;
left: 20px;
font-size: 14px;
/* border: 1px solid #c7ced2; */
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
.side_menu_list{
border: 1px solid #c7ced2;
border-collapse: collapse;
overflow-y: scroll;
overflow-x: hidden;
max-height: 580px;
}
.side_menu_list > ul{
padding: 0;
margin: 0;
}
.side_menu_list > ul > li{
list-style: none;
/* width: 182px; 														슬라이드바를 쓸 경우	*/
width: 200px;
/* height: 33px; */
border: 1px solid #c7ced2;
line-height: 31px;
float: right;
box-sizing: border-box;
padding-left: 19px;
}
.li_step3:hover{
font-weight: 600;
text-decoration: underline;
}
/* .li_step3:hover{ */
/* background-color: #e1f1fb; */
/* font: bold; */
/* text-decoration: underline; */
/* } */
.side_submenu{
padding: 0;
margin: 0;
}
.side_submenu > li{
list-style: none;
/* width: 182px; 														슬라이드바를 쓸 경우	*/
width: 200px;
/* height: 33px; */
border-top: 1px solid #c7ced2;
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
border-top: 1px solid #c7ced2;
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
/* background-color: skyblue; */
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
border-bottom: 1px solid #c7ced2;
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
/* background-color: red; */
position: relative;
}
.search_btn{
margin-top: 10px;
margin-bottom: 10px;
margin-left: 1px;
margin-right: 1px;
position: relative;
width: 50px;
height: 28px;
float: right;
border: 1px solid #c7ced2;
border-radius: 3px;
background-color: #f7f6f6;
}
.search_btn:hover{
background-color: #ffffff;
text-decoration: underline;
cursor: pointer;
}

.main_container_search{
width: 100%;
/* min-width: 1020px; */
height: 40px;
border: 1px solid #c7ced2;
position: relative;
box-sizing: border-box;
background-color: #f3fafe;
}
.main_container_search > div{
width: 140px;
/* width: calc((100% / 3) * (1 - 0.62)); */
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
width: 220px;
/* width: calc((100% / 3) * (1 - 0.43)); */
min-width: 190px;
height: 23px;
float: left;
position: relative;
top: 5px;
}
.main_container_search > select{
width: 230px;
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
width: 80px;
height: 23px;
float: left;
}
.div_input_right{
width: 95px;;
height: 23px;
float: left;
}
.div_select_right{
width: 100px;
height: 29px;
float: left;
}
.magnifyingBtn{
width: 28px;
height: 28px;
}
.main_container_subtitle{
margin-right: 12px;
position: relative;
top: 20px;
width: inherit;
min-width: 80px;
height: 20px;
/* background-color: red; */
font-size: 16px;
font-weight: 600;
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
height: 440px;
/* min-height: calc(100vh - 400px;); */
border: 1px solid #c7ced2;
border-top: 2px solid blue;
border-bottom: 2px solid #c7ced2;
position: relative;
top: 20px;
overflow-y: auto;  /* 수직 스크롤바가 필요한 경우에만 표시 */
overflow-x: hidden;/* 수평 스크롤바를 숨김 */
}
.main_table{
width: 100%;
/* max-height: 434px; */
/* min-height: 450px; */
/* min-height: calc(100vh - 400px;); */
border: 1px solid #c7ced2;
/* border-top: 2px solid blue; */
/* position: relative; */
/* top: -20px; */
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
border: 1px solid #c7ced2;
box-sizing: border-box;
border-collapse: collapse;
background-color: #f7f6f6;
cursor: pointer;
}
.main_table > tbody > tr > td{
height: 36px;
min-height: 36px;
border: 1px solid #c7ced2;
box-sizing: border-box;
border-collapse: collapse;
}
.btnMenuX{
width: 13px;
height: 13px;
}
.short{
height: 280px;
}
.modify{
height: 90px;
position: relative;
top: 60px;
}
.modal_opacity{
display: none;
width: 100%;
height: 100vh;
background-color: rgba(255, 255, 255, 0.8);
z-index: 1;
position: absolute;
top: 0;
left: 0;
}
.modal_department{
width: 606px;
height:610px;
background-color: white;
position: absolute;
top: calc(50vh - 303px);
left: calc(50% - 305px);
border: 1px solid #0060af;
}
.modal_top_bar{
width: calc(100% - 10px);
height: 29px;
border-bottom: 1px solid #c7ced2;
background-color: #f8f8f8;
color: #303030;
font-size: 14px;
font-weight: 600;
line-height: 29px;
padding-left: 10px;
}
.modal_main{
width: 100%;
height: 580px;
padding: 10px;
box-sizing: border-box;
/* display: grid; */
/* grid-template-columns: 1fr 1fr; /* Change to '1fr 1fr' for side-by-side layout */ */
/* gap: 10px; */
}
.modal_main_btn{
width: 100%;
height: 38px;
}
.noMargin{
margin: 0;
}
</style>
<script type="text/javascript">
//side_menu의 메뉴 toggle
$(document).ready( function() {
$(".li_step1").click(function(e){
// 	console.log("d");
	$(this).find(".li_step2").toggle();
// 	$(this).find('.dd').toggle();
    e.stopPropagation();
    e.preventDefault();
	});
});
$(document).ready( function() {
$(".li_step2").click(function(e){
	$(this).find('.li_step3').toggle();
    e.stopPropagation();								//e.stopPropagation는 이벤트가 상위 엘리먼트에 전달되지 않게 막아 준다.
    e.preventDefault();									//e.preventDefault는 고유 동작을 중단시킨다.
	});
});
$(document).ready( function() {
	$(".li_step3").click(function(e){
		alert("li_step3");
	    e.stopPropagation();
	});
});

//1번탭 활성화
$(document).ready( function() {
	$("#tabs1, #li_content1").click(function(e){
	    $("#main_container").css("display","block");
	    $("#tabs1").attr("checked", "checked");
	});
});

//test include
// $(document).ready( function() {
// 	$("#studentList").click(function(e){
// 		var id = $(this).attr("id");
// 		//alert("테스트");
// // 		$("#tab_bar").load("/mainContentTest #tab1");
// 		$("#main_container").append("<div id='load_"+id+"' class='content'></div>");
// 		$("#load_"+id).load("/studentList");
// 	    $("#tabs1").attr("checked", "checked");
// 	    showContent("load_" + id, id);
// 	});
// });
//test2 include
$(document).ready( function() {
	$("#mainContentTest2").click(function(e){
		alert("테스트2");
// 		$("#tab_bar").load("/mainContentTest2 #tab2");
		$("#main_container").append("<div id='load_mainContentTest2' class='content'></div>");
		$("#load_mainContentTest2").load("/mainContentTest2");
	    $("#tabs2").attr("checked", "checked");
	    var id = $(this).attr("id");
	    showContent("load_mainContentTest2", id);
	});
});

//li를 클릭했을 때 탭과 main_content 활성화
function showContent(c_id, id) {
    // 공통 클래스 'content'를 가진 모든 컨텐츠를 숨깁니다.
    $(".content").hide();
    // 선택한 컨텐츠만 보입니다.
    $("#" + c_id).show();
    // if 조건에 맞는 input[name=tabs]의 checked 속성을 설정합니다.
    $("input[name=tabs]").each(function() {
        if ("tabs_" + id == $(this).attr("id")) {
            $(this).prop("checked", true);
        } else {
            $(this).prop("checked", false);
        }
    });
}

//tab을 클릭했을 때 main_content 활성화
function tabs(id){
// 	alert(id);
	$(".content").hide();
	$("#load_" + id).show();
}

//탭 추가
$(document).ready(function () {
    $(".li_step3").click(function (e) {
    	var id = $(this).attr('id');
        var title = $(this).text();
        var tabs = $("#tab_bar label");
        var isDuplicate = false;

        // 기존 탭들의 텍스트를 확인하여 중복되는 것이 있는지 확인합니다.
        tabs.each(function () {
            if ($(this).text() === title) {
                isDuplicate = true;
                return false; // 중복되는 경우, each() 반복을 종료합니다.
            }
        });

        // 중복되는 탭이 없을 때만 새로운 탭을 추가합니다.
        if (!isDuplicate) {
            var newTab = "<input type='radio' name='tabs' id='tabs_" 
            + id + "' checked><label for='tabs_" + id + "' onclick='tabs(\"" + id + "\")'>" 
            + title + "<img alt='btnMenuX' src='/img/btnMenuX.png' class='btnMenuX' id='tabs_"+id+"' onclick='close_tab(\""+id+"\")'></label>";
            $("#tab_bar").append(newTab);
        }
        
        //main_content에 load
        load(id);
    });
});

//main_content에 load
function load(id){
	$("#main_container").append("<div id='load_"+id+"' class='content'></div>");
	$("#load_" + id).load("/"+id+"");
	$("#tabs_" + id).attr("checked", "checked");
	showContent("load_" + id, id);
}

//tab 닫기
function close_tab(id){
	$("#tabs_" + id).remove();
	$("label[for='tabs_" + id + "']").remove();
	$("#load_" + id).remove();
}

//modal창 닫기
function close_modal(id){
	$("#modal_opacity").css("display","none");
	$("#" + id).remove();
}

//modal 띄우기
function modalSearch(id) {
    var modal = document.getElementById("modal_opacity");
    if (modal.style.display === "none" || modal.style.display === "") {
        modal.style.display = "block";
        $("#modal_opacity").load("/"+id);
    } else {
        modal.style.display = "none";
    }
}
</script>
<script type="text/javascript">

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
</head>
<body>
<div>
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
	<div class="tab_bar" id="tab_bar">
	
<!-- 		<div class="tabs">학생일정관리<img alt="btnMenuX" src="/img/btnMenuX.png" style="width: 13px; height: 13	px;"></div> -->
		
		
<!-- 		<input type="radio" name="tabs" id="tabs2"> -->
<!-- 		<label for="tabs2">강사일정관리 -->
<!-- 		<img alt="btnMenuX" src="/img/btnMenuX.png" class="btnMenuX"> -->
<!-- 		</label> -->
		
	</div>
</div>
<div class="main_body">
		<div class="side_menu">
			<div class="side_menu_title">학사</div>
			<div class="side_menu_list">
				<ul>
					<li class="li_step1">수업관리
						<ul class="side_submenu">
							<li class="li_step2">학생관리
								<ul class="side_submenu_sub">
									<li class="li_step3" title="학생명부조회" id="studentList">학생명부조회</li>
									<li class="li_step3" id="li_content4">학생일정관리</li>
									<li class="li_step3" id="li_content3">출결관리</li>
									<li class="li_step3">강사일정관리</li>
								</ul>
							</li>
							<li class="li_step2">강의주차관리
								<ul class="side_submenu_sub">
									<li class="li_step3">1주차</li>
									<li class="li_step3">2주차</li>
									<li class="li_step3">3주차</li>
								</ul>
							</li>
							<li class="li_step2">개설강좌관리
								<ul class="side_submenu_sub">
									<li class="li_step3">1주차</li>
									<li class="li_step3">2주차</li>
									<li class="li_step3">3주차</li>
								</ul>
							</li>
							<li class="li_step2">강의출석관리
								<ul class="side_submenu_sub">
									<li class="li_step3">강의출결관리</li>
									<li class="li_step3" title="출석부조회(학생용)" id="attendance">출석부조회(학생용)</li>
									<li class="li_step3">3주차</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">교과관리
						<ul class="side_submenu" id="side_submenu">
							<li class="li_step2">교육과정관리
								<ul class="side_submenu_sub">
									<li class="li_step3" title="교육과정관리" id="subject">교육과정관리</li>
								</ul>
							</li>
							<li class="li_step2">온라인강의관리
								<ul class="side_submenu_sub">
									<li class="li_step3" title="일반교과목관리" id="insertYoutube">일반교과목관리</li>
									<li class="li_step3">학생성적조회</li>
								</ul>
							</li>
							<li class="li_step2">학생성적조회
								<ul class="side_submenu_sub">
									<li class="li_step3">학생성적조회</li>
									<li class="li_step3">학생성적조회</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3" id="mainContentTest2">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="li_step1">empty1
						<ul class="side_submenu">
							<li class="li_step2">empty2
								<ul class="side_submenu_sub">
									<li class="li_step3">empty3</li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
<!-- 		<div class="main_container" id="content2" style="background-color: blue;"></div> -->

<!-- main_container -->
		<div class="main_container" id="main_container">
		</div>
</div>
</div>
<div id="modal_opacity" class="modal_opacity">
</div>
</body>
</html>