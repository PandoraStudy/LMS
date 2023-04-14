<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>유튜브 디테일 테스트 화면</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>

<body>
<div style="width: 1280px; height: 720px; background-color: #ccc;" id="youtubePlayer"></div>
<br>
<a href="/youtubeList">유튜브 플레이리스트로</a>
<br>
<h1>
    총 재생시간 : console.log("동영상 총 재생 시간 : " + player.getDuration()); <br>
    할 일<br>
    1. 추천 영상 및 추가 동영상이 나오기 전에 동영상을 끝내기 (업로드 시 사용자가 직접 정하는 상황인데 이걸 어느정도로 맞춰야할까?) <br>
    
    2. 리스트 별로 강의 리스트 출력 후 해당 강의 클릭 시 클릭된 강의 디테일 보여주기<br>
     - 완료

    물어볼거<br>
    동영상 더보기 제어 : 동영상 더보기 삭제를 rel : 0 으로 하는데 더이상 지원하지 않는걸로 알고 있다.
    (같은 채널의 관련 동영상을 추천한다/부분 공개일경우 해결될수도?)<br>
    
     - 통상적으로 유튜브 강의를 올릴때 가이드라인을 잡아줌 -> ex)한 강의 끝나고 5초정도의 텀을 줘라 -> 이걸로 조정<br>
     
    아니면 동영상 업로드 시 제한 (최종화면 추가 : 동영상이 끝날 때 관련 콘텐츠를 홍보합니다를 체크 안하도록?)<br>
    화면 제어를 어떻게 할지(모든게 다 사라짐) 키보드를 막는것도 어떻게 할지
    
     - 동영상 업로드 페이지에서 "고급 설정"으로 이동한 다음, "컨트롤 및 기능" 섹션에서
    "일시정지 후 추천 동영상 표시" 항목을 선택 취소하면 됩니다.
    이렇게 설정하면, 해당 동영상이 일시정지될 때 동영상 더보기 버튼이 나타나지 않으며, 추천 동영상도 표시되지 않습니다.


    생각할거<br>
    동영상을 다 보고 다시 강의를 들어갈 경우<br>
     - 다 본 기록이 있으면 동영상제어 했던걸 안먹히게 ex)다봤을때 수료 퍼센테이지 나누는 데이터를 가지고 조절<br>
    비디오 실행 방법 로딩 완료시 바로 실행? 아니면 사용자가 실행? 유튜브에서 보기가 뜸<br>
     - 통상적으로 사용자가 실행했을 경우 실행
</h1>
</body>
</html>
