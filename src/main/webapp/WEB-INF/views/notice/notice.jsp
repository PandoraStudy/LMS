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
    function moveNext(pageNo) {	//페이지 뒤쪽 버튼
        let searchType = document.getElementById("searchType");
        let searchValue = document.getElementById("searchValue");
        let url = document.location.href.split("?", 1);

        if (pageNo > ${pages.lastPage }) {
            return false;
        } else if (pageNo != ${pages.lastPage }) {

            if ((searchType.value != null && searchType.value != "none") && searchValue.value != null) {
                location.href = url + "?searchType=" + searchType.value + "&searchValue=" + searchValue.value + "&pageNo=" + (pageNo + 1);
            } else {
                location.href = "/notice?pageNo=" + (pageNo + 1);
            }

        } else if (pageNo == ${pages.lastPage }) {

            if ((searchType.value != null && searchType.value != "none") && searchValue.value != null) {
                location.href = url + "?searchType=" + searchType.value + "&searchValue=" + searchValue.value + "&pageNo=" + pageNo;
            } else {
                location.href = "/notice?pageNo=" + pageNo;
            }
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
                    <h1 class="h3 mb-0 text-gray-800" style="font-weight:bold;">공지사항</h1>
                    <div>
                        <form action="" method="get" onsubmit="return search()">
                            <select name="searchType" id="searchType">
                                <option value="none">선택</option>
                                <option value="title" <c:if test='${ pages.searchType eq "title"}'>selected</c:if>>제목
                                </option>
                                <option value="writer" <c:if test='${ pages.searchType eq "writer"}'>selected</c:if>>
                                    글쓴이
                                </option>
                            </select>
                            <input type="text" name="searchValue" id="searchValue" value="${pages.searchValue }">
                            <button class="search_btn">검색</button>
                        </form>
                    </div><!--search-->
                </div>
                <div>
                    <table class="table">
                        <tr class="table_header">
                            <td class="col-1" style="text-align: center;">번호</td>
                            <td class="col-6" style="text-align: center;">제목</td>
                            <td class="col-1" style="text-align: center;">작성자</td>
                            <td class="col-1" style="text-align: center;">조회수</td>
                            <td class="col-3" style="text-align: center;">등록일</td>
                        </tr>
                        <c:forEach var="notice" items="${list }">
                            <c:if test="${notice.rowNum eq null }" > 일치하는 값이 없습니다. </c:if>
                            <tr>
                                <td>${notice.rowNum }</td>
                                <td class="title text-truncate" style="max-width:1px; text-align: left;"><a
                                        href="/noticeDetail?notice_no=${notice.notice_no }">${notice.notice_title }</a>
                                </td>
                                <td>${notice.admin_name}</td>
                                <td>${notice.notice_read }</td>
                                <td>${notice.notice_date }</td>
                            </tr>
                        </c:forEach>
                    </table>
                    <br><br>
                </div><!-- table end -->
                <!--페이징 -->
                <div class="pagingBox">
                    <ul class="pagingList">
                        <li class="pageNo page_btn" onclick="moveBefore(1)"><i class="xi-backward xi-x"></i></li>
                        <li class="pageNo page_btn" onclick="moveBefore(${pageNo})"><i
                                class="xi-step-backward xi-x"></i></li>
                        <c:forEach var="i" begin="${Math.floor((pageNo-1)/10)*10+1 }"
                                   end="${Math.floor((pageNo-1)/10)*10 +10 gt pages.lastPage ? pages.lastPage : Math.floor((pageNo-1)/10)*10 +10}">
                            <li class="pageNo" onclick="move(${i })"
                                <c:if test="${pageNo eq i }">style="color:red; font-weight: bold;"</c:if>>${i }</li>
                        </c:forEach>
                        <li class="pageNo page_btn" onclick="moveNext(${pageNo})"><i class="xi-step-forward xi-x"></i>
                        </li>
                        <li class="pageNo page_btn" onclick="moveNext(${pages.lastPage })"><i
                                class="xi-forward xi-x"></i></li>
                    </ul>
                </div><!--paging end-->
                <!--수정할 부분 끝-->
            </div>
        </div><!-- End of Main Content -->
    </div><!-- End of Content Wrapper -->
</div> <!-- End of Page Wrapper -->
</body>
</html>
