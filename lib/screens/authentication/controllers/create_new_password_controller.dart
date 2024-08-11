import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/routes/routes.dart';

class CreateNewPasswordController extends GetxController {
  final box = GetStorage();
  RxBool hidePassword = true.obs;
  RxBool isLoading = false.obs;
  final passCon = TextEditingController();
  RxString email = ''.obs;

  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  void changePassword(BuildContext context) async {
    try {
      isLoading.value = true;
      Uri uri = Uri.parse('$appBaseUrl/users/change-password');
      final response = await http
          .post(uri, body: {"email": email.value, "password": passCon.text});

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(successSnackbar(jsonData['message']));
        Get.offAllNamed(AppRoutes.login);
      } else {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(errorSnackbar(jsonData['message']));
      }
    } catch (e) {
      e.printInfo();
    } finally {
      passCon.clear();
      isLoading.value = false;
    }
  }
}
