<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Pandora University - LMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <%-- ISO 8601 변환 시 사용하기 위한 라이브러리 --%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
          rel="stylesheet">
    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <link href="css/logo.css" rel="stylesheet">
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>
<script>
    /* 오늘 날짜를 대신합니다. */
    let today = 4;

    $(function() {

        $(".week-select").click(function() {
            let end_cls_cd = $(this).children(".fas").attr("value");

            if(today < end_cls_cd) {
                alert("진행할 수 없는 주차입니다.");
                return false;
            }
            $(this).children(".fas").toggleClass("fa-chevron-down fa-chevron-up");
        });

        $(".week-title").click(function() {
                let lectureInfo = $(this).find(".mthd").val();
                let snOrUrl = lectureInfo.split(",")[0];
                let mthd = lectureInfo.split(",")[1];

                if(mthd == 1) {
                    if(snOrUrl != "") {
                        location.href = "/lectureDetail?on_lect_sn=" + snOrUrl;
                    } else {
                        alert("유효하지 않은 주소입니다.\n잠시 후 다시 시도해주세요.");
                    }
                } else {
                    // 강사의 줌 회의 개설
                    if(snOrUrl != "") {
                        let sbjct_no = "${sbjct_no}";

                        let appl = "${sessionScope.appl_no}";
                        let instr = "${sessionScope.instr_no}";

                        if(appl != "") {
                            window.open(snOrUrl, "줌", "menubar=no, toolbar=no, fullscreen=yes");
                        } else if (instr != "") {
                            $(function() {
                                $.ajax({
                                    url: '/zoom_open',
                                    type: 'post',
                                    data: { "sbjct_no" : sbjct_no },
                                    dataType: 'text',
                                    success : function(result) {
                                        if(result != ""){
                                            alert("인증에 성공했습니다.");
                                            window.open("https://zoom.us/oauth/authorize?client_id=Kpvu8qjDSZCEnEtzZ58KnA&response_type=code&redirect_uri=http://localhost/zoom/token?sbjct_no=" + result, "Zoom", "width=820, height=720");
                                        }else{
                                            alert("인증실패 관리자 문의 바람.");
                                            return false;
                                        }
                                    },
                                    error : function(xhr) {
                                        alert(xhr);
                                        alert("요청 실패 재시도 바람.");
                                    }
                                });
                            });
                        }
                    } else {
                        alert("아직 회의가 개설되지 않았습니다.\n잠시 후 다시 시도해주세요.");
                    }
                }
        });

        $(".week-file").click(function() {
            let file = $(this).find(".file").val();
            alert(file);
        });

        $(".week-assign").click(function() {
            alert("과제를 제출했습니다.");
        });

        $(".week-upload").click(function() {
            let sbjct_mthd = $(this).find("#sbjct_mthd").val();
            $("#sbjct_mthd_cd").val(sbjct_mthd);
            let lect_ymd_org = $(this).find("#lect_ymd_org").val();
            $("#lect_ymd").val(lect_ymd_org);

            let on_lect_sn = $(this).find(".upload").val();
            $("#on_lect_sn").val(on_lect_sn);
            $(".modal-title").html(on_lect_sn + "주차 추가");
            $(".upload-modal").modal("show");
        });

        $("#upload-select").change(function() {
            let upload_select = $("#upload-select").val();

            if(upload_select == "assign") {
                $(".upload-title").html("과제명");
                $(".upload-title-td").html("<input class='form-control' name='title' type='text'>");
                $(".upload-content").html("과제");
                $(".upload-content-td").html("<input class='form-control' name='content' type='text'>");
            } else if(upload_select == "file") {
                $(".upload-title").html("파일명");
                $(".upload-title-td").html("<input class='form-control' name='title' type='text'>");
                $(".upload-content").html("파일");
                $(".upload-content-td").html("<input class='form-control' name='file' type='file'>");
            }
        });

        $(".modal-submit").click(function() {
            let frm_modal = $("#frm-modal")[0];
            let frmData = new FormData(frm_modal);

            $.ajax({
                type: "post",
                url: "/modalUpload",
                data: frmData,
                contentType : false,
                processData : false,
                success: function(result) {
                    if(result == "empty_file") {
                        alert("선택된 파일이 없습니다.");
                    } else if(result == "success") {
                        alert("등록 완료.");
                        location.reload();
                    } else if(result == "error") {
                        alert("파일 등록중 문제가 발생했습니다.\n잠시후 다시 시도해주세요.");
                    }
                },
                error: function () {
                    alert("파일 등록중 문제가 발생했습니다.\n잠시후 다시 시도해주세요.");
                }
            });
        });

    });
