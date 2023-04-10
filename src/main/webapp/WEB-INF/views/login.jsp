<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function(){
	$("#sm").click(function(){
		var x = $("#box1").val();
		$.ajax({
		    url: "/test", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
		    data: { "test" : x },  // HTTP 요청과 함께 서버로 보낼 데이터
		    method: "POST",   // HTTP 요청 메소드(GET, POST 등)
		    dataType: "json" // 서버에서 보내줄 데이터의 타입
		}).done(function(json) {
			alert(json[0].korn_FLNM);
		    $("<h1>").text(json.korn_FLNM);
		})
	})
	
})
</script>
</head>
<body>
<form action = "/trylogin" method = "POST">
<input type="text" name="KORN_FLNM">
<button>전송</button>
</form>
<!-- <input type="text" id="box1"> -->
<!-- <button id="sm">전송</button> -->
<!-- <h1>결과는?</h1> -->
</body>
</html>