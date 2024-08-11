import 'dart:async';
import 'dart:convert';
import 'package:eathut/screens/core/models/cart_model.dart';
import 'package:eathut/screens/core/models/category_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';
import '../../../models/api_error.dart';
import '../../../models/fetch_hook.dart';

FetchHook useFetchAllCartProducts() {
  final box = GetStorage();
  final cartProducts = useState<List<CartModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    try {
      isLoading.value = true;

      Uri uri = Uri.parse('$appBaseUrl/carts/get-all');
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${box.read('accessToken')}',
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        cartProducts.value = cartModelFromJson(json.encode(jsonData['data']));
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
    data: cartProducts.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
