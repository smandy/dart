// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math';
//import 'package:simplot/simplot.dart';

CanvasElement canvas;
CanvasRenderingContext2D context;
dynamic values;
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

  values = querySelector("#values");

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

String makeTable( Iterable<Iterable<String>> rows) {
  StringBuffer ret = new StringBuffer();
  ret.write("<TABLE>\n");
  for( Iterable<String> row in rows) {
    ret.write("<TR>");
    row.forEach( (x) => ret.write("<TD>$x</TD>"));
    ret.write("</TR>\n");
  }
  ret.write("</TABLE>");
  return ret.toString();
}

redraw() {
    int width  = canvas.width;
    int height = canvas.height;
    
    int length = (width / 2.0).toInt();
    double theta = 0.0;
    double oldX = 50.0, oldY = 50.0;
    context.lineWidth = 0.5;
    context.clearRect(0,0,width,height);
    context.beginPath();

    context.moveTo(oldX, oldY);

    while (length > 10) {
      double newX = oldX + length * cos(theta);
      double newY = oldY + length * sin(theta);
      context.lineTo( newX, newY);
      oldX = newX;
      oldY = newY;
      theta += (2 * PI / 360.0) * thetaDiff;
      length *= lineFract;
    }
    values.innerHtml = makeTable(
        [["theta"   , thetaDiff.toString()],
        ["lineFract", lineFract.toString()],
        ["lastValue", lastValue.toString() ] ] );
    context.stroke();
    context.closePath();
}
