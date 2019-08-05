import 'dart:math';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
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
  int points=0;
  int enemySpeed=100;
  double increaseCounter=0;
  List<Enemy> enemies=[];
  Size screenSize;
  Rect emmemy;
  @override

  MyGame(Size dim){
    screenSize=dim;
    enemies.add(new Enemy(screenSize,enemySpeed));
    emmemy=Rect.fromLTWH(100, 100, 30, 30);
  }
  void render(Canvas canvas) {
    canvas.save();
    var rect= new Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    var backpoint= new Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    TextConfig textConfig=TextConfig(fontSize: 100,color: BasicPalette.white.color,fontFamily: 'Arial',textAlign: TextAlign.center);
    var paint = new Paint();
    paint.color = new Color(0xF00F0F30);
    canvas.drawRect(rect, paint);
    textConfig.render(canvas, String.fromCharCode(points),Position.fromInts(10, 10)) ;
    enemies.forEach((Enemy){
      Enemy.render(canvas);
      canvas.restore();
      canvas.save();
    });
    //enemies.first.render(canvas);
    //sprite.renderRect(canvas, emmemy);
  }

  @override
  void update(double t) {
    enemies.forEach((Enemy)=>Enemy.update(t));
    increaseCounter+=t;
    if(increaseCounter>=1) {
      enemySpeed+=5;
      increaseCounter=0;
      createEnemy(enemySpeed);
    }
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

  void createEnemy(int enemySpeed){
    enemies.add(new Enemy(screenSize,enemySpeed));
  }

  void input(double x, double y) {
    enemies.removeWhere((Enemy) {
      return (Enemy.collisionCheck(x, y));
    });
  }

}
class Enemy extends SpriteComponent {
  Size dim;
  int eSpeed;
  Enemy(Size sc, int enemySpeed):super.square(100,'enemy.png'){
    Random random=Random();
    dim=sc;
    eSpeed=enemySpeed;
    this.x=random.nextDouble()*300;
    this.angle=0.0;
    this.y=-100;
  }
  @override
  void update(double t) {
    super.update(t);
    y+=t*eSpeed;
    if(y>dim.height){
      y=-100;
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

