import 'package:get/get.dart';
class HomeViewModel extends GetxController {

  void navigateToScanner() {
    Get.toNamed('/qrscannerpage');
  }

  void navigateToHistory() {
    Get.toNamed('/scanhistory');
  }
}