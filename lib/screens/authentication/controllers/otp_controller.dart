import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/constants.dart';
import 'package:http/http.dart' as http;

import '../../../repositories/authentication_repository/authentication_repository.dart';
import '../../../utils/helper.dart';
import '../../../utils/routes/routes.dart';

class OTPController extends GetxController {
  RxInt otpTimer = 60.obs;
  RxBool isLoading = false.obs;
  RxString serverOtp = "".obs;
  RxString otp = "".obs;
  RxString email = "".obs;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimer.value > 0) {
        otpTimer.value--;
      } else {
        otpTimer.value = 60;
        timer.cancel();
      }
    });
  }

  verifyForgetPasswordOTP(BuildContext context) async {
    if (otp.value.isEmpty || serverOtp.value.isEmpty || email.value.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(errorSnackbar("Something went wrong, try again"));
    }
    if (otp.value.length < 4) {
      return;
    }
    if (otp.value != serverOtp.value) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(errorSnackbar("Invalid OTP"));

      return;
    }

    Get.toNamed(AppRoutes.createNewPassword,
        parameters: {'email': email.value});
  }

  void verifyOTP(BuildContext context) async {
    if (otp.value.isEmpty || serverOtp.value.isEmpty || email.value.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(errorSnackbar("Something went wrong, try again"));
    }
    if (otp.value.length < 4) {
      return;
    }
    if (otp.value != serverOtp.value) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(errorSnackbar("Invalid OTP"));

      return;
    }

    try {
      isLoading.value = true;
      Uri uri = Uri.parse('$appBaseUrl/users/verify-otp');
      final response = await http.post(uri, body: {
        "email": email.value,
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(successSnackbar(jsonData['message']));

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
      isLoading.value = false;
    }
  }

  void resendOTP(BuildContext context) async {
    try {
      isLoading.value = true;
      Uri uri = Uri.parse('$appBaseUrl/users/resend-otp');
      final response = await http.post(uri, body: {
        "email": email.value,
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(successSnackbar(jsonData['message']));
        Get.offNamed(AppRoutes.otp, parameters: {
          'email': jsonData['data']['email'],
          'otp': jsonData['data']['otp'],
          'fromForgetPass': "false",
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
      isLoading.value = false;
    }
  }

  resendForgetPasswordOTP(BuildContext context) async {
    try {
      isLoading.value = true;
      Uri uri = Uri.parse('$appBaseUrl/users/forget-password');
      final response = await http.post(uri, body: {
        "email": email.value,
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
      email.value = "";
      isLoading.value = false;
    }
  }
}
