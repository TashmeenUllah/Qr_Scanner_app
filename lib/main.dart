import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_reader/routes/approutes.dart';
import 'package:qr_code_reader/views/home/home.dart';
import 'package:qr_code_reader/views/splash/splashscreen.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // initialize local storage

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, 
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: AppRoutes.welcomeScreen,
       getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}
