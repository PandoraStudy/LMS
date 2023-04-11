<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>유튜브 테스트 화면</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<!DOCTYPE html>
<html>
<body>
<script>
        /* createElement를 사용해서 html이 로드되면 <script><script> 태그를 생성 */
        var tag = document.createElement('script');

        /* 만들어진 태그 유튜브 API가 정상적으로 동작할 시 <div id='player'> 안에 iframe을 삽입 준비 */
        tag.src = "https://www.youtube.com/iframe_api";

        /* 위에 선언된 var tag를 가장 첫번째 <script>로 인식 시키기 위한 코드 */
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

        /* 유튜브 동영상 iframe 생성 객체, 그 안에 실행될 동영상 정보를 가져오고 상태 변화에 따른 이벤트를 발생 시킴 */
        var player;

        /* 유튜브 Iframe 준비 상태 */
        function onYouTubeIframeAPIReady() {
            player = new YT.Player('youtube-player', {
                videoId: 'zml76nYyHEo',
                playerVars: {
                    rel: 0,
                    control: 0,
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

            /* 저장돤 재생 위치값을 보고 0이 아닐 경우 해당 위치에서 시작합니다. */
            getStudentTime();
            if(student_time != 0) {
                player.seekTo(student_time);
            }
        }

        /* 인터벌 사용하기 위한 변수 선언 */
        let timer = null;
        /* 실제 동영상 재생 시간 위치 */
        let curr_time = 0;
        /* 학생이 실제 시청 시간 위치 */
        let student_time = ${student_time};

        /* 플레이어 상태 변화 */
        function onPlayerStateChange(event) {

            /* 동영상 버퍼링 상태 */
            if (event.data === YT.PlayerState.BUFFERING) {
                console.log("동영상 버퍼링");
            }

            /* 동영상 재생 상태 */
            if (event.data === YT.PlayerState.PLAYING) {
                getStudentTime();
                curr_time = Math.floor(player.getCurrentTime());

                /* 실시간 재생 시간과 저장된 재생 시간의 차이가 5보다 클 경우 저장된 위치로 옮깁니다. */
                if ((curr_time - student_time) > 5) {
                    player.seekTo(student_time);
                }

                /* 초마다 재생 시간을 검사합니다 */
                if (timer == null) {
                    timer = setInterval(checkVideoTime, 1000);
                }
            }

            /* 동영상 일시정지 상태 */
            if (event.data === YT.PlayerState.PAUSED) {
                getStudentTime();
                curr_time = Math.floor(player.getCurrentTime());

                /*
                    재생 시간이 저장된 재생 시간보다 클 경우 실행합니다.
                */
                if(curr_time > student_time) {
                    /* 실시간 재생 위치와 데이터베이스에 등록된 값의 차이가 5초 이하일 경우는 정상 */
                    if ((curr_time - student_time) <= 5) {
                        studentTimeSave();
                    }
                    /* 실시간 재생 위치와 데이터베이스에 등록된 값의 차이가 5초 초과일 경우 비정상 */
                    else {
                        player.seekTo(student_time);
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
            if ((count % 5) == 0){
                /* 실시간 재생 위치가 저장된 재생 위치 값보다 클 경우 실행합니다. */
                if(curr_time > student_time) {
                    studentTimeSave();
                }
            }
        }

        /* 학생의 해당되는 강의에 저장돤 재생 시간을 가져옵니다. */
        function getStudentTime() {
            $(function() {
                $.post({
                    url: "/getStudentTime",
                    dataType : "text",
                    success : function(result) {
                        student_time = result;
                    }
                });
            });
        }

        /* 재생 시간을 저장합니다. */
        function studentTimeSave() {
            $(function() {
                $.post({
                    url : "/studentTimeSave",
                    data : { "curr_time" : curr_time },
                    dataType : "text",
                    success : function(result) {
                        console.log(result);
                    }
                }) ;
            });
        }
</script>
</body>
</html>
<body>
<div style="width: 1280px; height: 720px; background-color: #ccc;" id="youtube-player"></div>
<br>
<button type="button" id="test_btn">위치로</button>
<br>
<h1>
    총 재생시간 : console.log("동영상 총 재생 시간 : " + player.getDuration()); <br>
    할 일<br>
    1. 추천 영상 및 추가 동영상이 나오기 전에 동영상을 끝내기 <br>
    2. 리스트 별로 강의 리스트 출력 후 해당 강의 클릭 시 클릭된 강의 디테일 보여주기
</h1>
</body>
</html>
