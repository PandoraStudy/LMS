<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>

<script>
window.onload = function(){
	alert("${msg}");
}
</script>
<body>
<form action = "/passwordresetrequest" method="post">
	비밀번호를 초기화 하려는 ID<input type="text" name="id"/>
	<button>전송</button>
</form>
</body>
</html>