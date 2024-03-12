import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'dart:math';

class ProgressEffects extends PositionComponent with HasGameRef {
  String name;
  String name2;
  ProgressEffects({required this.name, required this.name2});

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(ParticleSystemComponent(particle: acceleratedParticles()));
    add(ParticleSystemComponent(particle: spawnParticles()));
    priority = 10;
  }

  Particle spawnParticles() {
    final rnd = Random();
    final rndDirx = Random().nextDouble();

    return Particle.generate(
        lifespan: 10,
        count: 2,
        generator: (i) {
          // double rand = Random().nextDouble();
          final initialSpeed =
              Vector2(rnd.nextDouble() * 200 - 100, -rnd.nextDouble() * 100);
          // final initialSpeed = Vector2(rand * 600 - 300, -rand * 600) * .2;
          final deceleration = initialSpeed * -1;
          final gravity = Vector2(rndDirx * 40, 100);

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
              ? Sprite(game.images.fromCache(name))
              : Sprite(game.images.fromCache(name2)),
          size: Vector2(randSize, randSize),
        ));
  }

  Particle imageParticle() {
    return ImageParticle(
      size: Vector2.all(24),
      image: game.images.fromCache(name),
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
