import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import '../game.dart';

import './explosion_component.dart';

class EnemyComponent extends SpriteAnimationComponent with HasGameRef<SpaceShooterGame>, Hitbox, Collidable {

  static const enemy_speed = 150;

  bool destroyed = false;

  EnemyComponent(double x, double y): super(position: Vector2(x, y), size: Vector2.all(25)) {
    addShape(HitboxRectangle());
    collidableType = CollidableType.passive;
  }

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
        'enemy.png',
        SpriteAnimationData.sequenced(
            stepTime: 0.2,
            amount: 4,
            textureSize: Vector2.all(16),
        ),
    );
    collidableType = CollidableType.passive;
  }

  @override
  void update(double dt) {
    super.update(dt);

    y += enemy_speed * dt;
    shouldRemove = destroyed || y >= gameRef.size.y;
  }


  void takeHit() {
    destroyed = true;

    gameRef.add(ExplosionComponent(x - 25, y - 25));
    gameRef.increaseScore();
  }

}

