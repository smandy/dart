
abstract class Foo {
  void doit();

  void doit2() {
    print("Woot");
  }
}

abstract class BattyBoy {
  aie() {
    print("aie");
  }
}

class FooImpl extends Foo implements BattyBoy {
  @override
  void doit() {
    print("FooImpl.doit()");
  }

  @override
  aie() {
    print("Aie");
  }
}

class Impl2 extends Foo implements BattyBoy {
  @override
  void doit() {
    print("Foo impl2");
  }

  @override
  aie() {
    // TODO: implement aie
  }
}

foo( int x, [ int y = 20, int z = 30 ]) {
  print( "foo $x $y $z");
}

foo2( int x , { int y : 30, int z : 42}) {
  print( "foo2 $x $y $z");
}

main() {
  List<Foo> myFoos = [ new FooImpl(), new Impl2() ];

  List<BattyBoy> myFoos2 = [ new FooImpl(), new Impl2() ];

  myFoos.forEach( (x) => x.doit());
  myFoos2.forEach( (x) => x.aie());

  List<int> nums = new Iterable.generate(10, (x) => x * 2 ).toList();
  print(nums);
  List<String> as = ["foo", "bar", "baz", "fluff"].where( (x) => x.startsWith("f")).toList();
  print(as);

  foo(10);
  foo(10,11);
  foo(10,11,12);

  foo2( 20 );
  foo2( 20, y : 32);
  foo2( 21, z : 50);
  foo2( 21, y : 21, z : 50);
}
