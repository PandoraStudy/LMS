<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>유튜브 리스트 테스트 화면</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="apikey.js"></script>
</head>
<script>
    $(function () {

        let playlistId = "PL317rEM99HE2GI-kYLlu0D455A0SxVXKF";
        $.get({
            url: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=" + playlistId + "&key=" + API_KEY,
            dataType: "json",
            success: function (playlistItems) {
                let playlist = playlistItems.items;
                for (var i = 0; i < playlist.length; i++) {
                    console.log("강의명 : " + playlist[i].snippet.title);
                    console.log("URL : " + playlist[i].snippet.resourceId.videoId);
                    let videoId = playlist[i].snippet.resourceId.videoId;
                    /* 동영상의 재생시간 가져오기 */
                    $.get({
                        url: "https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails&id=" + videoId + "&key=" + API_KEY,
                        dataType: "json",
                        success: function (video) {
                            let videoDuration = video.items[0].contentDetails.duration;
                            videoDuration = videoDuration.replace("PT", "");
                            videoDuration = videoDuration.replace("H", ":");
                            videoDuration = videoDuration.replace("M", ":");
                            videoDuration = videoDuration.replace("S", "");

                            console.log("동영상 총 재생시간 : " + videoDuration);
                        },
                        error: function () {
                            alert("유튜브 동영상 정보를 불러오는 도중 에러가 발생했습니다.");
                        }
                    });
                }
            },
            error: function () {
                alert("유튜브 플레이리스트를 불러오는 도중 에러가 발생했습니다.");
            }
        });
    });
</script>
<body>
<h1>이 곳은 유튜브 리스트 화면입니다.</h1>
<a href="/youtubeDetail">디테일 화면으로</a>

고민해야 할 것 <br>
플레이리스트 ID를 가져오는 방식
강의 갯수가 많아질 경우 보여지는 방식
</body>
</html>
