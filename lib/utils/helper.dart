import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

SnackBar successSnackbar(message) {
  return SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Congratulations!',
      message: message,
      contentType: ContentType.success,
    ),
  );
}

SnackBar errorSnackbar(message) {
  return SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Oh Snap!',
      message: message,
      contentType: ContentType.failure,
    ),
  );
}

SnackbarController notificationSnackbar(title, message) {
  return Get.snackbar(title, message,
      icon: const Icon(
        Icons.notification_add_outlined,
        color: baseColor,
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: baseColorBlended,
      colorText: baseColor);
}

String getGreeting() {
  final now = DateTime.now();
  final hour = now.hour;

  if (hour >= 5 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon';
  } else if (hour >= 17 && hour < 21) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}