</script>
<style>
    .week-select {
        width: 100%;
        height: 50px;
        line-height: 50px;
        padding-left: 10px;
        box-sizing: border-box;
        border-top: 1px solid #ccc;
        border-left: 1px solid #ccc;
        border-right: 1px solid #ccc;
    }

    .select-last {
        border-bottom: 1px solid #ccc;
    }

    .week-content {
        width: 100%;
        height: auto;
        border-top: 1px solid #ccc;
        border-left: 1px solid #ccc;
        border-right: 1px solid #ccc;
        padding: 10px;
        padding-top: 17px;
        box-sizing: border-box;
        transition: 0s;
    }

    .week-file {
        width: 100%;
        height: auto;
        border-top: 1px solid #ccc;
        border-left: 1px solid #ccc;
        border-right: 1px solid #ccc;
        padding: 10px;
        padding-top: 17px;
        box-sizing: border-box;
        transition: 0s;
    }

    .week-assign {
        width: 100%;
        height: auto;
        border-top: 1px solid #ccc;
        border-left: 1px solid #ccc;
        border-right: 1px solid #ccc;
        padding: 10px;
        padding-top: 17px;
        box-sizing: border-box;
        transition: 0s;
    }

    .week-upload {
        width: 100%;
        height: auto;
        border-top: 1px solid #ccc;
        border-left: 1px solid #ccc;
        border-right: 1px solid #ccc;
        padding: 10px;
        padding-top: 17px;
        box-sizing: border-box;
        transition: 0s;
    }

    .content-last {
        border-top: 0;
        border-bottom: 1px solid #ccc;
    }

    .week-object {
        width: 100%;
        height: 40px;
    }

    .btn {
        width: 75px;
        height: 30px;
        line-height: 17px;
        margin-right: 10px;
    }

    .assign-tr {
        line-height: 40px;
        text-align: center;
    }

</style>
<body id="page-top">
<!-- Page Wrapper -->
<div id="wrapper">

    <%-- 네비게이션 바 --%>
    <%@include file="../navbar.jsp" %>

    <!-- 콘텐츠 전체 감싸기 -->
    <div id="content-wrapper" class="d-flex flex-column">
        <!-- 메인 컨텐츠 -->
        <div id="content">
            <%-- 탑 바 --%>
            <%@include file="../top.jsp" %>

            <!-- 본문 컨텐츠 부분 시작 -->
            <div class="container-fluid">

                <!-- 메인 페이지의 탑 -->
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800"></h1>
                    <%--                        <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> 이건무슨 버튼으로 쓸까</a>--%>
                </div>

                <div class="row">
                    <!-- A카드 게시판 -->
                    <div class="col-xl-12 col-lg-7">
                        <div class="card shadow mb-4">
                            <!-- 강의 본문 부분 -->
                            <div class="card-body border-left-primary">
                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                    <div style="width: 80%; height: 40px; float: left;">${lectList[0].SBJCT_NM} 공지사항</div>
                                    <div style="width: 20%; height: 40px; float: left; margin-bottom: 5px;">
                                        <c:if test="${sessionScope.instr_no != null}"><button class="btn btn-primary" style="float: right;">글작성</button></c:if>
                                    </div>
                                </div>
                                <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <td class="col-1">번호</td>
                                            <td class="col-4">제목</td>
                                            <td class="col-2">작성자</td>
                                            <td class="col-2">조회수</td>
                                            <td class="col-2">등록일</td>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td class="title text-truncate" style="max-width:1px; text-align: left;">T1tle</td>
                                            <td>INSTR01</td>
                                            <td>11</td>
                                            <td>10:33</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- A카드 게시판 -->
                    <div class="col-xl-12 col-lg-7">
                        <div class="card shadow mb-4">
                            <!-- A 카드 설정 버튼 부분 -->
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-primary">강의</h6>
                            </div>
                            <!-- 강의 본문 부분 -->
                            <div class="card-body">
                                <div>
                                    <!-- 강의 정보 추가 위치 -->
                                    <c:set var="i" value="1"/>
                                        <c:forEach items="${lectList}" var="lect" varStatus="status">
                                        <div class="week-select ${status.last ? 'select-last' : ''}" data-toggle="collapse" data-target=".week-content${i}">
                                            <i class="fas fa-chevron-down" value="${lect.END_CLS_CD}"></i> ${i}주차
                                            <div style="float:right; margin-right:20px">
                                            <!-- 완료 미완료 버튼 -->
                                            	<c:choose>
													<c:when test="${90 lt lect.LECT_PRGRS_RT}">
														<button style="width:108px;" class="btn btn-outline-primary">과제제출</button>
													</c:when>
													<c:otherwise>
														<button style="width:108px;" class="btn btn-outline-danger">과제미제출</button>
													</c:otherwise>
												</c:choose>
                                            </div>
                                            <div style="float:right; margin-right:10px">
                                            	<c:choose>
													<c:when test="${90 lt lect.LECT_PRGRS_RT}">
														<button style="width:90px;" class="btn btn-outline-primary">수강완료</button>
													</c:when>
													<c:otherwise>
														<button style="width:90px;" class="btn btn-outline-success">수강중</button>
													</c:otherwise>
												</c:choose>
                                            </div>
                                        </div>
                                        <!-- 강의 -->
                                        <div class="week-content week-content${i} ${status.last ? 'content-last' : ''} 
                                        <c:choose>
                                        <c:when test="${lect.SBJCT_MTHD_CD eq 1}">border-left-danger
                                        </c:when>
                                        <c:otherwise>border-left-primary
                                        </c:otherwise>
                                        </c:choose> collapse">
