
class Grid {
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
}

test( List<int> xs ) {
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
}

