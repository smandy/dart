// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math';

CanvasElement canvas;
CanvasRenderingContext2D context;

double lineFract = 0.99;
double thetaDiff = 91.0;

String lastValue = "None";



void valueChanged(Event e) {
  redraw();
}

void main() {
  canvas = document.querySelector('#canvas');
  context = canvas.getContext('2d');

  querySelector("#theta").onInput.listen( (Event e) => setTheta( getDoubleFromEvent(e)) ); //double.parse(e.target.)) );
  querySelector("#lineFract").onInput.listen( (Event e) => setLineFract( getDoubleFromEvent(e))); //double.parse(e.target.value) );

  redraw();
}

double getDoubleFromEvent(Event e) {
  var tmp= (e.target as InputElement).value;
  lastValue = tmp;
  return double.parse( tmp);
}

void setTheta( double x ) {
  thetaDiff = x;
  redraw();
}

void setLineFract(double x ) {
  lineFract = x;
  redraw();
}

redraw() {
    int width  = canvas.width;
    int height = canvas.height;
    int length = width;
    double theta = 0.0;

    double oldX = 0.0, oldY = 0.0;
    bool firstRun = true;
    context.lineWidth = 1;
    context.clearRect(0,0,width,height);
    context.beginPath();

    while (length > 10) {
      double newX = oldX + length * cos(theta);
      double newY = oldY + length * sin(theta);
      if (firstRun) {
        context.moveTo( newX, newY);
        firstRun = false;
      } else {
        context.lineTo( newX, newY);
      }
      oldX = newX;
      oldY = newY;
      theta += (2 * PI / 360.0) * thetaDiff;
      length *= lineFract;
    }

    context.font = "30pt Consalas";
    context.fillStyle = "blue";
    context.fillText("theta = $thetaDiff\nlineFract=$lineFract\n", 30,30);
    context.fillText("lastValue=$lastValue", 30,50);

    context.stroke();
    context.closePath();
}
