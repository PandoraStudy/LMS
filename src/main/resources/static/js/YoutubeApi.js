import { API_KEY } from './apikey.js';//API_KEY





$(function(){

	/*
	 */
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
				console.log(playlist);
				//DB에 재생목록 및 데이터 보내기
				pool.getConnection().then(conn => {
					console.log("DB연결성공");
					/*
					conn.query("INSERT INTO ESTBL_SBJCT (SBJCT_NO, CRCLM_CD, CRCLM_CYCL, SBJCT_NM, SBJCT_EXPLN, EDU_HR, SBJCT_PLAN_YN, ESNTL_YN) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
					, [1, 1, 1, channelTitle, description])
						.then(result => {
							console.log("Data inserted");
						})
						.catch(error => {
							console.log(error);
						})
						.finally(() => {
							conn.release(); // 연결 반환
						});
					 */
					}).catch(error => {
						console.log(error);
					});
			}
		}, error: function(jqXHR, textStatus, errorThrown) {
		    console.log(jqXHR.responseJSON.error.message);
		}
	})
});