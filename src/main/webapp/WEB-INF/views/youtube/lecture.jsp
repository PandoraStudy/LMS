<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Pandora University - LMS</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
          rel="stylesheet">
    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <link href="css/logo.css" rel="stylesheet">
    <%-- API Key값 --%>
    <script src="js/apikey.js"></script>
</head>
<script type="text/javascript">
$(function(){

	
	let channelId = "UCx6jsZ02B4K3SECUrkgPyzg";//놀면뭐하니
	//let channelId = "UC5s_Ei99uCIsArS1Zle4lRA";//동영
	//let channelId = "UC5s_Ei99uCIsArS1Zle4lRA";//정목


	$.get({
		url: "https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=" + channelId + "&key=" + API_KEY+"&maxResults=9",
		dataType: "json",
		success: function (playlists) {
			//alert("성공");
			console.log(playlists);
			
			var playlists = playlists.items;
			
			console.log(playlists);
			
			console.log(playlists.length);
			
			for (var i = 0; i < playlists.length; i++) {
				var playlist = playlists[i];
				var title = playlist.snippet.title;
				var description = playlist.snippet.description || "";
				var id = playlist.id;
				
				let $tr = $("<tr onclick=location.href='youtubeList?playlist_id=" + id + "'>");
				

				/* 실제 사용자에게 보여주기 위해 append 처리할 <tr> 생성 */

				$tr.append("<td><span>" + title + "</span></td>");

				$("#tb_lecture").append($tr);
				
				
                
			}
		}, error: function(jqXHR, textStatus, errorThrown) {
		    console.log(jqXHR.responseJSON.error.message);
		  }
	})
});
</script>
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
                    <h1 class="h3 mb-0 text-gray-800">내 강의실</h1>
                    <%--                        <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> 이건무슨 버튼으로 쓸까</a>--%>
                </div>

                <div class="row">
                    <!-- A카드 게시판 -->
                    <div class="col-xl-12 col-lg-7">
                        <div class="card shadow mb-4">
                            <!-- A 카드 설정 버튼 부분 -->
                            <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-primary">과목명</h6>
                                <div class="dropdown no-arrow">
                                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                         aria-labelledby="dropdownMenuLink">
                                        <div class="dropdown-header">더보기</div>
                                        <a class="dropdown-item" href="#">추가 메뉴</a>
                                    </div>
                                </div>
                            </div>
                            <!-- A 본문 부분 -->
                            <div class="card-body">
                                <div class="chart-area">
                                    <div>
                                        <!-- 실제 구성은 이곳에서 진행합니다. -->
										<table id="table_lecture">
										<thead>
											<tr>
												<th>제목</th>
												<th>학과</th>
											</tr>
										</thead>
										<tbody id="tb_lecture">
											<tr>
												<td id="playlist_title"></td>
											</tr>
										</tbody>
									</table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 디테일 화면 종료 -->
        </div>
        <!-- 메인 콘텐츠 종료 -->

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

<!-- Bootstrap core JavaScript-->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- Custom scripts for all pages-->
<script src="js/sb-admin-2.min.js"></script>
<!-- Page level plugins -->
<script src="vendor/chart.js/Chart.min.js"></script>
<!-- Page level custom scripts -->
<script src="js/demo/chart-area-demo.js"></script>
<script src="js/demo/chart-pie-demo.js"></script>
</body>
</html>