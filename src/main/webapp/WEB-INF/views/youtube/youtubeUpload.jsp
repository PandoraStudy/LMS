<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>유튜브 동영상 업로드 테스트 화면</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<script>
    $(function(){
        $("#upload_btn").click(function() {
            $.ajax({
                type: "POST",
                url: "/youtubeUpload",
                data: { "": , }
            });
        });
    });
</script>
</body>
    <h1>
        동영상 업로드
    </h1>
    <input id="" type="file" accept="video/*"><br>
    <button id="upload_btn">동영상 업로드</button>
</body>
</html>
