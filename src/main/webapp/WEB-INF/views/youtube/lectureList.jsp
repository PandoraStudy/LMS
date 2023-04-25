<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Pandora University - LMS</title>
    <%-- ISO 8601 변환 시 사용하기 위한 라이브러리 --%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
          rel="stylesheet">
    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <link href="css/logo.css" rel="stylesheet">
</head>
<script>
    $(function() {
        $(".week-select").click(function() {
            $(this).children(".fas").toggleClass("fa-chevron-down fa-chevron-up");
        });


    $(".mthd").click(function() {
            let url = $(this).attr("value");

            if(url == "" || url == null) {
                alert("회의가 개설되지 않았습니다.\n잠시 후 다시 시도해주세요.");
            } else {
                alert("해당 URL로 이동 합니다 : " + url);
            }


        });
    });
</script>
<style>
    .video-thumnails {
        position: relative;
        width: 160px;
        height: 100px;
        background-color: #cccccc;
    }

    .video-img {
        width: 160px;
        height: 100px;
    }

    .total-time {
        position: absolute;
        bottom: 0;
        right: 0;
        border-radius: 5px;
        padding: 2px;
        margin: 0 3px 3px 0;
        box-sizing: border-box;
        color: white;
        background-color: black;
    }

    .week {
        width: 100%;
        height: 40px;
        background-color: #ccc;
    }
</style>
<body id="page-top">
<!-- Page Wrapper -->
<div id="wrapper">

    <%-- 네비게이션 바 --%>
    <%@include file="../navbar.jsp" %>

    <!-- 콘텐츠 전체 감싸기 -->
    <div id="content-wrapper" class="d-flex flex-column">
        <!-- 메인 컨텐츠 -->
        <div id="content">
            <%-- 탑 바 --%>
            <%@include file="../top.jsp" %>

            <!-- 본문 컨텐츠 부분 시작 -->
            <div class="container-fluid">

                <!-- 메인 페이지의 탑 -->
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800">내 강의실</h1>
                    <%--                        <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> 이건무슨 버튼으로 쓸까</a>--%>
                </div>

                <div class="row">
                    <!-- A카드 게시판 -->
                    <div class="col-xl-12 col-lg-7">
                        <div class="card shadow mb-4">
                            <!-- A 카드 설정 버튼 부분 -->
                            <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-primary">과목명</h6>
                                <div class="dropdown no-arrow">
                                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                         aria-labelledby="dropdownMenuLink">
                                        <div class="dropdown-header">더보기</div>
                                        <a class="dropdown-item" href="#">추가 메뉴</a>
                                    </div>
                                </div>
                            </div>
                            <!-- A 본문 부분 -->
                            <div class="card-body">
                                <div>
                                    <!-- 실제 구성은 이곳에서 진행합니다. -->
                                        <!-- 강의 정보 추가 위치 -->
                                    <c:set var="i" value="1"/>
                                        <c:forEach items="${lectList}" var="lect">
                                            <div class="week">
                                                <div class="week-select form-control" data-toggle="collapse" data-target="#lect${i}">
                                                    <i class="fas fa-chevron-down" value="down${i}"></i> <!-- 처음에는 아래 방향 화살표 아이콘 사용 -->
                                                    ${i}주차
                                                </div>
                                            </div>
                                            <div id="lect${i}" class="collapse">
                                                <!-- 숨길 객체의 내용 -->
                                                <div>
                                                    <button class="mthd btn <c:choose><c:when test="${lect.SBJCT_MTHD_CD eq 1}">btn-danger</c:when><c:otherwise>btn-primary</c:otherwise></c:choose>" value="${lect.LECT_URL}"><c:choose><c:when test="${lect.SBJCT_MTHD_CD eq 1}">유튜브</c:when><c:otherwise>줌수업</c:otherwise></c:choose></button></td>
                                                    <span>${lect.ON_LECT_NM }</span>
                                                </div>
                                            </div>
                                            <c:set var="i" value="${i + 1}"/>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 디테일 화면 종료 -->
        </div>
        <!-- 메인 콘텐츠 종료 -->

        <!-- Footer -->
        <%@include file="../footer.jsp" %>

    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

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