#!/usr/bin/env dart

import 'dart:io';
  
main(List<String> args) async {
  var socket = await WebSocket.connect('ws://127.0.0.1:8888/websocket');
  socket.listen( (String s ) {
    print("Socket sent $s");
  },
      onDone: () {
    print("Socket disconnected");
  });
  socket.add('Hello, from dart!');
}
