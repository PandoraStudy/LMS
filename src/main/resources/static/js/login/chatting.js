    let wsmsg = new WebSocket('ws:/172.30.1.93/user');  //채팅용 소켓
    let wslist = new WebSocket('ws:/172.30.1.93/list'); //참여인원 소켓

    wsmsg.onopen = function(event) {
        console.log("채팅이 열렸습니다.");
        wsmsg.send(name+"님이 들어오셨습니다.");
    };
    wsmsg.onmessage = async function(event) {
        try {
            if (event !== null && event !== undefined) {
                let ls = event.data.split(":",1);
                let data_name = ls[0];
                let data_content = event.data.substring(ls[0].length + 1);
                data_content = data_content.replace(/</g,"&lt;").replace(/>/g,"&gt;");
                if(data_name === name+"님이 들어오셨습니다."){
                    $("#messageBox").append(
                        "<div class='messageName' style='text-align: left;'><img src='/resources/pandora_logo.png' style='width:30px; height:30px; margin-right:3px;'>"+data_name+"</div>"
                    );
                }
                else if(data_name===name){
                    $("#messageBox").append(
                        "<div class='messageName'><img src='/resources/pandora_logo.png' style='width:30px; height:30px; margin-right:3px;'>"+data_name+"</div>"+
                        "<div class='messageBody'>"+data_content+"</div><br><br>"
                    );
                }else if(data_name !==name){
                    $("#messageBox").append(
                        "<div class='messageName' style='text-align: left;'><img src='/resources/pandora_logo.png' style='width:30px; height:30px; margin-right:3px;'>"+data_name+"</div>"
                    );
                    if(data_content !== "") {
                        $("#messageBox").append("<div class='messageBody' style='float:left;'>"+data_content+"</div><br><br>");
                    }
                };
                $("#messageBox").scrollTop($("#messageBox")[0].scrollHeight);
            }
        } catch (err) { console.log(err); }
    };
    wsmsg.onclose = function(event) { console.log('채팅이 닫혔습니다.'); };

// =============================================================================================

    wslist.onopen = function(event) {
        console.log("유저가 들어왔습니다.");
        wslist.send(name);
    };
    wslist.onmessage = async function(event) {
        try { // style="width:30px; height:30px; margin-right:3px;"
            if (event !== null && event !== undefined) {
                $("#messageList").empty();  // 새로고침하거나 페이지 이동하면 갱신되게끔 하기위해서 append한 div 제거하고 새로 출력
                let list = event.data.split(" ");
                for (let i=0; i < list.length-1; i++){
                    if(list[i] !== ""){ //공백도 출력됐었는데 if문으로 출력하지 않게 조건 걸어놓으니 해결
                        $("#messageList").append(
                            "<div class='messageName' style='text-align: left;'><img src='/resources/pandora_logo.png' style='width:30px; height:30px; margin-right:3px;'>"+list[i]+"</div>"
                        );
                    }
                }
            }
        } catch (err) { console.log(err); }
    };
    wslist.onclose = function(event) {
        console.log('유저가 나갔습니다.');
    };



