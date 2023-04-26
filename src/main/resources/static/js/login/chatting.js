    let wsmsg = new WebSocket('ws:/172.30.1.9/user');

    wsmsg.onopen = function(event) {
        console.log("채팅이 열렸습니다.");
        wsmsg.send(name+"님이 들어오셨습니다.");
    };
    wsmsg.onmessage = async function(event) {
        try {
            if (event !== null && event !== undefined) {
                let ls = event.data.split(":",1);
                console.log(ls);
                let data_name = ls[0];
                let data_content = event.data.substring(ls[0].length + 1);
                if(data_name === name+"님이 들어오셨습니다."){
                    $("#messageBox").append(
                        "<div class='messageName' style='text-align: left;'>"+data_name+"</div>"
                    );
                }
                else if(data_name===name){
                    $("#messageBox").append(
                        "<div class='messageName'>"+data_name+"</div>"+
                        "<div class='messageBody'>"+data_content+"</div><br><br>"
                    );
                }else if(data_name !==name){
                    $("#messageBox").append(
                        "<div class='messageName' style='text-align: left;'>"+data_name+"</div>"

                    );
                    if(data_content !== "") {
                        $("#messageBox").append(
                            "<div class='messageBody' style='float:left;'>"+data_content+"</div><br><br>"
                        );
                    }
                };
                $("#messageBox").scrollTop($("#messageBox")[0].scrollHeight);
            }
        } catch (err) { console.log(err); }
    };
    wsmsg.onclose = function(event) { console.log('채팅이 닫혔습니다.'); };
    function disconnect(){ wsmsg.close(); }


