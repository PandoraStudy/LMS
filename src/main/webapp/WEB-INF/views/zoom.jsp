<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>zoom</title>
</head>
<script>
</script>
<body>
<h1>zoom</h1>

<button><a href="https://zoom.us/oauth/authorize?client_id=EZkwl4SkScSmppYGnZAkdQ&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%2Fzoom%2Ftoken">권한 받으러가기</a></button>
<c:if test="${ join ne null }">
    <button><a href="${ join }">개설된 회의로 이동</a></button>
</c:if>
</body>
</html>
