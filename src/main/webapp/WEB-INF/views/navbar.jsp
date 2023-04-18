<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!-- 사이드 메뉴바 -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center logo_space" href="index">
        <div class="logo_img"><img src="/img/pandora_logo.png"></div>
        <div class="sidebar-brand-text mx-3">
            <div class="logo_big_text">PANDORA</div>
            <sup class="logo_small_text">university</sup></div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- 학생정보 -->
    <li class="nav-item active">
        <a class="nav-link" href="index">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>
                2023년도 1학기
            </span></a>


    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- A 카테고리 -->
    <div class="sidebar-heading">
        학사
    </div>

    <!-- A카테고리 A탭 드롭다운-->
    <li class="nav-item">
        <a style="height: 40px;" class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
           aria-expanded="true" aria-controls="collapseTwo">
            <i class="fas fa-fw fa-cog"></i>
            <span>학교</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">학교</h6>
                <a class="collapse-item" href="/notice">공지사항</a>
            </div>
        </div>
    </li>

    <!-- A카테고리 B탭 드롭다운 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="/lecture">
            <i class="fas fa-fw fa-wrench"></i>
            <span>내 강의실</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider line">

    <!-- B 카테고리 -->
    <div class="sidebar-heading">
        추가적인 기능(이름수정필요)
    </div>


    <!-- 추가적인 기능(이름 수정 필요) -->
    <li class="nav-item">
        <a style="height: 40px;" class="nav-link" href="charts.html">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>캘린더</span></a>
    </li>

    <!-- C 부분2 -->
    <li class="nav-item">
        <a class="nav-link" href="tables.html">
            <i class="fas fa-fw fa-table"></i>
            <span>미정</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- 사이드바 토클 버튼 (누르면 들어감) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

    <!-- 사이드바 메시지 -->
    <%--<div class="sidebar-card d-none d-lg-flex">
        <img class="sidebar-card-illustration mb-2" src="img/undraw_rocket.svg" alt="...">
        <p class="text-center mb-2"><strong>로켓트!</strong> 날라가유~ 두번 날라가유~</p>
        <a class="btn btn-success btn-sm" href="https://startbootstrap.com/theme/sb-admin-pro">응애 나 애기 밍규</a>
    </div>--%>
</ul>
<!-- End of Sidebar -->

