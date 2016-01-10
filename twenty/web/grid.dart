
import 'package:quiver/core.dart';

class Grid {
}

List<int> nums = new List.generate(4, (x) => x);


Map<String,List<List<Point>>> moves = makeMoves();

var left = moves["left"];
var right = moves["right"];
var up = moves["up"];
var down = moves["down"];

List<Point> makeAllPoints() {
  List<Point> ret = new List<Point>();
    for (int y in nums) {
      for (int x in nums) {
      ret.add( new Point(x,y));
    }
  }
  return ret;
}

List<Point> allPoints = makeAllPoints();

void dump( Map<Point,int> m) {
  StringBuffer tmp = new StringBuffer();
  for (int i = 0;i<16;++i) {
    if (i % 4 == 0) {
      print(tmp.toString());
      tmp.clear();
    }
    var tmp2 = m[allPoints[i]];
    tmp.write( tmp2 == null ? "0" : tmp2 );
    tmp.write(" ");
  }
  print (tmp.toString());
}

Map<Point,int> doMap( Map<Point,int> x , String direction) {
  List<List<Point>> rows = moves[direction];
  var ret = new Map<Point,int>();
  for (Point p in x.keys) {
    ret[p] = x[p];
  }
  for (List<Point> row in rows ) {
    while(true) {
      bool haveMotion = false;
      for (int a = 2;a>=0;--a) {
        int b = a+1;
        Point pa = row[a];
        Point pb = row[b];
        int getA = ret[pa];
        int getB = ret[pb];

        if (getA != null && getB == null) {
          ret[pb] = getA;
          ret.remove(pa);
          haveMotion = true;
        } else if (getA != null && getA==getB) {
          ret[pb] = getB*2;
          ret.remove(pa);
          haveMotion = true;
        }
      }
      if (!haveMotion) break;
    }
  }
  return ret;
}


makeMoves() {
  List<List<Point>> right = new List<List<Point>>();
  for (int y in nums) {
    var row = new List<Point>();
    for (int x in nums) {
      row.add( new Point(x,y));
    }
    right.add( row );
  }
  List<List<Point>> left = right.reversed.toList();

  List<List<Point>> down = new List<List<Point>>();
  for (int y in nums) {
    var row = new List<Point>();
    for (int x in nums) {
      row.add( new Point(x,y));
    }
    left.add( row );
  }

  List<List<Point>> up = down.reversed.toList();
  return  { "left" : left, "right" : right, "up" : up, "down" : down};
}

List<int> move( List<int> xs) {
  var ret = xs.map( (x) => x ).toList();
  while(true) {
    bool haveMotion = false;
    for (int a = 2, b = 3; a>=0;--a,--b) {
      if (ret[a] > 0 && ret[b] == 0) {
        haveMotion = true;
        ret[b] = ret[a];
        ret[a] = 0;
      } else if (ret[b] > 0 && ret[a] == ret[b]) {
        ret[b] *= 2;
        ret[a] = 0;
        haveMotion = true;
      }
    }
    if (!haveMotion) break;
  }
  return ret;
}

class Point {
  int _x;
  int _y;

  Point([ int x = 0, int y = 0]) {
    _x = x;
    _y = y;
  }

  Point.copy( Point rhs) {
    _x = rhs.x;
    _y = rhs.y;
  }

  int get x => _x;
  int get y => _y;

  Point operator+( Point rhs) {
    return new Point( rhs.x + x, rhs.y + y);
  }

  @override
  String toString() => "Point($x,$y)";

  bool operator ==(o) => o is Point && o.x == x && o.y == y;
  int get hashCode => hash2(x.hashCode, x.hashCode);
}


test( List<int> xs) {
  var ret = move(xs);
  print("$xs -> $ret");
}

main() {
  var x = new Point(2,3);
  var y = new Point(3,4);
  var z = new Point.copy(x);

  print("x = $x");
  print("y = $y");
  print("z = $z");

  test( [ 0,0,0,0]);
  test( [ 0,0,0,1]);
  test( [ 0,0,1,0]);
  test( [ 0,1,0,0]);
  test( [ 1,0,0,0]);
  test( [ 1,1,0,0]);
  test( [ 1,0,0,1]);
  test( [ 1,0,1,1]);
  test( [ 0,1,1,2]);

  var x3 = makeMoves();
  print("moves are $x3");

  Map<Point,int> myMap = new Map<Point,int>();

  myMap[ new Point(0,0)] = 2;
  myMap[ new Point(1,0)] = 1;
  myMap[ new Point(2,0)] = 1;


  myMap[ new Point(2,1)] = 1;
  myMap[ new Point(3,2)] = 2;
  myMap[ new Point(2,2)] = 2;
  myMap[ new Point(3,3)] = 1;
  dump(myMap);

  for (String direction in ["left","right", "up", "down"]) {
    print("direction is $direction");
    print( moves[direction]);
    var x5 = doMap(myMap, direction);
    dump(x5);
  }

  print( allPoints);
  print( allPoints[0]==new Point(0,0));
  print( allPoints[0]==allPoints[1]);
}

