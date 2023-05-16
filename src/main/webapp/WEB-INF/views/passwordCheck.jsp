<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form action="/passwordCheckrequest" method="post">
<input type = "text" name = "key"/>
<input type = "hidden" name = "userid" value = "${attr }"/>
<button>인증키 전송</button>

</form>
</body>
</html>