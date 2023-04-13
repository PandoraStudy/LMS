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
	
	let channelId = "UCx6jsZ02B4K3SECUrkgPyzg";
	
	$.get({
		url: "https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=" + channelId + "&key=" + API_KEY+"&maxResults=50",
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
				var playlist_id = playlist.id;
				//console.log(playlist_id);
				
				document.postList.playlist_id.value = playlist_id;
				
				$("#playlist_title").append(title);
				$("#playlist_sub_title").append(description);
			}
		}, error: function(jqXHR, textStatus, errorThrown) {
		    console.log(jqXHR.responseJSON.error.message);
		  }
	})
});
</script>
<body>
	<table>
		<tr>
			<th id="playlist_title"></th>
			<th id="playlist_sub_title"></th>
			<form action="/youtubeList" name="postList" method="get">
				<input type="hidden" name="playlist_id" value="">
			</form>
		</tr>
		<tr>
			<td></td>
		</tr>
	</table>
<!-- <div id="playlist"></div> -->
</body>
</html>