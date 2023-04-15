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
    <%-- API Key값 --%>
    <script src="js/apikey.js"></script>
</head>
<script>
    $(function () {
        // 로딩창 보여주기
        $('#loading').show();

        let studentNo = 131;
        let playlistId = "${playlistId}";

        $.get({
            url: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=" + playlistId + "&key=" + API_KEY,
            dataType: "json",
            success: function (playlistItems) {
                /* 플레이리스트에 있는 동영상 각각의 정보 */
                let playlist = playlistItems.items;

                for (var i = 0; i < playlist.length; i++) {
                    /* 동영상 썸네일 이미지 URL, 제목, 동영상 URL, 동영상 총 재생시간, DB 저장된 재생시간, 썸네일 사용 총 재생시간 */
                    let videoThumnails = playlist[i].snippet.thumbnails.medium.url
                    let videoTitle = playlist[i].snippet.title;
                    let videoId = playlist[i].snippet.resourceId.videoId;
                    let videoDuration = "";
                    let videoPlayTime = 0;
                    let videoTotalTime = "";

                    /* 동영상의 재생시간 가져오기 */
                    $.get({
                        url: "https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails&id=" + videoId + "&key=" + API_KEY,
                        dataType: "json",
                        success: function (video) {
                            /* 유튜브 API 제공하는 총 재생시간 ISO 8601 형식 */
                            videoDuration = video.items[0].contentDetails.duration;
                            /* moment.js 라이브러리를 사용하여 ISO 8601 형식 duration 객체로 변환 */
                            let totalTime = moment.duration(videoDuration).asSeconds();
                            /* ISO 8601 형식 썸네일 표시 위해 M:S 형태로 교체 */
                            videoTotalTime = durationToTotalTime(videoDuration);

                            /* 1번 포인트 */
                            console.log(videoId + "1st : " + totalTime);

                            /* 실제 사용자에게 보여주기 위해 append 처리할 <tr> 생성 */
                            let $tr = $("<tr onclick=location.href='lectureDetail?video_id=" + videoId + "'>");
                            $tr.append("<td><div class='video-thumnails'><img class='video-img' src='" + videoThumnails + "'><span class='total-time'>" + videoTotalTime + "</span></div></td>");
                            $tr.append("<td><span>" + videoTitle + "(" + videoId + ")</span></td>");
                            $tr.append("<th><input class='chk-lecture' type='checkbox' checked onclick='return false;'></th>");
                            $("#tb_lecture").append($tr);
                            $("#loading").hide();
                        },
                        error: function () {
                            $("#loading").hide();
                            alert("유튜브 동영상 정보를 불러오는 도중 에러가 발생했습니다.");
                        }
                    });
                } /* 반복문 종료 */
            },
            error: function () {
                $("#loading").hide();
                alert("유튜브 플레이리스트를 불러오는 도중 에러가 발생했습니다.");
            }
        });
    });

    /* ISO 8601 형식을 썸네일 표시 위해 M:S 형태로 교체 */
    function durationToTotalTime(videoDuration) {
        videoDuration = videoDuration.replace("PT", "");
        videoDuration = videoDuration.replace("H", "시간 ");
        videoDuration = videoDuration.replace("M", "분 ");
        videoDuration = videoDuration.replace("S", "초");

        return videoDuration;
    }
</script>
<style>
    #loading {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: white;
        z-index: 9999;
    }

    .spinner {
        position: absolute;
        top: 50%;
        left: 50%;
        margin-top: -50px;
        margin-left: -50px;
        width: 40px;
        height: 40px;
        border: 10px solid #fff;
        border-radius: 50%;
        border-top-color: red;
        animation: spin 1s ease-in-out infinite;
    }

    @keyframes spin {
        to {
            transform: rotate(360deg);
        }
    }

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
</style>
<body id="page-top">
<div id="loading">
    <div class="spinner"></div>
</div>
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
                                    <table class="table table-sm" id="table_lecture">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="col-2">강의 이미지</th>
                                                <th class="col-9">제목[강의자료]</th>
                                                <th class="col-1">출석여부</th>
                                            </tr>
                                        </thead>
                                        <tbody class="table-group-divider" id="tb_lecture">
                                        <!-- 강의 정보 추가 위치 -->
                                        </tbody>
                                    </table>
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