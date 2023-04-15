<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <title>zoom</title>
</head>
<script>
    $(function(){

        $("#userList").click(function(){
            let mt1 = $("#meeting_Id").val().split("?");
            let mt2 = mt1[0].split("/j/");
            let meeting_Id = mt2[1];
            console.log(meeting_Id)thfl;
          $.ajax({
            url: "/zoomUsers",
            type: "GET",
            data: { 'accessToken' : $(this).val(), 'meeting_Id' : meeting_Id },
            dataType:"json",
            success: function(data){ console.log(data) },
            error: function(xhr,status,error){ alert("실패")}
            });
        });


    });
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
        height:500px;
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
    .userlist_btn{
        background-color: darkred;
        color:white;
        cursor:pointer;
    }
</style>
<body>
<div class="container">
    <h1 style="text-align: center;">Zoom Meeting</h1>
    <div class="meeting"></div><br>
    <button class="Oauth_btn"><a class="a_btn a_btn1" href="/zoom">초기화</a></button>
    <button class="Oauth_btn"><a class="a_btn a_btn2" href="https://zoom.us/oauth/authorize?client_id=Kpvu8qjDSZCEnEtzZ58KnA&response_type=code&redirect_uri=http://localhost/zoom/token">사용자 인증</a></button>

    <c:if test="${ join ne null }">
        <button class="Oauth_btn Oauth_btn1" ><a class="a_btn" href="${ join }" target="_blank">개설된 회의로 이동</a></button>
        <button class="Oauth_btn userlist_btn" id="userList" value="${ accessToken }">회의참여자</button>
        <input type="hidden" value="${ join }" id="meeting_Id"><br>
        엑세스 토큰 : ${ accessToken } <br>
        회의 주소 : ${ join } <br>
    </c:if>
</div>
</body>
</html>
