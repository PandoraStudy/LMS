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
    <script>
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

        function Zoom_Meeting(){

            window.open("${Join_URL}","${Join_URL}","width=1100, height=800");


        }

    </script>
    <style>
    </style>
</head>

<body id="page-top">
<div id="wrapper">
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <div class="container-fluid">
                <!-- 페이지 헤드 부분 -->
                        <div class="schedule_card mt-5">
                            <div class="card shadow mb-4">
                                <!-- A 카드 설정 버튼 부분 -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 text-lg-center font-weight-bold text-primary">학사 일정</h6>
                                </div>
                                <!-- A 본문 부분 -->
                                <div class="card-body">
                                    <div style="height: 140px;" class="chart-area">
                                        <div>


                                            <c:if test="${ Join_URL eq null }">
                                                <button id="zoom_open" class="btn btn-primary"  href="https://zoom.us/oauth/authorize?client_id=Kpvu8qjDSZCEnEtzZ58KnA&response_type=code&redirect_uri=http://localhost/zoom/token"><i class="fas fa-download fa-sm text-white"></i>
                                                    줌 수업 개설
                                                </button>
                                            </c:if>

                                            <c:if test="${ Join_URL ne null }">
                                                <a onclick="Zoom_Meeting()"class="btn btn-primary"><i class="fas fa-download fa-sm text-white"></i>줌 수업 이동</a>
                                                <button class="btn btn-primary"><i class="fas fa-download fa-sm text-white"></i>출석체크</button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            엑세스 토큰 : ${ accessToken } <br>
            회의 주소 : ${ Join_URL } <br>

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