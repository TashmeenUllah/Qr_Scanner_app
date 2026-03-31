// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:qr_code_reader/viewmodels/splash_viewmodel.dart';

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final vm = Get.put(WelcomeViewModel());
//     final size = MediaQuery.of(context).size;
    
    
//     return Scaffold(
//       backgroundColor: const Color(0xff203a43), // ✅ your app color
//       body: Stack(
//         children: [
//           // Optional subtle gradient for depth
//           AnimatedContainer(
//             duration: const Duration(seconds: 6),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   const Color(0xff203a43),
//                   Colors.blueGrey.shade900.withValues(alpha: 0.9),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           // Center content
//           Center(
//             child: FadeTransition(
//               opacity: vm.fadeAnimation,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Modern floating logo card
//                   Container(
//                     height: size.width * 0.4,
//                     width: size.width * 0.4,
//                     decoration: BoxDecoration(
//                       color: const Color(0xff203a43), // match background
//                       borderRadius: BorderRadius.circular(25),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withValues(alpha: 0.6),
//                           blurRadius: 25,
//                           offset: const Offset(0, 15),
//                         ),
//                       ],
//                       border: Border.all(
//                         color: Colors.greenAccent,
//                         width: 2,
//                       ),
//                     ),
//                     child: Center(
//                       child: Icon(
//                         Icons.qr_code_2,
//                         size: 80,
//                         color: Colors.greenAccent,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   // App title
//                   Text(
//                     'QR Scanner',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.greenAccent.withValues(alpha: 0.8),
//                       letterSpacing: 1.2,
//                       shadows: const [
//                         Shadow(
//                           color: Colors.black45,
//                           blurRadius: 4,
//                           offset: Offset(2, 2),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   // Subtitle
//                   const Text(
//                     'Smart, fast, and effortless QR management',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 17,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                   // Start button (modern)
//                   ElevatedButton(
//                     onPressed: vm.navigateToScanner,
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 60),
//                       backgroundColor: Colors.greenAccent.withValues(alpha: 0.8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(35),
//                       ),
//                       elevation: 10,
//                       shadowColor: Colors.greenAccent.withValues(alpha: 0.8),
//                     ),
//                     child: const Text(
//                       'Start Scanning',
//                       style: TextStyle(
//                         fontSize: 18,
//                         // fontWeight: FontWeight.bold,
//                         letterSpacing: 1.1,
//                         color: Colors.white,
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