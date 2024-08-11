import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/constants.dart';
import '../../utils/helper.dart';
import 'package:http/http.dart' as http;

class CartRepository extends GetxController {
  static CartRepository get instance => Get.find();
  final box = GetStorage();

  RxBool isLoading = false.obs;

  GlobalKey<NavigatorState> dialogKey = GlobalKey<NavigatorState>();

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false, // Prevent back button dismiss
          child: Dialog(
            key: dialogKey,
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Text("Loading..."),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void addToCart(String productID, int quantity, BuildContext context) async {
    try {
      isLoading.value = true;

      showLoadingDialog(context);

      Uri uri = Uri.parse('$appBaseUrl/carts/add');
      final response = await http.post(uri, headers: {
        'Authorization': 'Bearer ${box.read('accessToken')}',
      }, body: {
        "product_id": productID,
        "quantity": quantity.toString(),
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(successSnackbar(jsonData['message']));
      } else {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(errorSnackbar(jsonData['message']));
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;

      Get.back();
    }
  }

  void removeFromCart(String productID, BuildContext context) async {
    try {
      isLoading.value = true;

      showLoadingDialog(context);

      Uri uri = Uri.parse('$appBaseUrl/carts/remove/$productID');
      final response = await http.delete(uri, headers: {
        'Authorization': 'Bearer ${box.read('accessToken')}',
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(successSnackbar(jsonData['message']));
      } else {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(errorSnackbar(jsonData['message']));
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;

      Get.back();
    }
  }
}
