import 'dart:math' as math;
import 'package:flutter/material.dart';

class FloatingParticles extends StatefulWidget {
  const FloatingParticles({super.key});

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<FloatingParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> particles = List.generate(
    20,
    (index) => Particle(
      position: Offset(
        math.Random().nextDouble() * 400,
        math.Random().nextDouble() * 400,
      ),
      speed: Offset(
        math.Random().nextDouble() * 2 - 1,
        math.Random().nextDouble() * 2 - 1,
      ),
      size: math.Random().nextDouble() * 4 + 2,
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        for (var particle in particles) {
          particle.update();
        }
        return CustomPaint(
          painter: ParticlePainter(particles),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Particle {
  Offset position;
  Offset speed;
  double size;

  Particle({
    required this.position,
    required this.speed,
    required this.size,
  });

  void update() {
    position += speed;
    if (position.dx < 0 || position.dx > 400) {
      speed = Offset(-speed.dx, speed.dy);
    }
    if (position.dy < 0 || position.dy > 400) {
      speed = Offset(speed.dx, -speed.dy);
    }
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    for (var particle in particles) {
      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
