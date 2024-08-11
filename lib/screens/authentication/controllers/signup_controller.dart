import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/constants.dart';
import 'package:http/http.dart' as http;

import '../../../utils/helper.dart';
import '../../../utils/routes/routes.dart';

class SignUpController extends GetxController {
  RxBool hidePassword = true.obs;
  RxBool isLoading = false.obs;

  final emailCon = TextEditingController();
  final passCon = TextEditingController();
  final nameCon = TextEditingController();

  void clearControllers() {
    emailCon.clear();
    passCon.clear();
    nameCon.clear();
  }

  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  signUpUser(BuildContext context) async {
    try {
      isLoading.value = true;
      Uri uri = Uri.parse('$appBaseUrl/users/sign-up');
      final response = await http.post(uri, body: {
        "name": nameCon.text,
        "email": emailCon.text,
        "password": passCon.text,
        "user_type": "Client",
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(successSnackbar(jsonData['message']));
        clearControllers();
        Get.toNamed(AppRoutes.otp, parameters: {
          'email': jsonData['data']['email'],
          'otp': jsonData['data']['otp'],
          'fromForgetPass': "false",
        });
      } else {
        final jsonData = json.decode(response.body);
        print(jsonData);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(errorSnackbar(jsonData['message']));
        clearControllers();
      }
    } catch (e) {
      e.printInfo();
    } finally {
      isLoading.value = false;
    }
  }
}
