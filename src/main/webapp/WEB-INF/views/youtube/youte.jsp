<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<%-- API Key값 --%>
    <script src="js/apikey.js"></script>
</head>
<script type="text/javascript">
$(function(){
	
	//let channelId = "UCx6jsZ02B4K3SECUrkgPyzg";//놀면뭐하니
	let channelId = "UC5s_Ei99uCIsArS1Zle4lRA";//동영
	//let channelId = "UC5s_Ei99uCIsArS1Zle4lRA";//정목
	
	$.get({
		url: "https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=" + channelId + "&key=" + API_KEY+"&privacyStatus=unlisted&maxResults=50",
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
<body>
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
</body>
</html>