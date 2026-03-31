import 'package:get/get.dart';
import 'package:qr_code_reader/views/scanhistory/controller/controller.dart';

class ScannerPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRController>(() => QRController());
  }
}