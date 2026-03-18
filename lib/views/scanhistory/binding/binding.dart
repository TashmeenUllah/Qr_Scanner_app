import 'package:get/get.dart';
import 'package:qr_code_reader/views/scanhistory/controller/controller.dart';

class ScanHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRController>(() => QRController());
  }
}