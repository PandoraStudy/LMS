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
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>
<script>
    $(function() {

        $(".week-select").click(function() {
            $(this).children(".fas").toggleClass("fa-chevron-down fa-chevron-up");
        });


        $(".week-content").click(function() {
                let lectureInfo = $(this).find(".mthd").val();
                let snOrUrl = lectureInfo.split(",")[0];
                let mthd = lectureInfo.split(",")[1];

                if(mthd == 1) {
                    location.href = "/lectureDetail?on_lect_sn=" + snOrUrl;
                } else {
                    // 줌 담당자에게 어디로 보낼지 전달 받아야 합니다.
                    if(snOrUrl != "") {
                        window.open(snOrUrl, "수업명", "menubar=no, toolbar=no, fullscreen=yes");
                    } else {
                        alert("아직 회의가 개설되지 않았습니다.\n잠시 후 다시 시도해주세요.");
                    }

                }
        });

    });
</script>
<style>
    .week-select {
        width: 100%;
        height: 50px;
        line-height: 50px;
        padding-left: 10px;
        box-sizing: border-box;
        border-top: 1px solid #ccc;
        border-left: 1px solid #ccc;
        border-right: 1px solid #ccc;
    }

    .select-last {
        border-bottom: 1px solid #ccc;
    }

    .week-content {
        width: 100%;
        height: auto;
        border-top: 1px solid #ccc;
        border-left: 1px solid #ccc;
        border-right: 1px solid #ccc;
        padding: 10px;
        padding-top: 17px;
        box-sizing: border-box;
        transition: 0s;
    }

    .content-last {
        border-top: 0;
        border-bottom: 1px solid #ccc;
    }

    .week-object {
        width: 100%;
        height: 40px;
    }

    .btn {
        width: 75px;
        height: 30px;
        line-height: 17px;
        margin-right: 10px;
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
                    <h1 class="h3 mb-0 text-gray-800"></h1>
                    <%--                        <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> 이건무슨 버튼으로 쓸까</a>--%>
                </div>

                <div class="row">
                    <!-- A카드 게시판 -->
                    <div class="col-xl-12 col-lg-7">
                        <div class="card shadow mb-4">
                            <!-- 강의 본문 부분 -->
                            <div class="card-body border-left-primary">
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${lectList[0].SBJCT_NM} 공지사항</div><br>
                                <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <td class="col-1">번호</td>
                                            <td class="col-4">제목</td>
                                            <td class="col-2">작성자</td>
                                            <td class="col-2">조회수</td>
                                            <td class="col-2">등록일</td>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td class="title text-truncate" style="max-width:1px; text-align: left;">T1tle</td>
                                            <td>INSTR01</td>
                                            <td>11</td>
                                            <td>10:33</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- A카드 게시판 -->
                    <div class="col-xl-12 col-lg-7">
                        <div class="card shadow mb-4">
                            <!-- A 카드 설정 버튼 부분 -->
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-primary">강의</h6>
                            </div>
                            <!-- 강의 본문 부분 -->
                            <div class="card-body">
                                <div>
                                    <!-- 강의 정보 추가 위치 -->
                                    <c:set var="i" value="1"/>
                                        <c:forEach items="${lectList}" var="lect" varStatus="status">
                                        <div class="week-select ${status.last ? 'select-last' : ''}" data-toggle="collapse" data-target="#lect${i}">
                                            <i class="fas fa-chevron-down"></i> ${i}주차
                                        </div>
                                        <!-- 콘텐츠 -->
                                        <div id="lect${i}" class="week-content ${status.last ? 'content-last' : ''} <c:choose><c:when test="${lect.SBJCT_MTHD_CD eq 1}">border-left-danger</c:when><c:otherwise>border-left-primary</c:otherwise></c:choose> collapse">
                                            <!-- 숨길 객체의 내용 -->
                                            <div class="week-object">
                                                <div class="week-title" style="width: 50%; height: 30px; padding-top: 2px; box-sizing: border-box; float: left;">
                                                    <button class="mthd btn <c:choose><c:when test="${lect.SBJCT_MTHD_CD eq 1}">btn-danger</c:when><c:otherwise>btn-primary</c:otherwise></c:choose>" value="<c:choose><c:when test="${lect.SBJCT_MTHD_CD eq 1}">${lect.ON_LECT_SN }</c:when><c:otherwise>${lect.LECT_URL}</c:otherwise></c:choose>,${lect.SBJCT_MTHD_CD}"><c:choose><c:when test="${lect.SBJCT_MTHD_CD eq 1}">유튜브</c:when><c:otherwise>줌수업</c:otherwise></c:choose></button>
                                                    <span>${lect.ON_LECT_NM }</span>
                                                </div>
                                                <div style="width: 50%; padding-top: 5px; box-sizing: border-box; height: 30px; float: left; line-height: 30px; display: flex; justify-content: right;">
                                                    <c:choose><c:when test="${lect.SBJCT_MTHD_CD eq 1}"><div style="margin-right: 10px;">진행률</div>
                                                    <div class='progress mb-4' style='height:15px; width: 200px; margin:5px 45px 24px 0;'><div class='progress-bar bg-primary' role='progressbar' style='height:20px; width: ${lect.LECT_PRGRS_RT}%;' aria-valuenow='20' aria-valuemin='0' aria-valuemax='100'></div></div></c:when><c:otherwise><div style='height:15px; width: 200px; margin-top: -3px;'><b>${lect.ATTENDANCE}</b></div></c:otherwise></c:choose>
                                                </div>
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