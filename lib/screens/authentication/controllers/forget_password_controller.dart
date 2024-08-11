import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/routes/routes.dart';

class ForgetPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  final emailCon = TextEditingController();

  sendForgetPasswordOTP(BuildContext context) async {
    try {
      isLoading.value = true;
      Uri uri = Uri.parse('$appBaseUrl/users/forget-password');
      final response = await http.post(uri, body: {
        "email": emailCon.text,
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(successSnackbar(jsonData['message']));

        Get.toNamed(AppRoutes.otp, parameters: {
          'email': jsonData['data']['email'],
          'otp': jsonData['data']['otp'],
          'fromForgetPass': "true",
        });
      } else {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(errorSnackbar(jsonData['message']));
      }
    } catch (e) {
      e.printInfo();
    } finally {
      emailCon.clear();
      isLoading.value = false;
    }
  }
}
