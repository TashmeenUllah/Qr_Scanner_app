import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_reader/views/home/home.dart';

class WelcomeViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {

  late final AnimationController controller;
  late final Animation<double> fadeAnimation;
  late final Animation<double> logoScaleAnimation;
  late final Animation<double> pulseAnimation;
  late final Animation<double> floatingAnimation;

  final Random random = Random();
  final List<Offset> particles = List.generate(30, (_) => Offset(0, 0));

  @override
  void onInit() {
    super.onInit();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.elasticOut),
    );

    pulseAnimation = Tween<double>(begin: 0.9, end: 1.15).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    floatingAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    controller.repeat(reverse: true);
  }

  void navigateToScanner() {
    Get.offAll(() => HomePage()); // removes all previous routes
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

// Particle painter for background motion effect
class ParticlePainter extends CustomPainter {
  final List<Offset> particles;
  final double animationValue;

  ParticlePainter({required this.particles, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.greenAccent.withOpacity(0.2);
    for (final p in particles) {
      final x = p.dx * size.width + sin(animationValue * 2 * pi) * 20;
      final y = p.dy * size.height + cos(animationValue * 2 * pi) * 20;
      canvas.drawCircle(Offset(x, y), 4, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}