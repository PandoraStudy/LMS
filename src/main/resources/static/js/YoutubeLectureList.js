const API_KEY = "AIzaSyC3jBgAkdrvenbwtH_ZY1AHCts4gIUor90";

    $(function () {
        // 로딩창 보여주기
        $('#loading').show();

        let studentNo = 131;
        //const playlistId = "PLIHkbyUJLOS915lPLpulQEN8MZPzTVF0b";
        let playlistId = "${playlistId}";
/*
		$.get({
			url: "";
		})
 */
        $.get({
            url: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=" + playlistId + "&key=" + API_KEY,
            dataType: "json",
            success: function (playlistItems) {
                /* 플레이리스트에 있는 동영상 각각의 정보 */
                let playlist = playlistItems.items;
				
                for (var i = 0; i < playlist.length; i++) {
                    /* 동영상 썸네일 이미지 URL, 제목, 동영상 URL, 동영상 총 재생시간, DB 저장된 재생시간, 썸네일 사용 총 재생시간 */
                    let videoThumnails = playlist[i].snippet.thumbnails.medium.url
                    let videoTitle = playlist[i].snippet.title;
                    let videoId = playlist[i].snippet.resourceId.videoId;
                    let videoDuration = "";
                    let videoPlayTime = 0;
                    let videoTotalTime = "";
                    
//                     var ON_LECT_TM_List = ${ON_LECT_TM };
//                     var AjON_LECT_TM = ON_LECT_TM_List.AjON_LECT_TM;
//                     var ON_LECT_TM = AjON_LECT_TM[i].ON_LECT_TM;
                    /* 동영상의 재생시간 가져오기 */
                    $.get({
                        url: "https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails&id=" + videoId + "&key=" + API_KEY,
                        dataType: "json",
                        success: function (video) {
                            /* 유튜브 API 제공하는 총 재생시간 ISO 8601 형식 */
                            videoDuration = video.items[0].contentDetails.duration;
                            /* moment.js 라이브러리를 사용하여 ISO 8601 형식 duration 객체로 변환 */
                            let totalTime = moment.duration(videoDuration).asSeconds();
                            /* ISO 8601 형식 썸네일 표시 위해 M:S 형태로 교체 */
                            videoTotalTime = durationToTotalTime(videoDuration);
							//console.log(totalTime);
							//console.log(videoThumnails);
							//console.log(videoTitle);
							//console.log(videoId);
                    		
							
							$.post({
								url: "/youtubeData",
								data: {videoId: videoId, videoTitle: videoTitle, videoThumnails: videoThumnails, totalTime: totalTime},
								success: function(data){
									//console.log("data : " + data);
								}, error: function (xhr, status, error) {
									//console.log(xhr.responseText);
								}
							});
                            /* 1번 포인트 */
                            //console.log(videoId + "1st : " + totalTime);
                             // 실제 사용자에게 보여주기 위해 append 처리할 <tr> 생성
                            let $tr = $("<tr>");
                            $tr.append("<td class='text-center'>"
                            + "<div class='video-thumnails'>"
                            + "<a onclick=location.href='lectureDetail?video_id=" + videoId + "'>"
                            + "<img class='video-img' src='" + videoThumnails + "'></a>"
                            + "<span class='total-time'>" + videoTotalTime + "</span></div></td>");
                            $tr.append("<td><a onclick=location.href='lectureDetail?video_id=" + videoId + "'>"
                            + "<span>" + videoTitle + "(" + videoId + ")</span></a></td>");
// 					if(attendance > 0){//출석 미인정 + 과제제출여부까지 확인하기
// 						$tr.append("<th class='text-center'><input class='chk-lecture' type='checkbox' onclick='return false;'></th>");
//                         $tr.append("<th class='text-center'><input class='chk-lecture' type='checkbox' onclick='return false;'></th>");
// 					} else{//출석 인정
//                             $tr.append("<th class='text-center'><input class='chk-lecture' type='checkbox' checked onclick='return false;'></th>");
//                             $tr.append("<th class='text-center'><input class='chk-lecture' type='checkbox' checked onclick='return false;'></th>");
						

// 					}
                            $("#tb_lecture").append($tr);
							
							
                            
                            $("#loading").hide();
                        },
                        error: function () {
                            $("#loading").hide();
                            alert("유튜브 동영상 정보를 불러오는 도중 에러가 발생했습니다.");
                        }
                    });
                } /* 반복문 종료 */
            },
            error: function () {
                $("#loading").hide();
                alert("유튜브 플레이리스트를 불러오는 도중 에러가 발생했습니다.");
            }
        });
    });

    /* ISO 8601 형식을 썸네일 표시 위해 M:S 형태로 교체 */
    function durationToTotalTime(videoDuration) {
        videoDuration = videoDuration.replace("PT", "");
        videoDuration = videoDuration.replace("H", "시간 ");
        videoDuration = videoDuration.replace("M", "분 ");
        videoDuration = videoDuration.replace("S", "초");

        return videoDuration;
    }