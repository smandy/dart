// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'grid.dart';

class Twenty {
  CanvasElement canvas;
  CanvasRenderingContext2D context;

  Grid grid;
  
  Twenty() {
    canvas = document.querySelector('#canvas');
    context = canvas.getContext('2d');
    grid = new Grid();
  }

  void redraw() {
    context.clearRect(0,0,200,200);
    context.beginPath();
    context.moveTo(20,20);
    context.lineTo(20,20);
    context.closePath();
  }
  
}



void main() {

  new Twenty();
  //querySelector('#output').text = 'Your Dart app is running.';
}
