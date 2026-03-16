import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class QRController extends GetxController {
  var qrText = ''.obs; // optional, could be empty during scanning
  var isScanning = false.obs; // true between Start and End
  var torchEnabled = false.obs;
  var scanHistory = <String>[].obs;
 var hasResult = false.obs; // true when result dialog is open
  final box = GetStorage();
@override
void onInit() {
  super.onInit();
  List? history = box.read<List>('scanHistory');
  if (history != null) {
    scanHistory.assignAll(history.cast<String>());
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

void onQRScanned(String data) {
  String trimmedData = data.trim();

  // Only start scanning if "Start" is received
  if (trimmedData == "Start") {
    isScanning.value = true;
    collectedChunks.clear(); // reset any previous session
    qrText.value = ''; // clear old text
    return;
  }

  // Ignore everything until "Start" is received
  if (!isScanning.value) return;

  // End scanning session
  if (trimmedData == "End") {
    isScanning.value = false;
    if (collectedChunks.isNotEmpty) {
      showResultDialog(); // show collected results
    }
    return;
  }

  // Only collect data during active scanning session
  collectedChunks.add(trimmedData);
}

  void showResultDialog() {
  if (collectedChunks.isEmpty) return;
  hasResult.value = true; // freeze bottom text

  String result = collectedChunks.join("\n\n");
  saveScan(result);
  collectedChunks.clear();

  Get.defaultDialog(
    barrierDismissible: false,
    backgroundColor: Colors.transparent, // transparent for shadow effect
    title: "",
    contentPadding: EdgeInsets.zero,
    radius: 0,
    content: Center(
      child: Container(
        width: Get.width * 0.8,
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.65,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff203a43),
          borderRadius: BorderRadius.circular(20),
          boxShadow:[
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title with gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.greenAccent, Colors.tealAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: const Center(
                child: Text(
                  "Scan Complete",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Scrollable QR content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Text(
                    result,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Copy and OK buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: result));
                    // Get.snackbar(
                    //   'Copied',
                    //   'QR code text copied to clipboard',
                    //   snackPosition: SnackPosition.BOTTOM,
                    //   backgroundColor: Colors.black87,
                    //   colorText: Colors.white,
                    //   duration: const Duration(seconds: 2),
                    // );

                  },
                  icon: const Icon(Icons.copy, color: Colors.white),
                  label: const Text('Copy', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    hasResult.value = false;
                    Get.back();
                  },
                  child: const Text('OK', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ),
  );
}

  void saveScan(String data) {
    if (data.isNotEmpty) {
      scanHistory.add(data);
      box.write('scanHistory', scanHistory);
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