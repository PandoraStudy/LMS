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
        $("#access-btn").click(function() {
            location.href = "https://accounts.google.com/o/oauth2/auth?client_id=118755665364-936hqtrt2ei5aughd29p56l49qqasqem.apps.googleusercontent.com&redirect_uri=http://localhost/OAuthTest&scope=https://www.googleapis.com/auth/youtube&response_type=code&access_type=offline";
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
        <td>Client ID</td>
        <td><input type="text" id="clientId"></td>
    </tr>
    <tr>
        <td>Redirect URL</td>
        <td><input type="text" id="redirectUri" value="http://localhost/OAuthTest"></td>
    </tr>
    <tr>
        <td>Scope</td>
        <td><input type="text" id="scope" placeholder="여러 개의 scope를 입력할 시 공백으로 구분"></td>
    </tr>
    <tr>
        <td>Response Type</td>
        <td><input type="text" id="responseType"></td>
    </tr>
    <tr>
        <td>Access Type</td>
        <td>
            <select name="job" id="accessType">
                <option value="online">online</option>
                <option value="offline" selected>offline</option>
            </select>
        </td>
    </tr>
    <tr>
        <td>Google OAuth 2 요청 경로</td>
        <td><span id="result"
                  style="display: block; border: 1px solid #ccc; width: 90%; height: 30px; padding-left: 3px; box-sizing: border-box;">test
        </td>
    </tr>
    <tr>
        <td>파일</td>
        <td>
            <div class="mb-3">
                <input class="form-control file" type="file" id="videoFile">
            </div>
        </td>
    </tr>
    </tbody>
</table>
<button class="btn btn-primary" id="access-btn">사용 권한 요청</button>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</html>
