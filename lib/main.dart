import 'dart:math';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


void main() async{
  Flame.images.loadAll(<String>['enemy.png','background.png']);
  var dim=await Flame.util.initialDimensions();
  var game=new MyGame(dim);
  runApp(game.widget);
  Flame.util.addGestureRecognizer(new TapGestureRecognizer()..onTapDown=(TapDownDetails event)=>game.input(event.globalPosition.dx,event.globalPosition.dy));
}

class MyGame extends Game{
  List<Enemy> enemies=[];
  Size screenSize;
  Rect emmemy;
  @override

  MyGame(Size dim){
    screenSize=dim;
    enemies.add(new Enemy(screenSize));
    emmemy=Rect.fromLTWH(100, 100, 30, 30);
  }
  void render(Canvas canvas) {
    var rect= new Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    var paint = new Paint();
    paint.color = new Color(0xF00F0F30);
    canvas.drawRect(rect, paint);
    enemies.forEach((Enemy)=>Enemy.render(canvas));
    //enemies.first.render(canvas);
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

  void createEnemy(){
    enemies.add(new Enemy(screenSize));
  }

  void input(double x, double y) {
    enemies.forEach((Enemy){
      if(Enemy.collisionCheck(x, y))
        createEnemy();
        print(enemies.length);
    });
  }

}
class Enemy extends SpriteComponent {
  Size dim;
  Enemy(Size sc):super.square(100,'enemy.png'){
    Random random=Random();
    dim=sc;
    this.x=random.nextDouble()*200;
    this.angle=0.0;
    this.y=dim.height-100;
  }
  @override
  void update(double t) {
    super.update(t);
    y+=t*100;
    if(y>dim.height){
      y=-40;
    }
  }
  bool collisionCheck(double x,double y){
    if(this.x<x&&this.x+this.width>x){
      if(this.y<y&&this.y+this.height>y)
        return true;
    }
    return false;
  }
}

