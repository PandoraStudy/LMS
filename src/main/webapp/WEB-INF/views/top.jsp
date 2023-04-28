<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
  let user_id = "${ sessionScope.id }";
  $.ajax({
    type: "POST",
    url: "/msgNew",
    data: {'user_id': user_id },
    dataType: "text",
    success: function (msg) {
      //alert(msg);
      if(msg != "0") $(".msgCnt").text(msg);
      else $(".msgCnt").hide();
    },
    error: function (xhr, status, error) { alert("에러"); }
  });
</script>
<style>
  .msgCnt{
    width:23px;
    height:23px;
    line-height: 15px;
  }
</style>
<!-- 탑 바 -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

  <!-- Sidebar Toggle (Topbar) -->
  <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
    <i class="fa fa-bars"></i>
  </button>

  <!-- Topbar Navbar -->
  <ul class="navbar-nav ml-auto">

    <!-- 채팅 부분 -->
    <li class="nav-item dropdown no-arrow mx-1">
      <a class="nav-link" href="/chatting"><i class="xi-message-o xi-2x"></i></a>
    </li>

    <!-- 쪽지(메시지) 부분 -->
    <li class="nav-item dropdown no-arrow mx-1">
      <a class="nav-link" href="/messageBox"><i class="xi-mail xi-2x"></i>
        <!-- 메시지 카운트 부분 -->
        <c:if test="${sessionScope.id ne null && msgCnt ne 0 }">
        &nbsp;<span class="badge badge-danger badge-counter msgCnt"></span>
        </c:if>
      </a>
    </li>

    <div class="topbar-divider d-none d-sm-block"></div>

    <!-- 유저 프로필 부분 -->
    <li class="nav-item dropdown no-arrow">
      <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
         data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <span class="mr-2 d-none d-lg-inline text-gray-600 small">
          <c:if test="${ sessionScope.id ne null }">${sessionScope.name}</c:if>
        </span>
        <img class="img-profile rounded-circle" src="img/undraw_profile.svg"><%--유저 프로필 이미지 부분--%>
      </a>

      <!-- 유저 프로필 드롭다운 부분 -->
      <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
           aria-labelledby="userDropdown">
        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
          <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
          로그아웃
        </a>
      </div>
    </li>
  </ul>
</nav>
<!-- 탑바 마무리 -->

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">로그아웃</h5>
        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"></span>
        </button>
      </div>
      <div class="modal-body">정말로 로그아웃 하시겠습니까?</div>
      <div class="modal-footer">
        <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
        <a class="btn btn-primary" href="/logout">로그아웃</a>
      </div>
    </div>
  </div>
</div>