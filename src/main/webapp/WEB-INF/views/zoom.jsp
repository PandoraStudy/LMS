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


    <style>
        .all_place{
            width: 1540px;
            height: 796px;
            float: left;
        }

        .zoom_place{
            width: 1150px;
            height: 796px;
            float: left;
        }

        .check_place{
            width:390px;
            height: 796px;
            float: left;
        }

        .save_btn{
            position: absolute;
            bottom: 10px;
            right: 10px;
        }

        .check_box{
            margin-left: 11px;
        }

    </style>
</head>
<body>
<div class="all_place">

    <div class="zoom_place"><%--줌 수업 공간--%>
    <iframe src="${Join_URL}" width="1150" height="796"></iframe>
    </div>

    <div class="check_place"><%--출석 체크 공간--%>
        <div class="check">
                <div class="card shadow mt-4">
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">출석체크</h6>
                    </div>
                    <div style="margin:5px; padding:0; height: 700px;" class="card-body">
                        <div class="chart-pie pt-4 pb-2">
                            <%--본문 내용 작성하는 부분--%>
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th>이름</th>
                                        <th>출석</th>
                                        <th>지각</th>
                                        <th>결석</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <th>이민규</th>
                                        <th><input class="check_box" type="checkbox"></th>
                                        <th><input class="check_box" type="checkbox"></th>
                                        <th><input class="check_box" type="checkbox"></th>
                                    </tr>
                                    </tbody>
                                </table>
                            <button class="btn btn-primary save_btn">저장하기</button>
                        </div>
                    </div>
                </div>
        </div>

        </div>
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