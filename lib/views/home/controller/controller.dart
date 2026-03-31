import 'package:get/get.dart';
import 'package:qr_code_reader/views/scanhistory/scanhistory.dart';
class HomeViewModel extends GetxController {

  void navigateToScanner() {
    Get.toNamed('/qrscannerpage');
  }

  void navigateToHistory() {
    // Get.toNamed('/scanhistory');
      Get.to(() => ScanHistoryPage()); // this adds on top
  }
}