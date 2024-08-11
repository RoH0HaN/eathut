import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';
import '../../../repositories/authentication_repository/authentication_repository.dart';
import '../../../utils/helper.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  RxBool hidePassword = true.obs;
  RxBool isLoading = false.obs;

  final emailCon = TextEditingController();
  final passCon = TextEditingController();

  void clearControllers() {
    emailCon.clear();
    passCon.clear();
  }

  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  void loginUser(BuildContext context) async {
    try {
      isLoading.value = true;
      Uri uri = Uri.parse('$appBaseUrl/users/log-in');
      final response = await http.post(uri, body: {
        "email": emailCon.text,
        "password": passCon.text,
        "user_type": "Client",
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(successSnackbar(jsonData['message']));
        await box.write('accessToken', jsonData['data']['accessToken']);
        await AuthenticationRepository.instance.fetchUserDetails();
        AuthenticationRepository.instance.setInitialScreen(context);
      } else {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(errorSnackbar(jsonData['message']));
      }
    } catch (e) {
      e.printInfo();
    } finally {
      clearControllers();
      isLoading.value = false;
    }
  }
}
