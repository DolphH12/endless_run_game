import 'dart:async';

import 'package:endless_run_game/obstacles/obstacle.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../main.dart';

class Player extends SpriteAnimationGroupComponent
    with HasGameRef, CollisionCallbacks {
  bool isOnGround = false;
  static double gravity = 400;
  Vector2 velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    animations = {
      'run': await game.loadSpriteAnimation(
        'Animations/Run.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      ),
      'jump': await game.loadSpriteAnimation(
        'Animations/Jump.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      ),
    };

    current = 'run';

    anchor = Anchor.center;
    size = Vector2.all(50);
    position = Vector2(100, 100);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!isOnGround) {
      velocity.y += gravity * dt;
    }

    position += velocity * dt;

    if (position.y > MyGame.sceneSize.y - 70) {
      position.y = MyGame.sceneSize.y - 70;
      velocity.y = 0;
      isOnGround = true;
    }
  }

  void jump() {
    if (isOnGround) {
      velocity.y = -200;
      isOnGround = false;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Obstacle) {
      print('Has perdido!!!');
      game.pauseEngine();
    }
  }
}
