import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:project_x1_news/utils/app_colors.dart';

class Helper {
  static Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    } else {
      return false;
    }
  }

  static bool validatePassowrd(String input) {
    final raw = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    return raw.hasMatch(input);
  }

  static void toast(BuildContext context, String message, {bool? success}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          duration: const Duration(milliseconds: 1200),
          dismissDirection: DismissDirection.up,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          content: Text(message),
          backgroundColor: success == true ? klightGreenAccentColor : kRedColor,
        ),
      );

  static Widget progress() {
    return const Center(
      child: CircularProgressIndicator(
        color: kPrimaryColor,
      ),
    );
  }
}
