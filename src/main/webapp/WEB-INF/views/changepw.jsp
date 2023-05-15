<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form action="/changepw" method="post">
<input type="password" name = "pw"/>
<input type = "hidden" name = "userid" value = "${attr }"/>
<button>새 비밀번호로 저장하기</button> 
</form>
</body>
</html>