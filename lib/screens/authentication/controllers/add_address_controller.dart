import 'package:eathut/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';

import '../../../constants/constants.dart';
import '../../../utils/helper.dart';

class AddAddressController extends GetxController {
  RxBool isLoading = false.obs;
  final box = GetStorage();
  String latitude = "";
  String longitude = "";

  final fullNameCon = TextEditingController();
  final addressCon = TextEditingController();
  final cityCon = TextEditingController();
  final landmarkCon = TextEditingController();
  final pinCodeCon = TextEditingController();
  final phoneCon = TextEditingController();

  void clearControllers() {
    fullNameCon.clear();
    addressCon.clear();
    cityCon.clear();
    landmarkCon.clear();
    pinCodeCon.clear();
    phoneCon.clear();
    latitude = "";
    longitude = "";
  }

  determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(errorSnackbar("Location service is disabled"));
      await openAppSettings();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      await openAppSettings();
    }

    return await Geolocator.getCurrentPosition();
  }

  addAddress(BuildContext context) async {
    try {
      Position position = await determinePosition(context);
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();

      if (latitude.isEmpty || longitude.isEmpty) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(errorSnackbar("Cant fetch to location, try again"));
        return;
      }
      isLoading.value = true;
      Uri uri = Uri.parse('$appBaseUrl/addresses/add-address');
      final response = await http.post(uri, headers: {
        'Authorization': 'Bearer ${box.read('accessToken')}',
      }, body: {
        "full_name": fullNameCon.text,
        "city": cityCon.text,
        "landmark": landmarkCon.text,
        "address": addressCon.text,
        "phone": phoneCon.text,
        "zip_code": pinCodeCon.text,
        "latitude": latitude,
        "longitude": longitude,
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(successSnackbar(jsonData['message']));
        await AuthenticationRepository.instance.fetchUserDetails();
        clearControllers();
        AuthenticationRepository.instance.setInitialScreen(context);
      } else {
        final jsonData = json.decode(response.body);
        print(jsonData);
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
}
