import 'dart:async';
import 'dart:convert';
import 'package:eathut/repositories/authentication_repository/authentication_repository.dart';
import 'package:eathut/screens/core/models/food_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';
import '../../../models/api_error.dart';
import '../../../models/fetch_hook.dart';

FetchHook useFetchFoodsByCategory(String category) {
  final foods = useState<List<FoodModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    try {
      isLoading.value = true;

      Uri uri = Uri.parse(
          '$appBaseUrl/foods/$category/${AuthenticationRepository.instance.address?.zipCode ?? "123456"}');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        foods.value = foodModelFromJson(json.encode(jsonData['data']));
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
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: foods.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
