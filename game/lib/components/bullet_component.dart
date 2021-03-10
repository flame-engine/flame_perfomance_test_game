import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import '../game.dart';
import './enemy_component.dart';

class BulletComponent extends SpriteAnimationComponent with HasGameRef<SpaceShooterGame> {
  static const bullet_speed = -500;

  bool destroyed = false;

  double xDirection;

  BulletComponent(double x, double y, { this.xDirection = 0.0 }): super(
      position: Vector2(x, y),
      size: Vector2(10, 20),
  );
  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation('bullet.png', SpriteAnimationData.sequenced(
      stepTime: 0.2,
      amount: 4,
      textureSize: Vector2(8, 16),
    ));
  }


  @override
  void update(double dt) {
    super.update(dt);

    y += bullet_speed * dt;
    if (xDirection != 0) {
      x += bullet_speed * dt * xDirection;
    }

    shouldRemove =  destroyed || toRect().bottom <= 0;
  }
}
