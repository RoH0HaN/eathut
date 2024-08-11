import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants/constants.dart';
import '../../screens/authentication/models/user_model.dart';
import '../../utils/helper.dart';
import '../../utils/routes/routes.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final box = GetStorage();

  late final Rx<UserModel?> currentUser;

  int onBoarding = 0;
  RxBool isLoading = false.obs;

  String? get userId => currentUser.value?.id;
  String? get name => currentUser.value?.name;
  String? get email => currentUser.value?.email;
  String? get userType => currentUser.value?.userType;
  bool? get verificationStatus => currentUser.value?.mailVerification ?? false;
  String? get profilePic => currentUser.value?.profilePic;
  Address? get address => currentUser.value?.address;

  @override
  void onInit() async {
    currentUser = Rx<UserModel?>(null);

    super.onInit();
  }

  @override
  void onReady() async {
    await fetchUserDetails();
    super.onReady();
  }

  fetchUserDetails() async {
    try {
      isLoading.value = true;
      if (box.read('accessToken') != null &&
          !JwtDecoder.isExpired(box.read('accessToken'))) {
        Uri uri = Uri.parse('$appBaseUrl/users/current-user');
        final response = await http.get(uri, headers: {
          'Authorization': 'Bearer ${box.read('accessToken')}',
        });
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          if (jsonData['data']['user'] != null) {
            currentUser.value = UserModel.fromJson(jsonData['data']['user']);
          } else {
            currentUser.value = null;
          }
        } else {
          final jsonData = json.decode(response.body);
          currentUser.value = null;
          ScaffoldMessenger.of(Get.context!)
              .showSnackBar(errorSnackbar(jsonData['message']));
        }
      } else {
        currentUser.value = null;
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  setInitialScreen(BuildContext context) {
    if (currentUser.value == null) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      if (verificationStatus == true) {
        if (address != null) {
          Get.offAllNamed(AppRoutes.home);
        } else {
          Get.offAllNamed(AppRoutes.addAddress);
        }
      } else {
        resendOTP(context);
      }
    }
  }

  void resendOTP(BuildContext context) async {
    try {
      Uri uri = Uri.parse('$appBaseUrl/users/resend-otp');
      final response = await http.post(uri, body: {
        "email": email,
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(successSnackbar(jsonData['message']));
        Get.toNamed(AppRoutes.otp, parameters: {
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
    }
  }

  void logOut(BuildContext context) {
    box.remove('accessToken');
    currentUser.value = null;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(successSnackbar("Logged out successfully"));
    setInitialScreen(context);
  }
}
