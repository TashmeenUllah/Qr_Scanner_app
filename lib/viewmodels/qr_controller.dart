// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class QRController extends GetxController {
//   var qrText = ''.obs;
//   var isComplete = false.obs;
//   var torchEnabled = false.obs;
//   var scanHistory = <String>[].obs;

//   final box = GetStorage();

//   // message assembly
//   Map<int, String> parts = {};
//   int totalParts = 0;
//   String messageId = '';

//   @override
//   void onInit() {
//     super.onInit();

//     List? history = box.read<List>('scanHistory');
//     if (history != null) {
//       scanHistory.addAll(history.cast<String>());
//     }
//   }

//   void onQRScanned(String data) {
//     try {
//       List<String> segments = data.split('|');

//       String id = segments[0].split(':')[1];
//       int part = int.parse(segments[1].split(':')[1]);
//       int total = int.parse(segments[2].split(':')[1]);
//       String chunk = segments[3].split(':')[1];

//       // new message reset
//       if (messageId != id) {
//         messageId = id;
//         parts.clear();
//         totalParts = total;
//         isComplete.value = false;
//       }

//       // store chunk
//       parts[part] = chunk;

//       // show progress
//       qrText.value = "Receiving ${parts.length}/$totalParts parts";

//       // check if complete
//       if (parts.length == totalParts) {
//         assembleMessage();
//       }
//     } catch (e) {
//       // fallback if QR is normal single message
//       qrText.value = data;
//       isComplete.value = true;
//       saveScan(data);
//     }
//   }

//   void assembleMessage() {
//     String fullText = '';

//     for (int i = 1; i <= totalParts; i++) {
//       fullText += parts[i] ?? '';
//     }

//     qrText.value = fullText;
//     isComplete.value = true;

//     saveScan(fullText);

//     parts.clear();
//   }

//   void saveScan(String data) {
//     if (data.isNotEmpty) {
//       scanHistory.add(data);
//       box.write('scanHistory', scanHistory);
//     }
//   }

//   void clearHistory() {
//     scanHistory.clear();
//     box.remove('scanHistory');
//   }
// }