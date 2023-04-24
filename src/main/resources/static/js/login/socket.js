
    const ws = new WebSocket('ws://localhost/SocketHandler');


    ws.onopen = function(event) {
    ws.send("나는 클라이언트야 잘 지내니?");
    console.log('WebSocket 연결이 열렸습니다.');
    };

    ws.onmessage = function(event) {
    console.log('WebSocket으로부터 수신된 메시지: ' + event.data);
    };

    ws.onclose = function(event) {
    console.log('WebSocket 연결이 닫혔습니다.');
    };