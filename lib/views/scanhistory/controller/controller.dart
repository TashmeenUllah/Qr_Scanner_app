import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class QRController extends GetxController {
  var qrText = ''.obs;
  var isScanning = false.obs;
  var torchEnabled = false.obs;
  var scanHistory = <String>[].obs;
  var hasResult = false.obs;
  final box = GetStorage();
  var isQrVisible = false.obs;
  // List of timestamps for each scan
  var scanTimes = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    List? storedHistory = box.read('scanHistory');
    List? storedTimes = box.read('scanTimes');

    scanHistory.value = storedHistory?.cast<String>() ?? [];
    scanTimes.value = storedTimes?.cast<String>() ?? [];

    // Ensure both lists have the same length
    while (scanTimes.length < scanHistory.length) {
      scanTimes.add('Unknown'); // fallback for older entries
    }
  }
  // store all QR chunks during scanning session
  var collectedChunks = <String>[].obs;
  //Deleting specific items from history
  var selectedIndexes = <int>[].obs;

  void toggleSelection(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }
  }
  void deleteSelected() {
    selectedIndexes.sort((b, a) => a.compareTo(b));
    for (var index in selectedIndexes) {
      scanHistory.removeAt(index);
    }
    box.write('scanHistory', scanHistory);
    selectedIndexes.clear();
  }

  // Share QR code text
  void shareItem(String text) {
    Share.share(text);
  }
  void onQRScanned(String data) {
    String trimmedData = data.trim();

    if (trimmedData == "Start") {
      isScanning.value = true;
      collectedChunks.clear();
      qrText.value = '';
      return;
    }

    if (!isScanning.value) return;

    if (trimmedData == "End") {
      isScanning.value = false;

      if (collectedChunks.isNotEmpty) {
        final result = collectedChunks.join("\n\n");

        saveScan(result);
        qrText.value = result; // ✅ send result to UI
        hasResult.value = true; // ✅ trigger dialog

        collectedChunks.clear();
      }
      return;
    }

    collectedChunks.add(trimmedData);
  }

  void saveScan(String data) {
    if (data.isNotEmpty) {
      final now = DateTime.now();
      scanHistory.add(data); // save QR text
      scanTimes.add(
        DateFormat('yyyy-MM-dd HH:mm').format(now),
      ); // save timestamp

      box.write('scanHistory', scanHistory);
      box.write('scanTimes', scanTimes); // also save timestamps
    }
  }

  void clearHistory() {
    scanHistory.clear();
    collectedChunks.clear();
    isScanning.value = false;
    qrText.value = '';
    box.remove('scanHistory');
  }
}
