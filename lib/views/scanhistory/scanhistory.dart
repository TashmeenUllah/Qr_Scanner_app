// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter/services.dart';
// import 'package:qr_code_reader/views/scanhistory/controller/controller.dart';

// class ScanHistoryPage extends StatelessWidget {
//   const ScanHistoryPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final QRController controller = Get.put(QRController());
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//     return Scaffold(
//       backgroundColor: const Color(0xff0f2027),
//       appBar: AppBar(
//         backgroundColor: const Color(0xff203a43),
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: Text(
//           'Scan History',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: width * 0.05,
//             color: Colors.white,
//             shadows: const [
//               Shadow(
//                 color: Colors.black45,
//                 blurRadius: 3,
//                 offset: Offset(1, 1),
//               ),
//             ],
//           ),
//         ),
//         centerTitle: true,
//       actions: [
//   Obx(() {
//     bool hasSelection = controller.selectedIndexes.isNotEmpty;
//     return IconButton(
//       icon: Icon(
//         Icons.delete,
//         color: hasSelection ? Colors.white : Colors.white38,
//       ),
//       tooltip: 'Delete Selected',
//       onPressed: hasSelection
//           ? () {
//               controller.deleteSelected();
//             }
//           : null,
//     );
//   }),
// ],
//       ),
//       body: Obx(() {
//         if (controller.scanHistory.isEmpty) {
//           return Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: width * 0.08),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: width * 0.30,
//                     width: width * 0.30,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.greenAccent.withOpacity(0.2),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.greenAccent.withOpacity(0.4),
//                           blurRadius: 20,
//                           spreadRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Icons.qr_code_2,
//                       size: width * 0.15,
//                       color: Colors.greenAccent,
//                     ),
//                   ),
//                   SizedBox(height: height * 0.03),
//                   Text(
//                     'No scans yet',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: width * 0.055,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: height * 0.015),
//                   Text(
//                     'Your scanned QR codes will appear here',
//                     style: TextStyle(
//                       color: Colors.white54,
//                       fontSize: width * 0.035,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//         return ListView.builder(
//           padding: EdgeInsets.all(width * 0.04),
//           itemCount: controller.scanHistory.length,
//           itemBuilder: (context, index) {
//             final item = controller.scanHistory[index];
//            return Obx(() {
//   bool selected = controller.selectedIndexes.contains(index);
//   return GestureDetector(
//   onLongPress: () {
//     controller.toggleSelection(index);
//   },
//   onTap: () {
//     if (controller.selectedIndexes.isNotEmpty) {
//       controller.toggleSelection(index);
//     }
//   },
//   child: AnimatedContainer(
//     duration: const Duration(milliseconds: 200),
//     margin: EdgeInsets.symmetric(vertical: width * 0.025),
//     decoration: BoxDecoration(
//       color: selected
//           ? Colors.greenAccent.withOpacity(0.15)
//           : const Color(0xff203a43),
//       borderRadius: BorderRadius.circular(width * 0.045),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.35),
//           blurRadius: 10,
//           offset: const Offset(0, 4),
//         ),
//       ],
//       border: Border.all(
//         color: selected
//             ? Colors.greenAccent
//             : Colors.white.withOpacity(0.05),
//         width: 1.2,
//       ),
//     ),
//     child: Row(
//       children: [
//         // Left accent line
//         Container(
//           width: 5,
//           height: height * 0.12,
//           decoration: BoxDecoration(
//             color: selected ? Colors.greenAccent : Colors.greenAccent.withOpacity(0.5),
//             borderRadius: const BorderRadius.horizontal(
//               left: Radius.circular(12),
//             ),
//           ),
//         ),
//         SizedBox(width: width * 0.035),
//         // QR Icon
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.greenAccent.withOpacity(0.15),
//             borderRadius: BorderRadius.circular(width * 0.03),
//           ),
//           padding: EdgeInsets.all(width * 0.025),
//           child: Icon(
//             Icons.qr_code,
//             color: Colors.greenAccent,
//             size: width * 0.065,
//           ),
//         ),

//         SizedBox(width: width * 0.04),
//         // Text
//         Expanded(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               maxHeight: height * 0.14,
//             ),
//             child: SingleChildScrollView(
//               child: Text(
//                 item,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                   fontSize: width * 0.038,
//                   height: 1.4,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: width * 0.02),
//         // Right side action
//         controller.selectedIndexes.isNotEmpty
//             ? Padding(
//                 padding: EdgeInsets.only(right: width * 0.03),
//                 child: Icon(
//                   selected
//                       ? Icons.check_circle
//                       : Icons.radio_button_unchecked,
//                   color: Colors.greenAccent,
//                   size: width * 0.065,
//                 ),
//               )
//             : Container(
//                 margin: EdgeInsets.only(right: width * 0.02),
//                 decoration: BoxDecoration(
//                   color: Colors.greenAccent.withOpacity(0.15),
//                   shape: BoxShape.circle,
//                 ),
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.copy,
//                     color: Colors.greenAccent,
//                     size: width * 0.055,
//                   ),
//                   onPressed: () {
//                     Clipboard.setData(ClipboardData(text: item));
//                     Get.snackbar(
//                       'Copied',
//                       'QR code text copied to clipboard',
//                       snackPosition: SnackPosition.BOTTOM,
//                       backgroundColor: Colors.black87,
//                       colorText: Colors.white,
//                       margin: EdgeInsets.all(width * 0.04),
//                       duration: const Duration(seconds: 2),
//                     );
//                   },
//                 ),
//               ),
//       ],
//     ),
//   ),
// );
// });
//           },
//         );
//       }),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_reader/views/scanhistory/controller/controller.dart';

class ScanHistoryPage extends StatelessWidget {
  const ScanHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller is already injected via Binding
   final QRController controller = Get.put(QRController());

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xff0f2027),
      appBar: AppBar(
        backgroundColor: const Color(0xff203a43),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Scan History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: width * 0.05,
            color: Colors.white,
            shadows: const [
              Shadow(
                color: Colors.black45,
                blurRadius: 3,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(() {
            bool hasSelection = controller.selectedIndexes.isNotEmpty;
            return IconButton(
              icon: Icon(
                Icons.delete,
                color: hasSelection ? Colors.white : Colors.white38,
              ),
              tooltip: 'Delete Selected',
              onPressed: hasSelection
                  ? controller.deleteSelected
                  : null,
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.scanHistory.isEmpty) {
          return _buildEmptyState(width, height);
        }
        return _buildHistoryList(controller, width, height);
        
      }),
      
    );
  }

  Widget _buildEmptyState(double width, double height) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height * 0.10,
              width: width * 0.30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.greenAccent.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withValues(alpha: 0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                Icons.qr_code_2,
                size: width * 0.15,
                color: Colors.greenAccent,
              ),
            ),
            SizedBox(height: height * 0.03),
            Text(
              'No scans yet',
              style: TextStyle(
                color: Colors.white70,
                fontSize: width * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.015),
            Text(
              'Your scanned QR codes will appear here',
              style: TextStyle(
                color: Colors.white54,
                fontSize: width * 0.035,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(QRController controller, double width, double height) {
    return Obx(() { // Wrap the entire ListView to rebuild when scanHistory changes
    if (controller.scanHistory.isEmpty) {
      return Center(
        child: Text(
          'No scans yet',
          style: TextStyle(color: Colors.white70, fontSize: width * 0.05),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(width * 0.04),
      itemCount: controller.scanHistory.length,
      itemBuilder: (context, index) {
        final item = controller.scanHistory[index];
        return Obx(() {
          bool selected = controller.selectedIndexes.contains(index);
          return _buildHistoryItem(controller, index, item, selected, width, height);
        });
      },
    );
      });
    }

 Widget _buildHistoryItem(
  QRController controller,
  int index,
  String item,
  bool selected,
  double width,
  double height,
) {
  return GestureDetector(
    onLongPress: () => controller.toggleSelection(index),
    onTap: () {
      if (controller.selectedIndexes.isNotEmpty) {
        controller.toggleSelection(index);
      }
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(vertical: width * 0.025),
      decoration: BoxDecoration(
        color: selected
            ? Colors.greenAccent.withValues(alpha: 0.15)
            : const Color(0xff203a43),
        borderRadius: BorderRadius.circular(width * 0.045),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: selected
              ? Colors.greenAccent
              : Colors.white.withValues(alpha: 0.05),
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left accent line
          Container(
            width: 5,
            height: height * 0.17,
            decoration: BoxDecoration(
              color: selected
                  ? Colors.greenAccent
                  : Colors.greenAccent.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
            ),
          ),
          SizedBox(width: width * 0.035),

          // QR Icon
          Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(width * 0.03),
            ),
            padding: EdgeInsets.all(width * 0.025),
            child: Icon(
              Icons.qr_code,
              color: Colors.greenAccent,
              size: width * 0.065,
            ),
          ),
          SizedBox(width: width * 0.04),

          // Text + timestamp + action buttons
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: height * 0.12,
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.038,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: width * 0.01),
                // Timestamp + actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.scanTimes.length > index
                          ? controller.scanTimes[index]
                          : '',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: width * 0.028,
                      ),
                    ),
                    Row(
                      children: [
                        // Copy
                        IconButton(
                          icon: Icon(
                            Icons.copy,
                            color: Colors.greenAccent,
                            size: width * 0.055,
                          ),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: item));
                            // Get.snackbar(
                            //   'Copied',
                            //   'QR code text copied to clipboard',
                            //   snackPosition: SnackPosition.BOTTOM,
                            //   backgroundColor: Colors.black87,
                            //   colorText: Colors.white,
                            //   margin: EdgeInsets.all(width * 0.04),
                            //   duration: const Duration(seconds: 2),
                            // );
                          },
                        ),
                        // Share
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Colors.greenAccent,
                            size: width * 0.055,
                          ),
                          onPressed: () {
                            controller.shareItem(item);
                          },
                        ),
                        // Selection indicator if selection mode is active
                        if (controller.selectedIndexes.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.015),
                            child: Icon(
                              selected
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: Colors.greenAccent,
                              size: width * 0.065,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}