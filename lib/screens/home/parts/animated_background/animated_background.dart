import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

///
/// https://pub.dev/packages/simple_animations#mirroranimationbuilder
/// https://medium.flutterdevs.com/animated-background-in-flutter-5fbf821fb797
///
class PokemonAnimatedBackground extends StatelessWidget {
  final Widget child;

  const PokemonAnimatedBackground(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: AnimatedBackground()),
          const Positioned.fill(child: Particles(30)),
          child,
        ],
      ),
    );
  }
}

class Particles extends StatefulWidget {
  final int numberOfParticles;

  const Particles(this.numberOfParticles, {super.key});

  @override
  createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles> {
  final Random random = Random();
  final List<ParticleModel> particles = [];

  @override
  void initState() {
    widget.numberOfParticles.times(() => particles.add(ParticleModel(random)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoopAnimationBuilder<double>(
      tween: ConstantTween(1),
      duration: const Duration(seconds: 10),
      builder: (context, value, _) {
        _simulateParticles();
        return CustomPaint(
          painter: ParticlePainter(particles),
        );
      },
    );
  }

  _simulateParticles() {
    for (var particle in particles) {
      particle.checkIfParticleNeedsToBeRestarted();
    }
  }
}

enum _OffsetProps { x, y }

class ParticleModel {
  late MovieTween tween;
  double size = 0;
  late Duration duration;
  late Duration startTime;
  final Random random;

  ParticleModel(this.random) {
    _restart();
    _shuffle();
  }

  _restart({Duration time = Duration.zero}) {
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);

    tween = MovieTween()
      ..tween(_OffsetProps.x, startPosition.dx.tweenTo(endPosition.dx), duration: 5.seconds)
      ..tween(_OffsetProps.y, startPosition.dy.tweenTo(endPosition.dy), duration: 5.seconds);

    duration = 30000.milliseconds + random.nextInt(6000).milliseconds;
    startTime = DateTime.now().duration();
    size = 0.1 + random.nextDouble() * 0.1;
  }

  void _shuffle() {
    startTime -= (random.nextDouble() * duration.inMilliseconds).round().milliseconds;
  }

  checkIfParticleNeedsToBeRestarted() {
    if (progress() == 1.0) {
      _restart();
    }
  }

  double progress() {
    return ((DateTime.now().duration() - startTime) / duration).clamp(0.0, 1.0).toDouble();
  }
}

class ParticlePainter extends CustomPainter {
  List<ParticleModel> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withAlpha(50);

    for (var particle in particles) {
      final progress = particle.progress();
      Movie animation = particle.tween.transform(progress);
      final position = Offset(
        animation.get<double>(_OffsetProps.x) * size.width,
        animation.get<double>(_OffsetProps.y) * size.height,
      );
      canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

enum _ColorTween { color1, color2 }

class AnimatedBackground extends StatelessWidget {
  AnimatedBackground({super.key});
  final tween = MovieTween()
    ..tween(
      _ColorTween.color1,
      const Color(0xff8a113a).tweenTo(Colors.lightBlue.shade900),
      duration: 10.seconds,
    )
    ..tween(
      _ColorTween.color2,
      const Color(0xff440216).tweenTo(Colors.blue.shade600),
      duration: 10.seconds,
    );
  @override
  Widget build(BuildContext context) {
    return MirrorAnimationBuilder<Movie>(
      tween: tween,
      duration: tween.duration,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [child.get<Color>(_ColorTween.color1), child.get<Color>(_ColorTween.color2)],
            ),
          ),
        );
      },
    );
  }
}

class CenteredText extends StatelessWidget {
  const CenteredText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Welcome",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
      textScaleFactor: 4,
    ));
  }
}
