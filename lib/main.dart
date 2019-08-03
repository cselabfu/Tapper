import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';


void main() async{
  Flame.images.loadAll(<String>['enemy.png','background.png']);
  runApp(MyGame().widget);
}

class MyGame extends Game{
  List<Enemy> enemies=[];
  Size screenSize;
  Rect emmemy;
  @override

  MyGame(){
    enemies.add(new Enemy());
    emmemy=Rect.fromLTWH(100, 100, 30, 30);
  }
  void render(Canvas canvas) {
    var rect= new Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    var paint = new Paint();
    paint.color = new Color(0xF00F0F30);
    canvas.drawRect(rect, paint);
    enemies.first.render(canvas);
    //sprite.renderRect(canvas, emmemy);
  }

  @override
  void update(double t) {
    enemies.forEach((Enemy)=>Enemy.update(t));
    //if(enemy.y>screenSize.height)enemy.y=-100;
    //window.onPointerDataPacket = (packet){
      //var pointer = packet.data.first;
      //MyGame.input();
    //}
  }
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }

  void input(double x, double y) {

  }

}
class Enemy extends SpriteComponent {

  Enemy():super.square(100,'enemy.png'){
    this.angle=0.0;
    this.y=100;
  }
  @override
  void update(double t) {
    super.update(t);
    y+=t*100;
    if(y>300){
      y=0;
    }
  }
}

