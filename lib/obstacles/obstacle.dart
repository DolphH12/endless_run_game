import 'dart:async';
import 'dart:math';

import 'package:endless_run_game/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Obstacle extends SpriteComponent with CollisionCallbacks {
  static final List<String> obstacleImages = [
    'Sprites/Game Objects/Obstacle_1.png',
    'Sprites/Game Objects/Obstacle_2.png',
    'Sprites/Game Objects/Obstacle_3.png',
    'Sprites/Game Objects/Teddy_Bear.png',
  ];
  final String image;

  Obstacle({required this.image}) : super(size: Vector2.all(30));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(image);
    anchor = Anchor.center;
    position = Vector2(MyGame.sceneSize.x, MyGame.sceneSize.y - 60);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= 200 * dt;
    if (position.x < -size.x) {
      removeFromParent();
    }
  }

  static Obstacle generate() {
    final random = Random();
    final image = obstacleImages[random.nextInt(obstacleImages.length)];
    return Obstacle(image: image);
  }
}