<!-- collapse여기부분 수정 -->
                                            <!-- 숨길 객체의 내용 -->
                                            <div class="week-object">
                                                <div class="week-title" style="height: 30px; padding-top: 2px; box-sizing: border-box; float: left;">
                                                    <button class="mthd btn <c:choose><c:when test="${lect.SBJCT_MTHD_CD eq 1}">btn-danger</c:when><c:otherwise>btn-primary</c:otherwise></c:choose>" value="<c:choose><c:when test="${lect.SBJCT_MTHD_CD eq 1}">${lect.ON_LECT_SN }</c:when><c:otherwise>${lect.LECT_URL}</c:otherwise></c:choose>,${lect.SBJCT_MTHD_CD}"><c:choose><c:when test="${lect.SBJCT_MTHD_CD eq 1}">유튜브</c:when><c:otherwise><c:choose><c:when test="${sessionScope.appl_no ne null}">줌수업</c:when><c:otherwise>줌생성</c:otherwise></c:choose></c:otherwise></c:choose></button>
<!-- 여기도 수정 -->
                                                    <span style="cursor: pointer">${lect.ON_LECT_NM }</span>
                                                </div>
                                                <c:if test="${sessionScope.appl_no != null}">
                                                <div style="padding-top: 5px; box-sizing: border-box; height: 30px; float: right; line-height: 30px; display: flex; justify-content: right;">
                                                    <c:choose><c:when test="${lect.SBJCT_MTHD_CD eq 1}">          
                                                    <div class='progress mb-4' style='height:15px; width: 200px; margin:5px 10px 24px 0;'>
	                                                    <div class='progress-bar bg-primary' role='progressbar' style='height:20px; 
	                                                    width: 
		                                                    <c:choose>
			                                                    <c:when test="${90 lt lect.LECT_PRGRS_RT}">100%;</c:when>
			                                                    <c:otherwise>${lect.LECT_PRGRS_RT}%;</c:otherwise>
		                                                    </c:choose>' 
		                                                    aria-valuenow='20' aria-valuemin='0' aria-valuemax='100'>
	                                                    </div>
                                                    </div>
                                                    <div style='height:20px; line-height: 20px;'>&nbsp;
														<span class='float-right' style='height:20px; margin-right:45px; padding-top: 2px;'>
														<fmt:parseNumber value="${lect.LECT_PRGRS_RT}" integerOnly="true"></fmt:parseNumber>%
														</span>
													</div>
                                                    </c:when><c:otherwise><div style='height:15px; width: 200px; margin-top: -3px;'><b>${lect.ATTENDANCE}</b></div></c:otherwise></c:choose>
                                                </div>
                                                </c:if>
                                            </div>
                                        </div>
                                        <c:if test="${lect.FILE_SN ne null}">
                                            <c:set var="file_cnt" value="0"/>
                                            <c:forEach begin="1" end="${lect.FILE_LENGTH}">
                                            <!-- 파일 -->
                                            <div class="week-file week-content${i} ${status.last ? 'content-last' : ''} border-left-secondary collapse">
                                                <!-- 숨길 객체의 내용 -->
                                                <div class="week-object">
                                                    <div class="week-title" style="width: 50%; height: 30px; padding-top: 2px; box-sizing: border-box; float: left;">
                                                        <button class="file btn btn-secondary" value="${lect.PHYS_FILE_NM_LS[file_cnt]}">자료</button>
                                                        <span>${lect.PHYS_FILE_NM_LS[file_cnt]}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <c:set var="file_cnt" value="${file_cnt + 1}"/>
                                            </c:forEach>
                                        </c:if>
                                        <!-- 과제 -->
                                        <div class="week-assign week-content${i} ${status.last ? 'content-last' : ''} border-left-warning collapse">
                                            <!-- 숨길 객체의 내용 -->
                                            <div class="week-object">
                                                <div class="week-title" style="width: 50%; height: 30px; padding-top: 2px; box-sizing: border-box; float: left;">
                                                    <button class="assign btn btn-warning">과제</button>
                                                    <span>${lect.ON_LECT_NM }</span>
                                                </div>
                                                <c:if test="${sessionScope.appl_no != null}">
                                                <div style="width: 50%; padding-top: 5px; box-sizing: border-box; height: 30px; float: left; line-height: 30px; display: flex; justify-content: right;">
                                                    <div style='height:15px; width: 200px; margin-top: -3px;'>
                                                    	<c:choose>
                                                    		<c:when test="${lect.LECT_PRGRS_RT >= 90}">
                                                    			<b>제출</b>
                                                    		</c:when>
                                                    		<c:otherwise>
                                                    			<b>미제출</b>
                                                    		</c:otherwise>
                                                    	</c:choose>
                                                    </div>
                                                </div>
                                                </c:if>
                                            </div>
                                        </div>
                                        <c:if test="${sessionScope.instr_no != null && lect.SBJCT_MTHD_CD ne 2}">
                                        <!-- 추가 -->
                                        <div class="week-upload week-content${i} ${status.last ? 'content-last' : ''} border-left-success collapse">
                                            <!-- 숨길 객체의 내용 -->
                                            <div class="week-object">
                                                <div class="week-title" style="width: 50%; height: 30px; padding-top: 2px; box-sizing: border-box; float: left;">
                                                    <input type="hidden" id="sbjct_mthd" value="${lect.SBJCT_MTHD_CD}">
                                                    <input type="hidden" id="lect_ymd_org" value="${lect.LECT_YMD}">
                                                    <button class="upload btn btn-success" value="${lect.ON_LECT_SN}">추가</button>
                                                    <span>추가</span><span style="font-size: 12px; margin-left: 10px;"><b style="color: red;">*</b>파일, 과제를 추가합니다.</span>
                                                </div>
                                            </div>
                                        </div>
                                        </c:if>
                                        <c:set var="i" value="${i + 1}"/>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 디테일 화면 종료 -->
        </div>
        <!-- 메인 콘텐츠 종료 -->

        <!-- Modal -->
        <form id="frm-modal">
            <div class="modal upload-modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" id="on_lect_sn" name="on_lect_sn">
                            <input type="hidden" id="sbjct_mthd_cd" name="sbjct_mthd_cd">
                            <input type="hidden" id="lect_ymd" name="lect_ymd">
                            <table class="table table-bordered">
                                <tr class="assign-tr">
                                    <th>유형</th>
                                    <td>
                                        <select class="form-select" name="upload-select" id="upload-select">
                                            <option value="assign" selected>과제</option>
                                            <option value="file">파일</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr class="assign-tr">
                                    <th class="upload-title">과제명</th>
                                    <td class="upload-title-td">
                                        <input class="form-control" type="text">
                                    </td>
                                </tr>
                                <tr class="assign-tr">
                                    <th class="upload-content">과제</th>
                                    <td class="upload-content-td">
                                        <input class="form-control" type="text">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                            <button type="button" class="btn btn-primary modal-submit">추가</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <!-- Footer -->
        <%@include file="../footer.jsp" %>

    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button -->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="js/sb-admin-2.min.js"></script>

</body>
</html>