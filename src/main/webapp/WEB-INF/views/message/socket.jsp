<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>socket 통신</title>

    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <script type="text/javascript" src="/js/NoticePaging.js"></script>
    <script type="text/javascript" src="/js/search.js"></script>
    <script type="text/javascript" src="/js/login/socket.js"></script>
    <link type="text/css" rel="stylesheet" href="css/Notice.css">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
          rel="stylesheet">
    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <link href="css/logo.css" rel="stylesheet">

</head>
<style>
    .socketBtn{
        width:100px;
        height:40px;
        color:white;
        border:none;
        border-radius: 5px;
    }
    .messageBody{
        margin:5px;
        font-weight: bold;
    }
</style>
<script>
    const name = "${sessionScope.name}";
    $(function(){
        $("#msg").on('keypress', function(e){
            if(e.keyCode == 13){ $("#msgsend").click(); }
        });
    });

</script>
<style></style>
<body id="page-top">
<!-- Page Wrapper -->
<div id="wrapper">
    <%-- 네비게이션 바 --%>
    <%@include file="../navbar.jsp" %>
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <!-- 메인 컨텐츠 -->
        <div id="content">
            <%-- 탑 바 --%>
            <%@include file="../top.jsp" %>
            <!-- 본문 컨텐츠 부분 시작 -->
            <div class="container-fluid" style="width:1200px; min-height:800px; margin-top:100px;">
                <div class="d-sm-flex align-items-center justify-content-between mb-4" style=" margin-top:50px; text-align: center;">
                    <!--수정할 부분 시작-->
                    <div id="messageBox" style="text-align:left; width:1200px; height:500px; border:1px solid black;"></div>
                    <!--수정할 부분 끝-->
                </div>
                <input type="text" style="width:500px; height:40px;" id="msg">
                <button id="msgsend"class="socketBtn" style="background-color: #2a96a5;" onclick="msg_send()">전송</button>
                <button class="socketBtn" onclick="disconnect()" style="background-color: darkred;">disconnect</button>
                <script></script>
            </div>

        </div><!-- End of Main Content -->
        <!-- footer -->
        <%@include file="../footer.jsp" %>
    </div><!-- End of Content Wrapper -->
</div> <!-- End of Page Wrapper -->

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
