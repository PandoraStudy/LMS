<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>YouTube</title>
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
                disablekb : 1,
                modestbranding : 1
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

    let curr_time = 0;

    function onPlayerStateChange(event) {   /* 플레이어 상태 변화 */

        if (event.data === YT.PlayerState.PLAYING) {    /* 동영상 재생 상태 */
            console.log("동영상 재생");
        }
        if (event.data === YT.PlayerState.ENDED) {      /* 동영상 종료 상태 */
            console.log("동영상 종료");
        }
        if (event.data === YT.PlayerState.PAUSED) {     /* 동영상 일시정지 상태 */
            // 초 단위로 읽어서 원래 위치로 옮기는 로직 구성
            console.log("동영상 일시 정지");

            /* 동영상의 일시정지 상황 시 재생 위치 저장 */
            curr_time = player.getCurrentTime();
            console.log("재생 위치 : " + curr_time);
        }
        if(event.data === YT.PlayerState.CUED) {        /* 동영상 재생 준비 완료 상태 */
            console.log("동영상 재생 준비 완료");
        }
        if (event.data === YT.PlayerState.BUFFERING) {  /* 동영상 버퍼링 상태 */
            console.log("동영상 버퍼링");
        }
        
        
    }

    function stopVideo() {
        /* 동영상 일시정지 함수 */
        player.stopVideo();
    }

    $(function() {
        $("#test_btn").click(function() {
            /* 지정된 재생 위치로 돌려보내는 기능 */
            	
        });
    })
    
$(function() {
	var timer;
	var startTime, pauseTime = 0, elapsedTime = 0, isPaused = false;

	$("#StartBtn").click(function() {
		startTime = Date.now() - elapsedTime;
		timer = setInterval(function() {
			if (!isPaused) {
				var currentTime = (Date.now() - startTime) / 1000;
				currentTime = currentTime.toFixed(2);
				console.log("진행시간 : " + currentTime);
			}
		}, 1000);
	});

	$("#PauseBtn").click(function() {
		if (!isPaused) {
			pauseTime = Date.now();
			clearInterval(timer);
			isPaused = true;
		} else {
			var resumeTime = Date.now();
			elapsedTime += resumeTime - pauseTime;
			isPaused = false;
			timer = setInterval(function() {
				var currentTime = (Date.now() - startTime) / 1000;
				currentTime = currentTime.toFixed(2);
				console.log("진행시간 : " + currentTime);
			}, 1000);
		}
	});

	$("#EndBtn").click(function() {
		if (!isPaused) {
			clearInterval(timer);
			elapsedTime = (Date.now() - startTime) / 1000;
			elapsedTime = elapsedTime.toFixed(2);
			console.log("종료 시간 : " + elapsedTime);
		} else {
			var pausedDuration = (Date.now() - pauseTime) / 1000;
			pausedDuration = pausedDuration.toFixed(2);
			console.log("일시정지 시간 : " + pausedDuration);
		}
	});
});






function startTimer() {
    // 시간을 측정하는 코드
    var currentTime = new Date().getTime();
    return currentTime;
}

</script>
</body>
</html>
<body>
    <h1>강의 제목이 들어갈 자리 입니다.</h1>
    <div style="width: 1280px; height: 720px; background-color: #ccc;" id="youtube-player" class="movie_player"></div>
    <br>

    <button type="button" id="test_btn">지정 위치로</button><br>
    
	<button id="StartBtn">재생버튼</button><br>
	<button id="PauseBtn">일시정지버튼</button><br>
	<button id="ResumeBtn">결과버튼</button><br>
	<button id="EndBtn">종료버튼</button><br>
	<button onclick="nextBtn">다음강의</button><br>


</body>
</html>
