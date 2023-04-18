<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link type="text/css" rel="stylesheet" href="css/Notice.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <title>Pandora University - LMS</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
          rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <link href="css/logo.css" rel="stylesheet">

    <%-- ==================full캘린더================== --%>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.5/index.global.min.js"></script>
    <%-- ==================full캘린더================== --%>
    <script>

        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth'
            });
            calendar.render();
        });

        $(function() {
            $('#zoom_open').click(function (result){
                $.ajax({
                    url: '/zoom_open',
                    type: 'post',
                    dataType: 'text',
                    success : function(result) {
                        if(result == "true"){
                            alert("인증에 성공했습니다.");
                            window.location.href = "https://zoom.us/oauth/authorize?client_id=Kpvu8qjDSZCEnEtzZ58KnA&response_type=code&redirect_uri=http://localhost/zoom/token";



                         /*   let joinUrl = $("#Join_URL").val();
                            window.location.href = joinUrl;*/

                        }else{
                            alert("인증실패 관리자 문의 바람.");
                            return false;
                        }
                    },
                    error : function(xhr) {
                        alert(xhr);
                        alert("요청 실패 재시도 바람.");
                    }
                });

            });
        });

    </script>
    <style>
        #calendar {
            width: 90%;
            height: 500px;
            margin: 0 auto;
        }

        .main_content {
            width: 1400px;
            float: left;
        }

        .main_left {
            width: 700px;
            float: left;
        }

        .notice_card {
            width: 885px;
            height: 150px;
        }

        .schedule_card {
            width: 885px;
        }

        .main_right {
            width: 500px;
            margin-left: 200px;
        }

    </style>
</head>

<body id="page-top">
<!-- Page Wrapper -->
<div id="wrapper">

    <%-- 네비게이션 바 --%>
    <%@include file="navbar.jsp" %>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- 메인 컨텐츠 -->
        <div id="content">
            <%-- 탑 바 --%>
            <%@include file="top.jsp" %>

            <!-- 본문 컨텐츠 부분 시작 -->
            <div class="container-fluid">

                <!-- 페이지 헤드 부분 -->
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800">학생</h1>
                    <a id="zoom_open" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                            class="fas fa-download fa-sm text-white-50"></i> 이건무슨 버튼으로 쓸까</a>
                    <input type="hidden" id="Join_URL" value="${Join_URL}">
                </div>
                <!-- 컨텐츠 탑 부분 -->
                <div class="main_content"><%--main_left--%>
                    <div class="main_left">
                        <!-- 학사 공지 -->
                        <div class="notice_card mb-4">
                            <div class="card border-left-primary shadow h-100 py-2" style="min-height:370px;">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2" >
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">공지사항 최신글</div><br>
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                <table class="table">
                                                    <tr class="table_header">
                                                        <td class="col-1" style="text-align: center;">번호</td>
                                                        <td class="col-4" style="text-align: center;">제목</td>
                                                        <td class="col-2" style="text-align: center;">작성자</td>
                                                        <td class="col-2" style="text-align: center;">조회수</td>
                                                        <td class="col-2" style="text-align: center;">등록일</td>
                                                    </tr>
                                                    <c:forEach var="notice" items="${list }">
                                                        <tr>
                                                            <td>${notice.rowNum }</td>
                                                            <td class="title text-truncate" style="max-width:1px; text-align: left;">
                                                                <a href="/noticeDetail?rowNum=${notice.rowNum }&totalCnt=${totalCount}">${notice.notice_title }</a>
                                                            </td>
                                                            <td>${notice.admin_id }</td>
                                                            <td>${notice.notice_read }</td>
                                                            <td>${notice.notice_date }</td>
                                                        </tr>
                                                    </c:forEach>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 학사일정 -->
                        <div class="schedule_card mb-4" style="margin-top:230px;">
                            <div class="card shadow mb-4">
                                <!-- A 카드 설정 버튼 부분 -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">학사 일정</h6>
                                </div>
                                <!-- A 본문 부분 -->
                                <div class="card-body">
                                    <div style="height: 345px;" class="chart-area">
                                        <div>아아아 본문 내용은 여기에~~~</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--main_left--%>
                    <!-- 컨텐츠 탑 부분 끝 -->
                    <div class="row">
                        <!-- 캘린더 -->
                        <div class="main_right">
                            <div class="card shadow mb-4">
                                <!-- B 카드 설정 버튼 부분 -->
                                <div
                                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">캘린더</h6>
                                    <div class="dropdown no-arrow">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                             aria-labelledby="dropdownMenuLink">
                                            <div class="dropdown-header">필요한가 ?</div>
                                            <a class="dropdown-item" href="#">필요하나요?</a>
                                            <a class="dropdown-item" href="#">필요 합니까?</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">아아아ㅏ아아아아</a>
                                        </div>
                                    </div>
                                </div>

                                <div style="margin:5px; padding:0; height: 550px;" class="card-body">

                                    <div class="chart-pie pt-4 pb-2">
                                        <%--본문 내용 작성하는 부분--%>
										<div id="calendar"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- C 카드 부분 -->
                    <div class="row" style="margin-top:200px;">
                        <!-- Content Column -->
                        <div class="col-lg-6 mb-4">
                            <!-- 진도율 -->
                            <div class="card shadow mb-4" style="margin: 0px 300px 0px -713px;">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">진도율</h6>
                                </div>
                                <div class="card-body">
                                    <h4 class="small font-weight-bold">자바
                                    <span class="float-right">20%</span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar bg-danger" role="progressbar" style="width: 20%"
                                             aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <h4 class="small font-weight-bold">파이썬 <span
                                            class="float-right">40%</span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar bg-warning" role="progressbar" style="width: 40%"
                                             aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <h4 class="small font-weight-bold">자바 스크립트<span
                                            class="float-right">60%</span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar" role="progressbar" style="width: 60%"
                                             aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <h4 class="small font-weight-bold">HTML<span
                                            class="float-right">80%</span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar bg-info" role="progressbar" style="width: 80%"
                                             aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <h4 class="small font-weight-bold">진행율<span
                                            class="float-right">Complete!</span></h4>
                                    <div class="progress">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 100%"
                                             aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 mb-4">
                            <!-- 식단 -->
                            <div class="card shadow mb-4" style="margin-left:-310px;">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">식단표</h6>
                                </div>
                                <div class="card-body">
                                    <div style="height: 294px;" class="text-center">
                                        <img src="/img/pandora_rise.png">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div><!-- container-fluid -->

            </div><!-- End of Main Content -->



        </div><!-- End of Content Wrapper -->

        <!-- Footer -->
        <%@include file="footer.jsp" %>

    </div><!-- End of Page Wrapper -->

    <!-- Scroll to Top Button -->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>
    <!-- Page level plugins -->
    <script src="vendor/chart.js/Chart.min.js"></script>
    <!-- Page level custom scripts -->
    <script src="js/demo/chart-area-demo.js"></script>
    <script src="js/demo/chart-pie-demo.js"></script>
</body>
</html>