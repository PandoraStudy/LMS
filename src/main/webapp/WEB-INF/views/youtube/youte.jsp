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
				var playlist_title = "<h2>" + title + "</h2>";
				var playlist_sub_title = "<p>" + description + "</p>";
				$("#playlist_title").append(playlist_title);
				$("#playlist_sub_title").append(playlist_sub_title);
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
		</tr>
		<tr>
			<td></td>
		</tr>
	</table>
<!-- <div id="playlist"></div> -->
</body>
</html>