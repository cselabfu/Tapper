import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  new MyGame().start()
);

class MyGame extends Game{
  Widget start() {re}

  @override
  void render(Canvas canvas) {
    var rect= new Rect.fromLTWH(10, 10, 10, 10);
    var paint = new Paint();
    paint.color = new Color(0xFFFF0000);
    canvas.drawRect(rect, paint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
