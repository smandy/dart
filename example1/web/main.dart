import 'dart:html';

import 'dart:convert';

class Handler {
  WebSocket socket;
  Map<String,Function>

  onTextMessage( dynamic js) {
    print('Received a $js');
  }

  Handler() {
    var handlers = {
      "textMessage" : this.onTextMessage
    };

    socket = new WebSocket('ws://127.0.0.1:8888/websocket');
    socket.onOpen.listen( (MessageEvent e) {
      socket.send( JSON.encode( { "type" : "textMessage" , "data" : "Hello, from dart!" } ));
    });

    socket.onMessage.listen( (MessageEvent s ) {
      print('Socket received $s');
      var x = JSON.decode( s.data);
      querySelector('#output').text = "Socket sent $s ${s.type} ${s.data}";
    });

    socket.onClose.listen( (Event e) {
      querySelector("#output").text = "Socket disconnected :-(";
    });

    querySelector('#output').text = 'Woot1';
    querySelector('#output2').text = 'Woot';
  }
}

main() async {
  new Handler();

}
