import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'dart:math';

//For Tiles
class GameEffects extends PositionComponent with HasGameRef {
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(ParticleSystemComponent(particle: acceleratedParticles()));
    add(ParticleSystemComponent(particle: spawnParticles()));
  }

  // static final effect = SequenceEffect([
  //   ScaleEffect.by(
  //     Vector2.all(1.5),
  //     EffectController(
  //       duration: 0.2,
  //       alternate: true,
  //     ),
  //   ),
  //   ScaleEffect.to(
  //     Vector2.all(0.1),
  //     EffectController(duration: 0.5),
  //   ),
  // ]);

  // void removeTileSequence() {
  //   add(ParticleSystemComponent(particle: spawnParticles()));
  // }

  Particle spawnParticles() {
    // final particles = <Particle>[];
    final rnd = Random();
    final rndDirx = Random().nextDouble();

    return Particle.generate(
        lifespan: 10,
        count: 10,
        generator: (i) {
          // double rand = Random().nextDouble();
          final initialSpeed =
              Vector2(rnd.nextDouble() * 200 - 100, -rnd.nextDouble() * 100);
          // final initialSpeed = Vector2(rand * 600 - 300, -rand * 600) * .2;
          final deceleration = initialSpeed * -1;
          final gravity = Vector2(rndDirx * 40, 200);

          return AcceleratedParticle(
              position: Vector2.zero(),
              speed: initialSpeed,
              acceleration: deceleration + gravity,
              child: spriteParticle());
        });
  }

  Particle spriteParticle() {
    int rand = Random().nextInt(2);
    double rand2 = Random().nextDouble();
    double randSize = Random().nextInt(24) + 16;
    return RotatingParticle(
        from: rand2 * pi,
        child: SpriteParticle(
          lifespan: 8,
          sprite: rand == 0
              ? Sprite(game.images.fromCache('Flower.png'))
              : Sprite(game.images.fromCache('Flower_2.png')),
          size: Vector2(randSize, randSize),
        ));
  }

  Particle imageParticle() {
    return ImageParticle(
      size: Vector2.all(24),
      image: game.images.fromCache('Flower_2.png'),
    );
  }

  Particle rotatingImage({double initialAngle = 0}) {
    return RotatingParticle(from: initialAngle, child: imageParticle());
  }

  Particle acceleratedParticles() {
    double rand = Random().nextDouble();
    return Particle.generate(
      lifespan: 10,
      count: 20,
      generator: (i) => AcceleratedParticle(
        speed: Vector2(rand * 600 - 300, -rand * 600) * .2,
        acceleration: Vector2(0, 200),
        child: rotatingImage(initialAngle: rand * pi),
      ),
    );
  }
}
