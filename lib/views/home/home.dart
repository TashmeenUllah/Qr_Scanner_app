import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_reader/views/components/button_component.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xff0f2027),
              Color(0xff203a43),
              Color(0xff2c5364),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          // subtle radial glow behind scanner
          boxShadow: [
            BoxShadow(
              color: Colors.greenAccent.withOpacity(0.1),
              spreadRadius: 50,
              blurRadius: 100,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.06,
              vertical: height * 0.04,
            ),
            child: Column(
              children: [
                // Title
                Text(
                  "QR Scanner",
                  style: TextStyle(
                    fontSize: width * 0.09,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                ),

                SizedBox(height: height * 0.02),
                
                // Description
                Text(
                  "Scan QR codes instantly or check your scan history.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: width * 0.045,
                  ),
                ),
                SizedBox(height: height * 0.06),

                // Scanner Circle with glow
                Container(
                  height: width * 0.35,
                  width: width * 0.35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.3),
                        spreadRadius: 10,
                        blurRadius: 30,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.qr_code_scanner,
                    size: width * 0.18,
                    color: Colors.greenAccent,
                  ),
                ),

                SizedBox(height: height * 0.07),

                // Scan Button
                GradientButton(
                  width: width,
                  icon: Icons.qr_code_scanner,
                  title: "Scan QR Code",
                  colors: [
                    Colors.green.shade400,
                    Colors.green.shade600,
                  ],
                  onTap: () => Get.toNamed('/qrscannerpage'),
                ),

                SizedBox(height: height * 0.025),

                // History Button
                GradientButton(
                  width: width,
                  icon: Icons.history,
                  title: "Scan History",
                  colors: [
                    Colors.orange.shade400,
                       Colors.deepOrange.shade600,
                  ],
                  onTap: () => Get.toNamed('/scanhistory'),
                ),

                const Spacer(),

                // Footer
                Text(
                  "Powered by QR Scanner App",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.035,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}