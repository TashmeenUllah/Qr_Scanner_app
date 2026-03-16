import 'package:get/get.dart';
import 'package:qr_code_reader/views/home/home.dart';
import 'package:qr_code_reader/views/qr_scanner_page.dart';
import 'package:qr_code_reader/views/scanhistory/scanhistory.dart';
import 'package:qr_code_reader/views/splash/splashscreen.dart';

class AppRoutes {
  // Route names
  static  String homePage = '/homePage';
  static  String qrScannerPage = '/qrscannerpage';
  static  String scanHistory = '/scanhistory';
  static  String welcomeScreen = '/welcomescreen';
  // static  String scanHistory = '/scanhistory';
   
  // GetX page list
  static List<GetPage> routes = [
     GetPage(
      name: homePage,
      page: () => const HomePage(),
      ),
    
    GetPage(
      name: qrScannerPage,
      page: () => const QRScannerPage(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: scanHistory,
      page: () => const ScanHistoryPage(),
    ),

     GetPage(
      name: welcomeScreen,
      page: () => const WelcomeScreen(),
    ),
    //  GetPage(
    //   name: scanHistory,
    //   page: () => const ScanHistoryPage(),
    // ),
    //  GetPage(
    //   name: scanHistory,
    //   page: () => const ScanHistoryPage(),
    // ),
  ];
}
