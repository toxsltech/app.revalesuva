import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../export.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      // offlineSheet();
      offlineDialog();
      // Get.rawSnackbar(
      //     messageText: const Text('PLEASE CONNECT TO THE INTERNET',
      //         style: TextStyle(color: Colors.white, fontSize: 14)),
      //     isDismissible: false,
      //     duration: const Duration(days: 1),
      //     backgroundColor: appColor,
      //     icon: const Icon(
      //       Icons.wifi_off,
      //       color: Colors.white,
      //       size: 35,
      //     ),
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED);
    } else {
      Get.back();
      // if (Get.isSnackbarOpen) {
      //   Get.closeCurrentSnackbar();
      // }
    }
  }

  offlineSheet() {
    return Get.dialog(
        barrierDismissible: false,
        WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Container(
            width: Get.width * 0.70,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
        ));
  }

  offlineDialog() {
    return Get.dialog(
        barrierDismissible: false,
        WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Container(
                        width: Get.width * 0.70,
                        decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(margin_20)),
                        child: Column(
                          children: [
                            AssetImageWidget(
                              imageUrl: iconLogo,
                              imageHeight: height_100,
                            ),
                            TextView(
                                    text: keyOffline.tr,
                                    textStyle: textStyleBodySmall().copyWith(
                                        fontSize: font_17,
                                        fontWeight: FontWeight.bold))
                                .paddingSymmetric(vertical: margin_8),
                            TextView(
                                    text: keyCheckInternet.tr,
                                    textStyle: textStyleBodySmall().copyWith(
                                        fontSize: font_15,
                                        fontWeight: FontWeight.bold))
                                .paddingSymmetric(vertical: margin_8),
                          ],
                        ).paddingSymmetric(vertical: margin_15)))
              ]),
        ));
  }
}
