import 'dart:html';

void main() async {
  querySelector('#output').text = 'Woot1';
  querySelector('#output2').text = 'Woot';
  
  var socket = new WebSocket('ws://127.0.0.1:8888/websocket');
  
  socket.onOpen.listen( (MessageEvent e) {
    socket.send('Hello, from dart!');
  });
  
  socket.onMessage.listen( (MessageEvent s ) {
    print('Socket received $s');
    querySelector('#output').text = "Socket sent $s ${s.type} ${s.data}";
  });

  socket.onClose.listen( (Event e) {
    querySelector("#output").text = "Socket disconnected :-(";
  });
}
