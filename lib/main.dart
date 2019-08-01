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
  runApp(MyGame().widget);
}

class MyGame extends Game{
  Enemy enemy;
  Sprite sprite;
  Size screenSize;
  Rect emmemy;
  @override

  MyGame(){
    enemy=new Enemy();
    enemy.x=200;
    enemy.y=200;
    sprite=new Sprite('enemy.png');
    emmemy=Rect.fromLTWH(100, 100, 30, 30);
  }
  void render(Canvas canvas) {
    var rect= new Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    var paint = new Paint();
    paint.color = new Color(0xFFFF0000);
    //canvas.drawPaint(paint);
    //var img;
    //img=Flame.images.load("enemy.png");

    //sprite.render(canvas,100,100);
    TextConfig textConfig=TextConfig(fontSize: 30,color: BasicPalette.white.color,fontFamily: 'Arial',textAlign: TextAlign.center);
    //var text=new Text(10,10);
    canvas.drawRect(rect, paint);
    textConfig.render(canvas, "XDXDXDXD", Position(10,10));
    sprite.renderRect(canvas, emmemy);
    //canvas.drawImage(img,Offset(10, 10),paint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }
}
class Enemy extends SpriteComponent{
  Enemy():super.square(128.0,'enemy.png'){
    this.angle=0.0;
  }
}

