import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}

class MyGame extends FlameGame with TapDetector {
  int points = 0;
  int enemySpeed = 100;
  double increaseCounter = 0.0;
  late TextComponent pointsText;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load and add the background
    final backgroundSprite = await loadSprite('background.png');
    final background = SpriteComponent()
      ..sprite = backgroundSprite
      ..size = size; // Ensures the background covers the entire screen
    add(background);

    // Initialize and add the points text
    pointsText = TextComponent(
      text: 'Points: $points',
      textRenderer: TextPaint(
        style: TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontFamily: 'Awesome Font',
        ),
      ),
      position: Vector2(10, 10),
    );
    add(pointsText);

    // Add the initial enemy
    createEnemy(enemySpeed);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update the enemy speed and spawn rate
    increaseCounter += dt;
    if (increaseCounter >= 0.4) {
      enemySpeed += 45;
      increaseCounter = 0;
      createEnemy(enemySpeed);
    }

    // Update the points display
    pointsText.text = 'Points: $points';
  }

  /// Creates and adds a new enemy to the game
  void createEnemy(int speed) {
    final enemy = Enemy(speed);
    add(enemy);
  }

  @override
  void onTapDown(TapDownInfo info) {
    final tapPosition = info.eventPosition;
    handleTap(tapPosition.widget.x, tapPosition.widget.y);
  }

  /// Handles tap input by checking collision with enemies
  void handleTap(double x, double y) {
    // Find all enemies that contain the tap position
    final enemiesToRemove = children.whereType<Enemy>().where((enemy) {
      return enemy.collisionCheck(x, y);
    }).toList();

    for (var enemy in enemiesToRemove) {
      enemy.removeFromParent(); // Removes the enemy from the game
      points++; // Increment points
    }
  }
}

class Enemy extends SpriteComponent with HasGameRef<MyGame> {
  final int speed;

  Enemy(this.speed) : super(size: Vector2.all(30));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('enemy.png');

    // Position the enemy at a random x within the screen bounds and above the visible area
    position = Vector2(
      Random().nextDouble() * (gameRef.size.x - size.x),
      -size.y,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += dt * speed;

    // Remove the enemy if it moves below the screen
    if (position.y > gameRef.size.y) {
      removeFromParent();
    }
  }

  /// Checks if the given (x, y) coordinates collide with this enemy
  bool collisionCheck(double x, double y) {
    return Rect.fromLTWH(position.x, position.y, size.x, size.y)
        .contains(Offset(x, y));
  }
}
