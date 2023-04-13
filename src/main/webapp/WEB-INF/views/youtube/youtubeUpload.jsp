<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>유튜브 동영상 업로드 테스트 화면</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<script>
    $(function () {
        $("#upload_btn").click(function () {
            $("#lecture_form").submit();
        });
    });
</script>
<body>
<h1>
    동영상 업로드
</h1>
<form id="lecture_form" method="post" enctype="multipart/form-data">
    <input id="lecture_video" name="lecture_video" type="file" accept="video/*"><br>
    <input id="lecture_title" name="lecture_title" type="text"><br>
    <input id="lecture_content" name="lecture_content" type="text"><br>
    <button id="upload_btn">동영상 업로드</button>
</form>
</body>
</html>
