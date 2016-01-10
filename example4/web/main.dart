import 'dart:html';

import 'dart:convert';

class Handler {
  WebSocket socket;
  Map<String,Function>

  onTextMessage( dynamic js) {
    print('Received a $js');
    var xs = querySelector("#menu").text = js;
    //var ys = querySelector("#menu").getElementsByClassName()
    print( xs);
  }

  onServerInfo(dynamic js) {
    List<String> peers = js["peers"];
    List<String> clients = js["clients"];
    var time = js["time"];
    var qs = querySelector("#content");
    //var names = clients.map( (c) => c.name );
    qs.text = "Have ${time} ${clients.length} clients ${clients} and ${peers.length} peers ${peers}";
  }

  Handler() {
    var handlers = {
      "textMessage" : this.onTextMessage,
      "serverInfo"  : this.onServerInfo
    };
    
    socket = new WebSocket('ws://127.0.0.1:8888/websocket');
    socket.onOpen.listen( (MessageEvent e) {
      String strNow = new DateTime.now().toIso8601String();
      String e = JSON.encoder.convert( { "type" : "logon" , "id" : strNow } );
      socket.send( e);
    });

    socket.onMessage.listen( ( MessageEvent s ) {
      print('Socket received $s');
      var x = JSON.decode( s.data);
      querySelector('#output').text = "Socket sent $s ${s.type} ${s.data}";
      String type = x["type"];
      if (handlers.containsKey(type)) {
        var target = handlers[type];
        target(x);
      }
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
