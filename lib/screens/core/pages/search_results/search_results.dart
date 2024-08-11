import 'dart:async';
import 'dart:convert';

import 'package:eathut/repositories/authentication_repository/authentication_repository.dart';
import 'package:eathut/widgets/food_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/constants.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../models/food_model.dart';
import 'package:http/http.dart' as http;

import '../search/widgets/popular_fast_food_card.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<FoodModel> searchResult = [];
  final _searchQuery = TextEditingController();
  Timer? _debounce;
  String searchText = "";
  final box = GetStorage();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchQuery.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        leading: IconButton.filled(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              grey.withOpacity(0.3),
            ), // Set the desired fill color
          ),
          onPressed: () {
            Get.back();
          },
          icon: const Icon(LineAwesomeIcons.angle_left_solid),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(
              hintText: "Search foods....",
              labelText: "Search",
              textEditingController: _searchQuery,
              prefixIcon: LineAwesomeIcons.search_solid,
            ),
            SizedBox(
              height: 40.h,
            ),
            Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : searchResult.isEmpty
                        ? const Center(
                            child: Text("No results found"),
                          )
                        : GridView.builder(
                            itemCount: searchResult.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.w,
                                    mainAxisSpacing: 10.h,
                                    mainAxisExtent: 650.h),
                            itemBuilder: (context, index) {
                              FoodModel food = searchResult[index];
                              return FoodCard(
                                food: food,
                              );
                            },
                          )),
          ],
        ),
      ),
    );
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (this.searchText != _searchQuery.text.trim()) {
        this.searchText = _searchQuery.text.trim();
        search();
      }
    });
  }

  @override
  void dispose() {
    _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  search() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse(
          '$appBaseUrl/foods/search/$searchText/${AuthenticationRepository.instance.address?.zipCode ?? "12354"}'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          searchResult = foodModelFromJson(json.encode(jsonData['data']));
        });
      }
    } catch (e) {
      e.printError();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
