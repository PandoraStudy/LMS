<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>유튜브 리스트 테스트 화면</title>
    <%-- ISO 8601 변환 시 사용하기 위한 라이브러리 --%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <%-- JQuery --%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <%-- API Key값 --%>
    <script src="js/apikey.js"></script>
</head>
<script>
    $(function () {
        // 로딩창 보여주기
        $('#loading').show();

        let studentNo = 131;
        let playlistId = "PL317rEM99HE2GI-kYLlu0D455A0SxVXKF";

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

                            /* 데이터베이스 저장된 재생 시간 가져오기 (해당 ajax는 getPlayTime() 함수 호출로 변경할 예정입니다.) */
                            $.ajax({
                                type: "POST",
                                url: "/getPlayTime",
                                data: {"video_id": videoId, "student_no": studentNo, "total_time": totalTime},
                                dataType: "text",
                                success: function (progress) {
                                    /* 실제 사용자에게 보여주기 위해 append 처리할 <tr> 생성 */
                                    let $tr = $("<tr>");
                                    $tr.append("<td><div class='video-thumnails'><img class='video-img' src='" + videoThumnails + "'><span class='total-time'>" + videoTotalTime + "</span></div></td>");
                                    $tr.append("<td><span>" + videoTitle + "(" + videoId + ")</span></td>");
                                    $tr.append("<td><span>(<i style='color: red;'>" + progress + "</i> )</span></td>");
                                    $("#tb_lecture").append($tr);
                                    $("#loading").hide();
                                },
                                error: function () {
                                    $("#loading").hide();
                                    alert("저장된 재생 시간을 불러오지 못했습니다.");
                                }
                            });
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
        videoDuration = videoDuration.replace("H", ":");
        videoDuration = videoDuration.replace("M", ":");
        videoDuration = videoDuration.replace("S", "");

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
<body>
<div id="loading">
    <div class="spinner"></div>
</div>

<h1>이 곳은 유튜브 리스트 화면입니다.</h1>
<a href="/youtubeDetail">디테일 화면으로</a>
<br>
<hr>

<table id="table_lecture">
    <thead>
    <tr>
        <th>썸네일</th>
        <th>제목(파일여부)</th>
        <th>진도율</th>
        <th>출석</th>
    </tr>
    </thead>
    <tbody id="tb_lecture">
    <tr>
        <td>
            <div class="video-thumnails">
                <img class="video-img" src="img/test.jpeg">
                <span class="total-time">7:10</span>
            </div>
        </td>
        <td><span>제목입니다.</span></td>
        <td>진도율 : (특정값 / 기준값 * 100)</td>
        <th><input class="chk-lecture" type="checkbox" checked onclick="return false;"></th>
    </tr>
    </tbody>
</table>

<hr>
<br>
고민해야 할 것 <br>
플레이리스트 ID를 가져오는 방식
강의 갯수가 많아질 경우 보여지는 방식
</body>
</html>
