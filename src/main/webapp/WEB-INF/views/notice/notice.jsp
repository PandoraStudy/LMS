<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Notice</title>
    <script type="text/javascript" src="/js/NoticePaging.js"></script>
    <script type="text/javascript" src="/js/search.js"></script>
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
<script>
    function moveNext(pageNo){	//페이지 뒤쪽 버튼
        let searchType = document.getElementById("searchType");
        let searchValue = document.getElementById("searchValue");
        let url =  document.location.href.split("?",1);

        if(pageNo > ${pages.lastPage } ) { return false; }
        else if (pageNo != ${pages.lastPage } ){

            if((searchType.value != null && searchType.value != "none") && searchValue.value != null){
                location.href=url+"?searchType="+ searchType.value+"&searchValue="+searchValue.value+"&pageNo="+(pageNo+1);
            }else{
                location.href="/notice?pageNo="+(pageNo+1);
            }

        }else if(pageNo == ${pages.lastPage }){

            if((searchType.value != null && searchType.value != "none") && searchValue.value != null){
                location.href=url+"?searchType="+ searchType.value+"&searchValue="+searchValue.value+"&pageNo="+pageNo;
            }else{
                location.href="/notice?pageNo="+pageNo;
            }
        }
    }


</script>
<style>
    .table_header{
        border-top:1px solid black;
        border-bottom:1px solid black;
        font-size: 17px;
        font-weight: bold;
    }

</style>
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
            <div class="container-fluid" style="width:1000px;">
                <div class="d-sm-flex align-items-center justify-content-between mb-4" style="text-align: center;">
                    <!--수정할 부분 시작-->
                    <h1 class="h3 mb-0 text-gray-800" style="font-weight:bold; ">공지사항</h1>
                    <div class="searchForm">
                        <form action="" method="get" onsubmit="return search()">
                            <select name="searchType" id="searchType">
                                <option value="none">선택</option>
                                <option value="title" <c:if test='${ pages.searchType eq "title"}'>selected</c:if>>제목</option>
                                <option value="writer" <c:if test='${ pages.searchType eq "writer"}'>selected</c:if>>글쓴이</option>
                            </select>
                            <input type="text" name="searchValue" id="searchValue" value="${pages.searchValue }">
                            <button class="search_btn">검색</button>
                        </form>
                    </div>
                </div>
                    <div>
                        <table class="table_header">
                            <th>
                                <td class="col-1" style="text-align: center;">번호</td>
                                <td class="col-6" style="text-align: center;">제목</td>
                                <td class="col-1" style="text-align: center;">작성자</td>
                                <td class="col-1" style="text-align: center;">조회수</td>
                                <td class="col-3" style="text-align: center;">등록일</td>
                            </th>
                        </table>
                        <!--페이징 -->
                        <div class="pagingBox">
                            <ul class="pagingList">
                                <li class="pageNo page_btn" onclick="moveBefore(1)"><i class="xi-backward xi-x"></i></li>
                                <li class="pageNo page_btn" onclick="moveBefore(${pageNo})"><i class="xi-step-backward xi-x"></i></li>
                                <c:forEach var="i" begin="${Math.floor((pageNo-1)/10)*10+1 }" end="${Math.floor((pageNo-1)/10)*10 +10 gt pages.lastPage ? pages.lastPage : Math.floor((pageNo-1)/10)*10 +10}">
                                    <li class="pageNo" onclick="move(${i })" <c:if test="${pageNo eq i }" >style="color:red; font-weight: bold;"</c:if>>${i }</li>
                                </c:forEach>
                                <li class="pageNo page_btn" onclick="moveNext(${pageNo})"><i class="xi-step-forward xi-x"></i></li>
                                <li class="pageNo page_btn" onclick="moveNext(${pages.lastPage })"><i class="xi-forward xi-x"></i></li>
                            </ul>
                        </div>
                    </div>
                    <!--수정할 부분 끝-->

                </div>

            </div><!-- End of Main Content -->


            <!-- Footer -->
            <%@include file="../footer.jsp" %>

        </div><!-- End of Content Wrapper -->


    </div> <!-- End of Page Wrapper -->


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
