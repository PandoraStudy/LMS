<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    String resultCode = request.getParameter("code");
    String youtubeScope = request.getParameter("scope");
%>
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
        const CLIENT_ID = "118755665364-936hqtrt2ei5aughd29p56l49qqasqem.apps.googleusercontent.com";
        const CLIENT_SECRET = "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";
        const REDIRECT_URI = "http://localhost:8080/OAuthTest";
        const SCOPE = "https://www.googleapis.com/auth/youtube";
        const AUTHORIZATION_CODE = "<%=resultCode%>";
        $("#request-token-btn").click(function () {
            location.href = "https://accounts.google.com/o/oauth2/auth?client_id=" + CLIENT_ID + "&redirect_uri=" + REDIRECT_URI + "&scope=" + SCOPE + "&response_type=code";

        });

        $("#exchange-code-for-token-btn").click(function () {
            $.ajax({
                type: "POST",
                url: "https://www.googleapis.com/oauth2/v4/token",
                data: {
                    code: AUTHORIZATION_CODE,
                    client_id: CLIENT_ID,
                    client_secret: CLIENT_SECRET,
                    redirect_uri: REDIRECT_URI,
                    grant_type: "authorization_code"
                },
                success: function (response) {
                    console.log(response);
                },
                error: function(error) {
                    console.log(error.responseText);
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
            <span><%=resultCode%></span>
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
<button class="btn btn-primary" id="request-token-btn">Request Token 요청</button>
<button class="btn btn-primary" id="exchange-code-for-token-btn">Exchange Code For Token 요청</button>
<button class="btn btn-primary" id="access-btn">- 요청</button>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</html>
