<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Notice List</title>
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
<style>

</style>
<script>
    function check() {
        let writeTitle = document.getElementById("writeTitle");
        let writeContent = document.getElementById("writeContent");
        if (writeTitle.value == "") {
            alert("제목을 입력해주세요");
            writeTitle.focus();
            return false;
        }
        if (writeContent.value == "") {
            alert("내용을 입력해주세요");
            writeContent.focus();
            return false;
        }

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
            <!-- 본문 컨텐츠 부분 시작 -->
            <div class="container-fluid" style="width:1100px; height:750px;">
                <div class="d-sm-flex align-items-center justify-content-between mb-4" style=" margin-top:50px; text-align: center;">
                    <!--수정할 부분 시작-->
                    <h1 class="h3 mb-0 text-gray-800 text-truncate" style="font-weight:bold;">
                        <c:choose>
                            <c:when test="${noticeDetail.notice_no ne null }"> 공지사항 수정 </c:when>
                            <c:otherwise> 신규 글쓰기 </c:otherwise>
                        </c:choose>
                    </h1>
                    <div>
                        <button class="detailBtn boardList" onclick="location.href='/notice'">목록</button>
                    </div><!--search-->
                </div>
                <div class="writeBox">
                    <form action=
                    <c:choose>
                            <c:when test="${noticeDetail.notice_no ne null }">"/noticeWrite?notice_no=${noticeDetail.notice_no}"</c:when>
                            <c:otherwise>"/noticeWrite"</c:otherwise>
                    </c:choose>
                    method="post" onsubmit="return check()" enctype="multipart/form-data">
                    <input type="text" name="writeTitle" id="writeTitle" class="writeTitle" placeholder="제목을 입력하세요" maxlength="100" <c:if test="${noticeDetail.notice_title ne null }">value="${ noticeDetail.notice_title }"</c:if>>
                    <textarea name="writeContent" id="writeContent"	class="writeContent" placeholder="내용을 입력하세요"><c:if test="${noticeDetail.notice_content ne null }">${ noticeDetail.notice_content }</c:if></textarea>
                    <div class="btnBox">
                        <button class="writeBtn">
                            <c:choose>
                                <c:when test="${noticeDetail.notice_no ne null }">수정</c:when>
                                <c:otherwise>저장</c:otherwise>
                            </c:choose>
                        </button>
                    </div>
                    </form>
                </div>
                <!--수정할 부분 끝-->
            </div>
        </div><!-- End of Main Content -->
    </div><!-- End of Content Wrapper -->
</div> <!-- End of Page Wrapper -->
</body>
</html>
