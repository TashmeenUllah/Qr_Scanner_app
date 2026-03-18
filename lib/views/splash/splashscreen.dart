// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:qr_code_reader/views/home/home.dart';
// import 'dart:math';

// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({super.key});

//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends State<WelcomeScreen>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _fadeAnimation;
//   late final Animation<double> _logoScaleAnimation;
//   late final Animation<double> _pulseAnimation;
//   late final Animation<double> _floatingAnimation;

//   final Random _random = Random();
//   final List<Offset> _particles = List.generate(30, (_) => Offset(0, 0));

// @override
// void initState() {
//   super.initState();

//   _controller = AnimationController(
//     vsync: this,
//     duration: const Duration(seconds: 3),
//   );

//   _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
//     CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//   );

//   _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//     CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
//   );

//   _pulseAnimation = Tween<double>(begin: 0.9, end: 1.15).animate(
//     CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//   );

//   // Correct floating animation initialization
//   _floatingAnimation = Tween<double>(begin: -8, end: 8).animate(
//     CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//   );

//   _controller.repeat(reverse: true);
// }
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void navigateToScanner() {
//     Get.off(() => const HomePage());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
    
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Animated Gradient Background
//           AnimatedContainer(
//             duration: const Duration(seconds: 6),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.blueGrey.shade900,
//                   Colors.blueGrey.shade700,
//                   Colors.black87,
//                   Colors.green.shade900,
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),

//           // Particles floating behind logo
//           AnimatedBuilder(
//             animation: _controller,
//             builder: (context, _) {
//               return CustomPaint(
//                 size: size,
//                 painter: _ParticlePainter(
//                   particles: _particles,
//                   animationValue: _controller.value,
//                 ),
//               );
//             },
//           ),

//           // Center Content
//           Center(
//             child: FadeTransition(
//               opacity: _fadeAnimation,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ScaleTransition(
//                     scale: _logoScaleAnimation,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // Glowing pulsing circle
//                         ScaleTransition(
//                           scale: _pulseAnimation,
//                           child: Container(
//                             height: size.width * 0.5,
//                             width: size.width * 0.5,
//                             decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.greenAccent.withOpacity(0.25),
//                             boxShadow: [
//                               BoxShadow(
//                               color: Colors.greenAccent.withOpacity(0.3),
//                               blurRadius: 50,
//                               spreadRadius: 10,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // Floating logo
//                         Transform.translate(
//                           offset: Offset(0, _floatingAnimation.value),
//                           child: Container(
//                             height: size.width * 0.35,
//                             width: size.width * 0.35,
//                             decoration: BoxDecoration(
//                               color: Colors.greenAccent,
//                               shape: BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.greenAccent.withOpacity(0.5),
//                                   blurRadius: 30,
//                                   offset: const Offset(0, 10),
//                                 ),
//                               ],
//                             ),
//                             child: const Icon(
//                               Icons.qr_code_2,
//                               color: Colors.white,
//                               size: 80,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   const Text(
//                     'QR Scanner',
//                     style: TextStyle(
//                       color: Colors.greenAccent,
//                       fontSize: 38,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1.5,
//                       shadows: [
//                         Shadow(
//                           color: Colors.black45,
//                           blurRadius: 4,
//                           offset: Offset(2, 2),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Scan and manage your QR codes easily',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 17,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 50),
//                   ElevatedButton(
//                     onPressed: navigateToScanner,
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 16, horizontal: 65),
//                       backgroundColor: Colors.greenAccent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(35),
//                       ),
//                       elevation: 15,
//                       shadowColor: Colors.greenAccent.withOpacity(0.6),
//                     ),
//                     child: const Text(
//                       'Start Scanning',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1.2,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Particle painter for background motion effect
// class _ParticlePainter extends CustomPainter {
//   final List<Offset> particles;
//   final double animationValue;

//   _ParticlePainter({required this.particles, required this.animationValue});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.greenAccent.withOpacity(0.2);
//     for (final p in particles) {
//       final x = p.dx * size.width + sin(animationValue * 2 * pi) * 20;
//       final y = p.dy * size.height + cos(animationValue * 2 * pi) * 20;
//       canvas.drawCircle(Offset(x, y), 4, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_reader/viewmodels/splash_viewmodel.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(WelcomeViewModel());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Animated Gradient Background
          AnimatedContainer(
            duration: const Duration(seconds: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueGrey.shade900,
                  Colors.blueGrey.shade700,
                  Colors.black87,
                  Colors.green.shade900,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Particles floating behind logo
          AnimatedBuilder(
            animation: vm.controller,
            builder: (context, _) {
              return CustomPaint(
                size: size,
                painter: ParticlePainter(
                  particles: vm.particles,
                  animationValue: vm.controller.value,
                ),
              );
            },
          ),

          // Center Content
          Center(
            child: FadeTransition(
              opacity: vm.fadeAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: vm.logoScaleAnimation,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Glowing pulsing circle
                        ScaleTransition(
                          scale: vm.pulseAnimation,
                          child: Container(
                            height: size.width * 0.5,
                            width: size.width * 0.5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.greenAccent.withOpacity(0.25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.greenAccent.withOpacity(0.3),
                                  blurRadius: 50,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Floating logo
                        Transform.translate(
                          offset: Offset(0, vm.floatingAnimation.value),
                          child: Container(
                            height: size.width * 0.35,
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.greenAccent.withOpacity(0.5),
                                  blurRadius: 30,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.qr_code_2,
                              color: Colors.white,
                              size: 80,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  const Text(
                    'QR Scanner',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Scan and manage your QR codes easily',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: vm.navigateToScanner,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 65),
                      backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      elevation: 15,
                      shadowColor: Colors.greenAccent.withOpacity(0.6),
                    ),
                    child: const Text(
                      'Start Scanning',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

