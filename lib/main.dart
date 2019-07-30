import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  new MyGame().widget
);

class MyGame extends Game{
  Enemy enemy;
  @override

  MyGame(){
    enemy=new Enemy();
    enemy.x=200;
    enemy.y=200;

  }
  void render(Canvas canvas) {
    var rect= new Rect.fromLTWH(0, 0, 10, 10);
    var paint = new Paint();
    paint.color = new Color(0xFFFF0000);
    //canvas.drawPaint(paint);
    var img;
    img=Flame.images.load("enemy.jpg");

    //var text=new Text(10,10);
    canvas.drawRect(rect, paint);
    canvas.drawImage(img,Offset(10, 10),paint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
class Enemy extends SpriteComponent{
  Enemy():super.square(128.0,'enemy.jpg'){
    this.angle=0.0;
  }
}
