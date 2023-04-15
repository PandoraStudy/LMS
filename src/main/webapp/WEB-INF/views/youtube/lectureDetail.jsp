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
    /* createElement를 사용해서 html이 로드되면 <script><script> 태그를 생성 */
    var tag = document.createElement('script');

    /* 만들어진 태그 유튜브 API가 정상적으로 동작할 시 <div id='player'> 안에 iframe을 삽입 준비 */
    tag.src = "https://www.youtube.com/iframe_api";

    /* 위에 선언된 var tag를 가장 첫번째 <script>로 인식 시키기 위한 코드 */
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    /* 학생 구분용 임시 번호 */
    let student_no = 131;
    /* 유튜브 동영상 iframe 생성 객체, 그 안에 실행될 동영상 정보를 가져오고 상태 변화에 따른 이벤트를 발생 시킴 */
    var player;
    /* 인터벌 사용하기 위한 변수 선언 */
    let timer = null;
    /* 실제 동영상 재생 시간 위치 */
    let curr_time = 0;
    /* 동영상 주소 */
    let video_id = "${videoId}";
    /* 학생이 실제 시청 시간 위치 */
    let play_time = ${playTime};

    /* 유튜브 Iframe 준비 상태 */
    function onYouTubeIframeAPIReady() {
        player = new YT.Player('youtubePlayer', {
            videoId: video_id,
            playerVars: {
                rel: 0,
                controls: 1,
                start: play_time
            },
            events: {
                'onReady': onPlayerReady,
                'onStateChange': onPlayerStateChange
            }
        });
    }

    /* iframe 준비 완료 상태 */
    function onPlayerReady(event) {
        console.log("플레이어 (iframe) 준비 완료");
    }

    /* 플레이어 상태 변화 */
    function onPlayerStateChange(event) {

        /* 동영상 버퍼링 상태 */
        if (event.data === YT.PlayerState.BUFFERING) {
            console.log("동영상 버퍼링");
        }

        if (event.data === YT.PlayerState.CUED) {
            alert("비디오 로드 완료");
        }

        /* 동영상 재생 상태 */
        if (event.data === YT.PlayerState.PLAYING) {
            getPlayTime();
            curr_time = Math.floor(player.getCurrentTime());

            /* 실시간 재생 시간과 저장된 재생 시간의 차이가 5보다 클 경우 저장된 위치로 옮깁니다. */
            if ((curr_time - play_time) > 3) {
                player.seekTo(play_time);
            }

            /* 초마다 재생 시간을 검사합니다 */
            if (timer == null) {
                timer = setInterval(checkVideoTime, 1000);
            }
        }

        /* 동영상 일시정지 상태 */
        if (event.data === YT.PlayerState.PAUSED) {
            getPlayTime();
            curr_time = Math.floor(player.getCurrentTime());

            /*
                재생 시간이 저장된 재생 시간보다 클 경우 실행합니다.
            */
            if (curr_time > play_time) {
                /* 실시간 재생 위치와 데이터베이스에 등록된 값의 차이가 5초 이하일 경우는 정상 */
                if ((curr_time - play_time) <= 5) {
                    console.log("일시정지로 저장");
                    playTimeSave();
                }
                /* 실시간 재생 위치와 데이터베이스에 등록된 값의 차이가 5초 초과일 경우 비정상 */
                else {
                    player.seekTo(play_time);
                }
            }

            /* 반복되는 인터벌을 클리어 합니다. */
            clearInterval(timer);
            timer = null;
        }

        /* 동영상 종료 상태 */
        if (event.data === YT.PlayerState.ENDED) {
            timer = null;
        }
    }

    /* 초 단위로 재생 위치를 알아옵니다. */
    var count = 0;

    function checkVideoTime() {
        count += 1;
        curr_time = Math.floor(player.getCurrentTime());

        /* 재생 위치를 5초마다 저장합니다. */
        if ((count % 5) == 0) {
            /* 실시간 재생 위치가 저장된 재생 위치 값보다 클 경우 실행합니다. */
            if (curr_time > play_time) {
                console.log("5초마다 저장")
                playTimeSave();
            }
        }
    }

    /* 학생의 해당되는 강의에 저장돤 재생 시간을 가져옵니다. */
    function getPlayTime() {
        $(function () {
            $.ajax({
                type: "POST",
                url: "/getPlayTime",
                data: {"video_id": video_id, "student_no": student_no},
                dataType: "text",
                success: function (playTime) {
                    console.log("[getPlayTime] " + playTime + "초");
                    play_time = playTime;
                },
                error: function () {
                    alert("저장된 재생 시간을 불러오지 못했습니다.");
                }
            });
        });
    }

    /* 재생 시간을 저장합니다. */
    function playTimeSave() {
        $(function () {
            $.ajax({
                type: "POST",
                url: "/playTimeSave",
                data: {"video_id": video_id, "curr_time": curr_time, "student_no": student_no},
                dataType: "text",
                success: function (result) {
                    console.log("[playTimeSave] " + result);
                },
                error: function () {
                    alert("재생 시간을 저장하지 못했습니다.");
                }
            });
        });
    }
</script>
<style>
    .card-body {
        height: 900px;
    }

    .lecture-content {
        justify-content: center;
        width: 100%;
        height: 85%;
    }

    .youtube-player {
        width: 100%;
        height: 100%;
    }

    .lecture-info {
        display: block;
        width: 100%;
        height: 16%;
    }

    .lecture-progress {
        display: block;
        width: 100%;
        height: 50%;
    }

    .lecture-progress > span {
        display: block;
        width: 100%;
        height: 100%;
        text-align: center;
        padding-top: 10px;
        box-sizing: border-box;
    }

    .lecture-page-btn {
        display: block;
        width: 100%;
        height: 50%;
    }

    .lecture-page-btn > span {
        display: block;
        width: 100%;
        height: 100%;
        text-align: right;
        padding-top: 10px;
        box-sizing: border-box;
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
            <!-- 본문 컨텐츠 부분 시작 -->
            <div class="container-fluid">

                <!-- 메인 페이지의 탑 -->
                <div class="d-sm-flex align-items-center justify-content-between mt-4 mb-4">
                    <h1 class="h3 mb-0 text-gray-800">내 강의실</h1>
                    <%--                        <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> 이건무슨 버튼으로 쓸까</a>--%>
                </div>

                <div class="row">
                    <!-- A카드 게시판 -->
                    <div class="col-xl-10 col-lg-7">
                        <div class="card shadow mb-4">
                            <!-- A 카드 설정 버튼 부분 -->
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
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
                                <div class="lecture-content">
                                    <!-- 실제 구성은 이곳에서 진행합니다. -->
                                    <div class="youtube-player" id="youtubePlayer"></div>
                                    <div class="lecture-info">
                                        <div class="lecture-progress">
                                            <span>
                                                <span>학습 진행 상황 : 8분 4초(100%)</span>
                                                <span>
                                                    <input type="checkbox" checked onclick="return false;">
                                                    <result>완료</result>
                                                    <button class="btn btn-primary" type="button">출석</button>
                                                </span>
                                            </span>

                                        </div>
                                        <div class="lecture-page-btn">
                                            <span>
                                                <!-- 강의 진도율이 100프로가 아닐 시 제어합시다. -->
                                                <button class="btn btn-secondary">이전 학습</button>
                                                <button class="btn btn-primary">다음 학습</button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 동영상 본문 사이드 메뉴 -->
                    <div class="col-xl-2">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-primary">강의 목록</h6>
                            </div>
                            <div class="card-body" style="height: auto;">
                                test
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