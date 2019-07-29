import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  new MyGame().widget
);

class MyGame extends Game{
  @override
  void render(Canvas canvas) {
    var rect= new Rect.fromLTWH(100, 100, 100, 10);
    var paint = new Paint();
    paint.color = new Color(0xFFFF0000);
    canvas.drawRect(rect, paint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
