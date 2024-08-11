import 'package:eathut/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:eathut/constants/constants.dart';
import 'package:eathut/models/api_error.dart';
import 'dart:convert';

class WishlistController extends GetxController {
  final box = GetStorage();
  RxBool isWishlist = false.obs;
  RxBool isLoading = false.obs;

  checkWishlist(String productID) async {
    try {
      isLoading.value = true;
      Uri uri = Uri.parse('$appBaseUrl/wishlists/check/$productID');
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${box.read('accessToken')}',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print(data);

        if (data['data'] == true) {
          isWishlist.value = true;
        } else {
          isWishlist.value = false;
        }

        print(isWishlist.value);
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  addToWishlist(String productID) async {
    try {
      isLoading.value = true;
      Uri uri = Uri.parse('$appBaseUrl/wishlists/add/$productID');
      final response = await http.post(uri, headers: {
        'Authorization': 'Bearer ${box.read('accessToken')}',
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(successSnackbar('Added to wishlist'));
        isWishlist.value = true;
      } else {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(errorSnackbar('Something went wrong'));
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  removeFromWishlist(String productID) async {
    try {
      isLoading.value = true;
      Uri uri = Uri.parse('$appBaseUrl/wishlists/remove/$productID');
      final response = await http.post(uri, headers: {
        'Authorization': 'Bearer ${box.read('accessToken')}',
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(successSnackbar('Removed from wishlist'));
        isWishlist.value = false;
      } else {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(errorSnackbar('Something went wrong'));
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }
}
