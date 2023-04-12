<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>zoom</title>
</head>
<script>
</script>
<style>
    body{
        margin:0;
        padding: 0;
    }
    a{ text-decoration: none; }
    button{ cursor: pointer; }
    .container{
        margin:0 auto;
        width:1200px;
        height:800px;

    }
    .meeting{
        width:1200px;
        height:800px;
        border: 1px solid black;
        box-sizing: border-box;
    }
    .Oauth_btn{
        width:200px;
        height:50px;
        border: none;
        border-radius: 5px;
        background-color: black;
    }
    .Oauth_btn:hover{ background-color: #ccc; }
    .a_btn{ color:white; font-weight: bold; }
    .Oauth_btn1{
        background-color: navy;
        color:white;
        cursor:pointer;
    }
</style>
<body>
<div class="container">
    <h1 style="text-align: center;">Zoom Meeting</h1>
    <div class="meeting"></div><br>
    <button class="Oauth_btn"><a class="a_btn a_btn1" href="/zoom">초기화</a></button>
    <button class="Oauth_btn"><a class="a_btn a_btn2" href="https://zoom.us/oauth/authorize?client_id=EZkwl4SkScSmppYGnZAkdQ&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%2Fzoom%2Ftoken">사용자 인증</a></button>
    <c:if test="${ join ne null }">
        <button class="Oauth_btn Oauth_btn1" ><a class="a_btn" href="${ join }">개설된 회의로 이동</a></button>
    </c:if>
</div>
</body>
</html>
