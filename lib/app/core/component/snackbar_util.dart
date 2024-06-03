import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtil {
  static void showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Colors.green[600], // Use green color for success
      colorText: Colors.white, // White text color
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(10),
      borderRadius: 8,
      icon: Icon(Icons.check_circle, color: Colors.white),
    );
  }

  static void showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red[300], // Use light red color for error
      colorText: Colors.white, // White text color
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(10),
      borderRadius: 8,
      icon: Icon(Icons.error, color: Colors.white),
    );
  }
}
