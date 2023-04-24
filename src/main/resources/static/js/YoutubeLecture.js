//import { API_KEY } from './apikey.js';//API_KEY
const API_KEY = "AIzaSyC3jBgAkdrvenbwtH_ZY1AHCts4gIUor90";

$(function(){
	//lecture
	
	let channelId = "UCx6jsZ02B4K3SECUrkgPyzg";//놀면뭐하니
	//let channelId = "UC5s_Ei99uCIsArS1Zle4lRA";//동영
	//let channelId = "UC5s_Ei99uCIsArS1Zle4lRA";//정목

	$.get({
		url: "https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=" + channelId + "&key=" + API_KEY+"&maxResults=9",
		dataType: "json",
		success: function (playlists) {

			var playlists = playlists.items;
			
			for (var i = 0; i < playlists.length; i++) {
				var playlist = playlists[i];
				var id = playlist.id;//id코드
				
				//snippet localized
				var channelId = playlist.snippet.channelId;//세부강의코드
				var channelTitle = playlist.snippet.title;//과목명
				var description = playlist.snippet.description || "";//과목설명
				//console.log(playlist);
				//console.log(id);
				//console.log(channelId);
				//console.log(channelTitle);
				//console.log(description);
				
				//없애야함
				/*
				// 실제 사용자에게 보여주기 위해 append 처리할 <tr> 생성
				let $tr = $("<tr style='height:70px; line-height:70px;'>");
				
				$tr.append("<td class='text-center'><a onclick=location.href='lectureList?playlist_id=" + id + "'>"+ channelTitle + "</a>" + "</td>");
//				$tr.append("<td class='text-center'>" + SBJT_NM + "</td>");
//				$tr.append("<td class='text-center'>" + KORN_FLNM + "</td>");
// 				$tr.append("<td style='height:70px;'>"
// 			            + "<div style='height:20px; line-height: 20px;'>&nbsp;<span class='float-right' style='height:20px; margin-right:45px;'>"
// 			            + LECT_PRGRS_RT + "%"
// 			            + "</span></div>"
// 			            + "<div class='progress mb-4' style='height:20px; margin:5px 45px 24px 0;'>"
// 			            + "<div class='progress-bar bg-success' role='progressbar' style='height:20px;"
// 			            +" width: "+LECT_PRGRS_RT+"%'"
// 			            + "aria-valuenow='20' aria-valuemin='0' aria-valuemax='100'></div>"
// 			            + "</div>"
// 			            + "</td>");
				$("#tb_lecture").append($tr);
				*/
				$.post({
					url: "/youtubeData",
					data: {id: id, channelTitle: channelTitle, description: description},
					success: function(data){
						//console.log("data : " + data);
					}, error: function (xhr, status, error) {
						//console.log(xhr.responseText);
					}
				});
			}
			
		}, error: function(jqXHR, textStatus, errorThrown) {
		    console.log(jqXHR.responseJSON.error.message);
		}
	})
});