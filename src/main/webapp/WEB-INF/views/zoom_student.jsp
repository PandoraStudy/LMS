<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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

        function zoom_exit(){
            $(function() {
                $.ajax({
                    url: '/zoom_exit',
                    type: 'post',
                    success : function(result) {
                        if(result = 1){
                            window.close();
                        }else{
                            alert("요청 실패 관리자 문의 바람.");
                            return false;
                        }
                    },
                    error : function(xhr) {
                        alert(xhr);
                        alert("요청 실패 재시도 바람.");
                    }
                });
            });
        };



    </script>
    <style>
        .all_place{
            width: 1350px;
            height: 796px;
            float: left;
        }

        .zoom_place{
            width: 1150px;
            height: 796px;
            float: left;
        }

        .check_place{
            width:200px;
            height: 796px;
            float: left;
            text-align: center;
        }

        .check_btn{
            margin-top: 10px;
            width: 150px;
            height: 40px;
            border-radius: 5px;
            background-color: #007bff;
            border: none;
            color: white;
        }
    </style>
</head>
<body>
<div class="all_place">

    <div class="zoom_place"><%--줌 수업 공간--%>
        <iframe  src="${Join_URL}" width="1150" height="796"></iframe>
    </div>
    <div class="check_place">

        <input onclick="zoom_join_check()" type="button" value="출석 체크" class="check_btn">
        <input onclick="zoom_left_check()" type="button" value="퇴실 체크" class="check_btn">
    </div>


</div>
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