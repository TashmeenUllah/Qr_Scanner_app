import 'package:get/get.dart';
import 'package:qr_code_reader/views/home/controller/controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewModel>(() => HomeViewModel());
  }
}