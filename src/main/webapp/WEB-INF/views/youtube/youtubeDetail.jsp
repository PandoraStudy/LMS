<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>유튜브 디테일 테스트 화면</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
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
    /* 학생이 실제 시청 시간 위치 */
    let play_time = ${playTime};

    /* 유튜브 Iframe 준비 상태 */
    function onYouTubeIframeAPIReady() {
        player = new YT.Player('youtubePlayer', {
            videoId: 'q2I2w4jksCQ',
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
            if ((curr_time - play_time) > 5) {
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
                data: {"video_id": "q2I2w4jksCQ", "student_no": student_no},
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
                data: {"video_id": "q2I2w4jksCQ", "curr_time": curr_time, "student_no": student_no},
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
</body>
<div style="width: 1280px; height: 720px; background-color: #ccc;" id="youtubePlayer"></div>
<br>
<a href="/youtubeList">유튜브 플레이리스트로</a>
<br>
<h1>
    총 재생시간 : console.log("동영상 총 재생 시간 : " + player.getDuration()); <br>
    할 일<br>
    1. 추천 영상 및 추가 동영상이 나오기 전에 동영상을 끝내기 (업로드 시 사용자가 직접 정하는 상황인데 이걸 어느정도로 맞춰야할까?) <br>
    2. 리스트 별로 강의 리스트 출력 후 해당 강의 클릭 시 클릭된 강의 디테일 보여주기

    물어볼거<br>
    동영상 더보기 제어 : 동영상 더보기 삭제를 rel : 0 으로 하는데 더이상 지원하지 않는걸로 알고 있다 (같은 채널의 관련 동영상을 추천한다/부분 공개일경우 해결될수도?).
    <br>
    아니면 동영상 업로드 시 제한 (최종하면 추가 : 동영상이 끝날 때 관련 콘텐츠를 홍보합니다를 체크 안하도록?)<br>
    화면 제어를 어떻게 할지(모든게 다 사라짐) 키보드를 막는것도 어떻게 할지


    생각할거<br>
    동영상을 다 보고 다시 강의를 들어갈 경우<br>
    비디오 실행 방법 로딩 완료시 바로 실행? 아니면 사용자가 실행? 유튜브에서 보기가 뜸
</h1>
</body>
</html>
