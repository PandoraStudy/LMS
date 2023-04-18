<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YouTube</title>
</head>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
$().ready(function(){
	$.ajax({
		url: "https://www.googleapis.com/youtube/v3/videos?id=7lCDEYXw3mM&key="키"&part=snippet,contentDetails,statistics,status",
		type: "get", 
		datatype: "json",
		success: function(data){
			console.log(data)
			/*
			"kind": "youtube#videoListResponse",
			"etag": "\"UCBpFjp2h75_b92t44sqraUcyu0/sDAlsG9NGKfr6v5AlPZKSEZdtqA\"",
			"videos": [{
				"id": "7lCDEYXw3mM",
				"kind": "youtube#video",
				"etag": "\"UCBpFjp2h75_b92t44sqraUcyu0/iYynQR8AtacsFUwWmrVaw4Smb_Q\"",
				"snippet": { 
					"publishedAt": "2012-06-20T22:45:24.000Z",
					"channelId": "UC_x5XG1OV2P6uZZ5FSM9Ttw",
					"title": "Google I/O 101: Q&A On Using Google APIs",
					"description": "Antonio Fuentes speaks to us and takes questions on working with Google APIs and OAuth 2.0.",
					"thumbnails": {
						"default": {
							"url": "https://i.ytimg.com/vi/7lCDEYXw3mM/default.jpg"
			 			},
						"medium": {
							"url": "https://i.ytimg.com/vi/7lCDEYXw3mM/mqdefault.jpg"
						},
						"high": {
							"url": "https://i.ytimg.com/vi/7lCDEYXw3mM/hqdefault.jpg"
						}
					},
					"categoryId": "28"
					},
					"contentDetails": {
					"duration": "PT15M51S",
					"aspectRatio": "RATIO_16_9"
					},
					"statistics": {
					"viewCount": "3057",
					"likeCount": "25",
					"dislikeCount": "0",
					"favoriteCount": "17",
					"commentCount": "12"
					},
					"status": {
					"uploadStatus": "STATUS_PROCESSED",
					"privacyStatus": "PRIVACY_PUBLIC"
					}
				}
			]
			*/
		}
	})
})
</script>
<body>
	<h1>youtube화면</h1>
	<button onclick="UBtn">버튼</button>
</body>
</html>