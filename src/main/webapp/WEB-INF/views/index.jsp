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
    let curr_time = null;

    function checkVideoTime() {
        console.log("[재생] 재생 위치 : " + player.getCurrentTime());
        curr_time = player.getCurrentTime();
    }

    function onPlayerStateChange(event) {   /* 플레이어 상태 변화 */
        if (event.data === YT.PlayerState.BUFFERING) {  /* 동영상 버퍼링 상태 */
            console.log("동영상 버퍼링");
        }

        if(event.data === YT.PlayerState.CUED) {        /* 동영상 재생 준비 완료 상태 */
            console.log("동영상 재생 준비 완료");
        }

        if (event.data === YT.PlayerState.PLAYING) {    /* 동영상 재생 상태 */
            console.log("동영상 재생");
            /* 동영상의 일시정지 상황 시 재생 위치 저장 */
            if(timer == null) {
                timer = setInterval(checkVideoTime, 1000);
            }
        }

        if (event.data === YT.PlayerState.PAUSED) {     /* 동영상 일시정지 상태 */
            console.log("동영상 일시 정지");
            player.seekTo(curr_time);
            clearInterval(timer);
            timer = null;
            /* 동영상의 일시정지 상황 시 재생 위치 저장 */
            console.log("[일시정지] 재생 위치 : " + player.getCurrentTime());
        }

        if (event.data === YT.PlayerState.ENDED) {      /* 동영상 종료 상태 */
            console.log("동영상 종료");
            timer = null;
        }
    }

    $(function() {
        $("#test_btn").click(function() {
            /* 지정된 재생 위치로 돌려보내는 기능, true : 지정된 위치 이후로 영상 재생 가능, false : 불가능 */
            player.seekTo(curr_time, false);
            player.pauseVideo();
        });
    })

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
