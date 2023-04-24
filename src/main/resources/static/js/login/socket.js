    const ws = new WebSocket('ws:/localhost/user');

    ws.onopen = function(event) {
        console.log("WebSocket 연결이 열렸습니다.");
    };

    let result;
    let price;
    ws.onmessage = async function(event) {
        try {
            if (event !== null && event !== undefined) {
                $("#messageBox").append(
                    "<div class='messageBody'>"+
                    event.data+"</div>"
                );
                //alert(event.data);
                //result = await JSON.parse(event.data);
                //price = result[0];
                //document.getElementById("messageBox").innerHTML = `$ ${price}`
            }
        } catch (err) {
            console.log(err);
        }
    };
    ws.onclose = function(event) {
        console.log('WebSocket 연결이 닫혔습니다.');
    };
    function disconnect(){
        ws.close();
    }
    function msg_send(){
        let message = document.getElementById("msg").value;
        console.log(name);
        console.log(message);
            // if(id == null) alert("로그인이 되어 있지 않습니다.");
            // else
        ws.send(name+"님 : "+message);
        document.getElementById("msg").value = "";
    }


