<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>유튜브 인증 테스트 화면</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<script>
    $(function () {
        $("#access-btn").click(function () {
            $.ajax({
                type: "post",
                url: "/OAuth",
                dataType: "text",
                success: function (token) {
                    console.log(token);
                    $("#txt_code").text(token);
                }
            });
        });
    });
</script>
<style>
    input[type=text] {
        width: 90%;
    }

    .btn-primary {
        float: right;
        margin-right: 30px;
    }
</style>
<body>
<table class="table">
    <thead>
    <tr>
        <th class="col-md-4">항목</th>
        <th class="col-md-8">데이터</th>
    </tr>
    </thead>
    <tbody class="table-group-divider">
    <tr>
        <td>인증 코드</td>
        <td>
            <span id="txt_code">인증 코드를 발급 받아주세요.</span>
        </td>
    </tr>
    </tbody>
</table>
<button class="btn btn-primary" id="access-btn">OAuth 인증</button>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</html>
