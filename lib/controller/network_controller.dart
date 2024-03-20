import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/**
* source: https://www.youtube.com/watch?v=bQ8T6W5fERg
* author: Flutter Guys
*/

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  bool wasDisconnected = false;

  // onInit gets called first automatically
  @override
  void onInit() {
    super.onInit();
    // listen to the connection status
    initConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // check connection when the app is launched
  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (_) {
      return;
    }

    return _updateConnectionStatus(result);
  }

  // this function is called when network connection is updated
  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    // if user is not connected to internet show a snack bar
    if (connectivityResult == ConnectivityResult.none) {
      wasDisconnected = true;
      // no internet snackbar (popup)
      Get.rawSnackbar(
        messageText: const Text(
          'No Internet Connection',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        isDismissible: true,
        duration: const Duration(seconds: 10),
        backgroundColor: Colors.red[400]!,
        icon: const Icon(
          Icons.wifi_off,
          color: Colors.white,
          size: 35,
        ),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    }
    // if user connects to the internet then remove the snackbar.
    // if the snackbar is removed, it doesn't do anything.
    else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      // back online snackbar (pop up)
      if (wasDisconnected) {
        wasDisconnected = false;
        Get.rawSnackbar(
          messageText: const Text(
            'Back Online',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          isDismissible: false,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green[400]!,
          icon: const Icon(
            Icons.wifi,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
        );
      }
    }
  }
}
