    let wsmsg = new WebSocket('ws:/172.30.1.89/user');

    wsmsg.onopen = function(event) {
        console.log("WebSocket 연결이 열렸습니다.");
        wsmsg.send(name+"님이 들어오셨습니다.");
    };
    wsmsg.onmessage = async function(event) {
        try {
            if (event !== null && event !== undefined) {
                let ls = event.data.split("님");
                let data_name = ls[0];
                let data_content = ls[1];
                if(data_content === "이 들어오셨습니다."){
                    $("#messageBox").append(
                        "<div class='messageName' style='text-align: left;'>"+event.data+"</div>"+
                        "<div></div>"
                    );
                }
                else if(data_name===name && data_content !== "이 들어오셨습니다."){
                    $("#messageBox").append(
                        "<div class='messageName'>"+data_name+"</div>"+
                        "<div class='messageBody'>"+data_content+"</div><br><br>"
                    );
                }else if(data_name !==name && data_content !== "이 들어오셨습니다."){
                    $("#messageBox").append(
                        "<div class='messageName' style='text-align: left;'>"+data_name+"</div>"+
                        "<div class='messageBody' style='float:left;'>"+data_content+"</div><br><br>"
                    );

                };
                $("#messageBox").scrollTop($("#messageBox")[0].scrollHeight);
            }
        } catch (err) {
            console.log(err);
        }
    };
    wsmsg.onclose = function(event) {
        console.log('WebSocket 연결이 닫혔습니다.');
    };
    function disconnect(){
        wsmsg.close();
    }


