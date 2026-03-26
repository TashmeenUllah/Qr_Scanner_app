import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_reader/views/components/DailogWidget.dart';
import 'package:qr_code_reader/views/scanhistory/controller/controller.dart';


class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with SingleTickerProviderStateMixin {
  final QRController controller = Get.put(QRController());
  final MobileScannerController scannerController = MobileScannerController();
  late final AnimationController _animationController;
  late final Animation<double> _laserAnimation;
  late Worker _dialogWorker;

  @override
  // void initState() {
  //   super.initState();

  //   _animationController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 2),
  //   )..repeat(reverse: true);

  //   _laserAnimation = Tween<double>(
  //     begin: 0,
  //     end: 1,
  //   ).animate(_animationController);
  // }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

  @override
void initState() {
  super.initState();

  _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  _laserAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(_animationController);

  // ✅ SAFE LISTENER
  _dialogWorker = ever(controller.hasResult, (bool hasResult) {
    if (hasResult) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => QRResultDialog(
            result: controller.qrText.value,
            onClose: () {
              controller.hasResult.value = false;
              Navigator.pop(context);
            },
          ),
        );
      });
    }
  });

  // Listen to scanning state
  ever(controller.isScanning, (bool scanning) {
    if (scanning) {
      _animationController.repeat(reverse: true);
    } else {
      _animationController.stop();
      _animationController.reset();
    }
  });
}

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final guideSize = screenSize.width * 0.7;
    final bottomPanelHeight = screenSize.height * 0.25;

    return Scaffold(
      backgroundColor: const Color(0xff0f2027),
      appBar: AppBar(
        backgroundColor: const Color(0xff203a43),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'QR Scanner',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Obx(
              () => Icon(
                controller.torchEnabled.value
                    ? Icons.flash_on
                    : Icons.flash_off,
                // color: Colors.greenAccent,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              await scannerController.toggleTorch();
              controller.torchEnabled.value = !controller.torchEnabled.value;
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera
          Positioned.fill(
            child: MobileScanner(
              controller: scannerController,
              fit: BoxFit.cover,
              onDetect: (capture) {
                for (final barcode in capture.barcodes) {
                  final code = barcode.rawValue ?? '';
                  if (controller.qrText.value != code) {
                    controller.onQRScanned(code);
                  }
                }
              },
            ),
          ),

          // Center guide with animated laser
          Center(
            child: Stack(
              children: [
                Container(
                  width: guideSize,
                  height: guideSize,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.greenAccent, width: 3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                AnimatedBuilder(
                  animation: _laserAnimation,
                  builder: (context, child) {
                    return Positioned(
                      top: guideSize * _laserAnimation.value,
                      child: Container(
                        width: guideSize,
                        height: 3,
                        color: Colors.greenAccent.withOpacity(0.8),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Instruction text
          Positioned(
            top: screenSize.height * 0.08,
            left: 16,
            right: 16,
            child: const Center(
              child: Text(
                'Align QR code inside the box to scan',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

// Bottom panel
Align(
  alignment: Alignment.bottomCenter,
  child: Obx(() {
    // Hide the bottom panel or change text when dialog is open
    if (controller.hasResult.value) {
      return SizedBox.shrink(); // completely hide
    
    }

    return Container(
      height: bottomPanelHeight,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff203a43),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          controller.isScanning.value
              ? 'Scanning QR codes...'
              : 'Point camera at a QR code',
          style: const TextStyle(
            color: Colors.greenAccent,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }),
  
),

        ],
      ),
    );
  }
}