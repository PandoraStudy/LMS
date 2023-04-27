<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Pandora</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <link rel="shortcut icon" href="img/pandora_logo.png" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<%--    <!--===============================================================================================-->--%>
<%--    <link rel="icon" type="image/png" href="images/icons/favicon.ico"/>--%>
<%--    <!--===============================================================================================-->--%>
<%--    <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">--%>
<%--    <!--===============================================================================================-->--%>
<%--    <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">--%>
<%--    <!--===============================================================================================-->--%>
<%--    <link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">--%>
<%--    <!--===============================================================================================-->--%>
<%--    <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">--%>
<%--    <!--===============================================================================================-->--%>
<%--    <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">--%>
<%--    <!--===============================================================================================-->--%>
<%--    <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">--%>
<%--    <!--===============================================================================================-->--%>
<%--    <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">--%>
<%--    <!--===============================================================================================-->--%>
<%--    <link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">--%>
<%--    <!--===============================================================================================-->--%>
    <link rel="stylesheet" type="text/css" href="css/login/util.css">
    <link rel="stylesheet" type="text/css" href="css/login/main.css">
    <!--===============================================================================================-->
</head>
<script>
    function loginck(){
        let id = document.getElementById("id");
        let pw = document.getElementById("pw");

        if(id.value == ""){
            alert("ID를 입력하세요");
            id.focus();
            return false;
        }
        if(pw.value == ""){
            alert("비밀번호를 입력하세요");
            pw.focus();
            return false; }
    }


</script>
<body>

<div class="limiter">
    <div class="container-login100">
        <div class="wrap-login100">
            <form class="login100-form validate-form" method="post" action="/login" onsubmit="return loginck()">
					<span class="login100-form-title p-b-26">
                        <img src="/resources/pandora_banner.png" style="width:50px; height:50px;"><b style="font-style: italic;">Pandora University</b>
					</span>
                <span class="login100-form-title p-b-20">
						<i class="zmdi zmdi-font"></i>
                    <label style="font-size:20px; cursor:pointer;">
                        <input type="radio" name="division" value="0010" checked >
                        <span>student</span>
                    </label> &nbsp;&nbsp;
                    <label style="font-size:20px; cursor:pointer;">
                        <input type="radio" name="division" value="0020">
                        <span>professor</span>
                    </label>
					</span>

                <div class="wrap-input100 validate-input">
                    <input class="input100" type="text" name="id" id="id" placeholder="ID">
<%--                    <span class="focus-input100" data-placeholder="ID"></span>--%>
                </div>

                <div class="wrap-input100 validate-input" data-validate="Enter password">
						<span class="btn-show-pass">
							<i class="zmdi zmdi-eye"></i>
						</span>
                    <input class="input100" type="password" name="pw" id="pw" placeholder="Password">
<%--                    <span class="focus-input100" data-placeholder="Password"></span>--%>
                </div>

                <div class="container-login100-form-btn">
                    <div class="wrap-login100-form-btn">
                        <div class="login100-form-bgbtn"></div>
                        <button class="login100-form-btn">
                            Login
                        </button>
                    </div>
                </div>
                <div class="text-center p-t-50">
                    비밀번호를 잊어버리셨다면<br>
                    학교에 문의하십시오.
                </div>
            </form>
        </div>
    </div>
</div>


<div id="dropDownSelect1"></div>

<%--<!--===============================================================================================-->--%>
<%--<script src="vendor/jquery/jquery-3.2.1.min.js"></script>--%>
<%--<!--===============================================================================================-->--%>
<%--<script src="vendor/animsition/js/animsition.min.js"></script>--%>
<%--<!--===============================================================================================-->--%>
<%--<script src="vendor/bootstrap/js/popper.js"></script>--%>
<%--<script src="vendor/bootstrap/js/bootstrap.min.js"></script>--%>
<%--<!--===============================================================================================-->--%>
<%--<script src="vendor/select2/select2.min.js"></script>--%>
<%--<!--===============================================================================================-->--%>
<%--<script src="vendor/daterangepicker/moment.min.js"></script>--%>
<%--<script src="vendor/daterangepicker/daterangepicker.js"></script>--%>
<%--<!--===============================================================================================-->--%>
<%--<script src="vendor/countdowntime/countdowntime.js"></script>--%>
<%--<!--===============================================================================================-->--%>
<script src="js/login/main.js"></script>

</body>
</html>