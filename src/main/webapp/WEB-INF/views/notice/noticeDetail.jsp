<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Notice Detail</title>
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <script type="text/javascript" src="/js/NoticePaging.js"></script>
    <script type="text/javascript" src="/js/search.js"></script>
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
<style></style>
<script>
    function noticeUpdate(notice_no){ location.href="/noticeUpdate?notice_no="+notice_no; }
    function noticeDelete(notice_no){
        if(confirm("정말로 삭제하시겠습니까?")){ location.href="/noticeDelete?notice_no="+notice_no; }
    }
</script>
<style>
</style>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <!-- 메인 컨텐츠 -->
        <div id="content">

            <div class="container-fluid" style="width:1100px; height:750px;">
                <div class="d-sm-flex align-items-center justify-content-between mb-4"
                     style=" margin-top:50px; text-align: center; ">
                    <h1 class="h3 mb-0 text-gray-800 text-truncate" style="font-weight:bold;">&nbsp;&nbsp; ${noticeDetail.notice_title }</h1>
                    <div>
                        <button class="detailBtn boardList" onclick="location.href='/notice'">목록</button>
                    </div><!--search-->
                </div>
                <!--수정할 부분 시작-->
                <div class="detailBox">
                    <div class="detailTop">
                        <div class="detailTop_item"><input type="hidden" id="detailWriter">${noticeDetail.admin_name }</div>
                        <div class="detailTop_item">${noticeDetail.notice_date }</div>
                    </div>
                    <div class="detailMid">
                        <div class="detailMid_item">${noticeDetail.notice_content }</div>
                    </div>
                    <div class="btnBox">
                        <div class="btnBox_1">
                                <button class="detailBtn" style="background-color: #3dcc00; width:100px;" id="thumsUp">
                                    <img src="/img/thumbs-up.png" style="margin-bottom: 5px; width:25px; height:25px;">
                                    (${noticeDetail.notice_like })
                                </button>
                        </div>
                        <div class="btnBox_2">
                                <button class="detailBtn" style="background-color: #ffc414;"
                                        onclick="noticeUpdate(${noticeDetail.notice_no })">수정
                                </button>
                                <button class="detailBtn" style="background-color: #ff3d3d;"
                                        onclick="noticeDelete(${noticeDetail.notice_no })">삭제
                                </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--수정할 부분 끝-->
    </div>
</div><!-- End of Main Content -->
</div><!-- End of Content Wrapper -->
</div> <!-- End of Page Wrapper -->
</body>
</html>
