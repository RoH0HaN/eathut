// import 'dart:async';
// import 'dart:convert';
// import 'package:eathut/repositories/authentication_repository/authentication_repository.dart';
// import 'package:eathut/screens/core/models/restaurant_model.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// import '../../../constants/constants.dart';
// import '../../../models/api_error.dart';
// import '../../../models/fetch_hook.dart';

// FetchHook useFetchAllNearbyRestaurants() {
//   final restaurants = useState<List<RestaurantModel>?>(null);
//   final isLoading = useState<bool>(false);
//   final error = useState<Exception?>(null);
//   final apiError = useState<ApiError?>(null);

//   Future<void> fetchData() async {
//     try {
//       isLoading.value = true;

//       print("FETCHING RESTAURANTS...");

//       Uri uri = Uri.parse(
//           '$appBaseUrl/restaurants/all/${AuthenticationRepository.instance.address?.zipCode ?? "123456"}');
//       final response = await http.get(uri);

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         restaurants.value =
//             restaurantModelFromJson(json.encode(jsonData['data']));
//       } else {
//         apiError.value = apiErrorFromJson(response.body);
//       }
//     } catch (e) {
//       e.printError();
//       error.value = e as Exception;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   useEffect(() {
//     fetchData();
//     return null;
//   }, []);

//   void refetch() {
//     isLoading.value = true;
//     fetchData();
//   }

//   return FetchHook(
//     data: restaurants.value,
//     isLoading: isLoading.value,
//     error: error.value,
//     refetch: refetch,
//   );
// }

import 'dart:async';
import 'dart:convert';
import 'package:eathut/repositories/authentication_repository/authentication_repository.dart';
import 'package:eathut/screens/core/models/restaurant_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';
import '../../../models/api_error.dart';
import '../../../models/fetch_hook.dart';

FetchHook useFetchAllNearbyRestaurants() {
  final restaurants = useState<List<RestaurantModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);
  final zipCode = useState<String>(
      AuthenticationRepository.instance.address?.zipCode ?? "123456");

  Future<void> fetchData(String zipCode) async {
    try {
      isLoading.value = true;

      Uri uri = Uri.parse('$appBaseUrl/restaurants/all/$zipCode');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        restaurants.value =
            restaurantModelFromJson(json.encode(jsonData['data']));
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      e.printError();
      error.value = e as Exception;
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    final subscription = ever(
      AuthenticationRepository.instance.currentUser,
      (_) {
        zipCode.value =
            AuthenticationRepository.instance.address?.zipCode ?? "123456";
        fetchData(zipCode.value);
      },
    );

    // Initial fetch
    fetchData(zipCode.value);

    return subscription.dispose;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData(zipCode.value);
  }

  return FetchHook(
    data: restaurants.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
