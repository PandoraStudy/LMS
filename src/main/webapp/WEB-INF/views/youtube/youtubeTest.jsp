<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 화면</title>
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
    function onYouTubeIframeAPIReady() {
        player = new YT.Player('youtube-player', {
            videoId: 'cKOWZPWLeaQ',
            playerVars: {
                rel : 0,
                control : 0,
            },
            events: {
                'onReady': onPlayerReady,
                'onStateChange': onPlayerStateChange
            }
        });
    }

    function onPlayerReady(event) {     /* iframe 준비 완료 상태 */
        event.target.playVideo();
        console.log("플레이어 (iframe) 준비 완료");
    }

    /* 초 단위로 읽어서 원래 위치로 옮기는 로직 구성 */
    let timer = null;
    /* 실제 동영상 재생 시간 위치 */
    let curr_time = 0;

    var count = 0;
    function checkVideoTime() {
        count += 1;
        curr_time = Math.floor(player.getCurrentTime());
        console.log("[재생] 재생 위치 : " + curr_time + "초");
        if( (count % 10) == 0 ) console.log("시청 위치 저장!");
    }

    function onPlayerStateChange(event) {   /* 플레이어 상태 변화 */
        if (event.data === YT.PlayerState.BUFFERING) {  /* 동영상 버퍼링 상태 */
            console.log("동영상 버퍼링");
        }

        if (event.data === YT.PlayerState.PLAYING) {    /* 동영상 재생 상태 */
            /* 학생이 실제 시청 시간 위치 */
            let student_time = 300;

            console.log("동영상 재생");
            console.log("[재생] 저장된 시간 : " + student_time);

            curr_time = Math.floor(player.getCurrentTime());

            if(curr_time > student_time) {
                alert("앞의 수업을 듣고 보세요.");
                player.seekTo(student_time, true);
            }

            if(timer == null) {
                timer = setInterval(checkVideoTime, 1000);
            }
        }

        if (event.data === YT.PlayerState.PAUSED) {     /* 동영상 일시정지 상태 */
            curr_time = Math.floor(player.getCurrentTime());

            console.log("동영상 일시 정지");
            console.log("[일시정지] 실시간 재생 위치 : " + curr_time + "초");
            student_time = curr_time;
            clearInterval(timer);
            timer = null;
        }

        if (event.data === YT.PlayerState.ENDED) {      /* 동영상 종료 상태 */
            console.log("동영상 종료");
            timer = null;
        }
    }
</script>
</body>
</html>
<body>
    <div style="width: 1280px; height: 720px; background-color: #ccc;" id="youtube-player"></div>

    <br>

    동영상 프레임 준비
    버퍼링
    재생

    재생 중 시간 이동 순서
    일시정지, 버퍼링, 재생

    일시정지 중 시간 이동 순서


    <button type="button" id="test_btn">위치로</button>

    <h1>테스트 화면 입니다.</h1>

    <a href="/zoom">줌</a>
</body>
</html>
