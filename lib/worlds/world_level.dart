import 'dart:async';

import 'package:endless_run_game/main.dart';
import 'package:endless_run_game/obstacles/obstacle.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/parallax.dart';

import '../players/player.dart';

class WorldLevel extends World with TapCallbacks {
  late Player player;
  double obstacleTimer = 0;
  int score = 0;
  double gameSpeed = 200;

  @override
  Future<void> onLoad() async {
    add(await loadParallaxComponent());

    player = Player();
    add(player);
  }

  Future<ParallaxComponent> loadParallaxComponent() async {
    return ParallaxComponent.load(
      [
        ParallaxImageData('Sprites/Game Objects/Background.png'),
        ParallaxImageData('Sprites/Game Objects/Foreground.png'),
      ],
      baseVelocity: Vector2(30, 0),
      velocityMultiplierDelta: Vector2(1.5, 1),
      size: MyGame.sceneSize,
    );
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    player.jump();
  }

  @override
  void update(double dt) {
    super.update(dt);

    gameSpeed += 1 * dt;

    children.query<Obstacle>().forEach((obstacle) {
      //obstacle.position.x -= gameSpeed * dt;
    });

    obstacleTimer += dt;
    if (obstacleTimer > (2 - gameSpeed / 500)) {
      add(Obstacle.generate());
      obstacleTimer = 0;
    }

    score += (dt * 10).toInt();
  }
}
