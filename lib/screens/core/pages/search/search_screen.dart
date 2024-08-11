import 'package:eathut/constants/colors.dart';
import 'package:eathut/repositories/authentication_repository/authentication_repository.dart';
import 'package:eathut/screens/core/pages/search/widgets/suggested_restaurants.dart';
import 'package:eathut/utils/routes/routes.dart';
import 'package:eathut/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../hooks/fetch_search_suggestions.dart';
import '../../models/suggestion_model.dart';
import 'widgets/popular_fast_foods.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Using Suggestion Hook
    final suggestionHookResult = useFetchSearchSuggestions();
    final suggestions = suggestionHookResult.data;
    final List<Restaurant> restaurants = suggestions?.restaurants ?? [];
    final List<Food> foods = suggestions?.foods ?? [];
    final isLoading = suggestionHookResult.isLoading;

    return Scaffold(
      backgroundColor: white,
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
        title: Text(
          'Search',
          style: GoogleFonts.rubik(fontSize: 50.sp),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton.filled(
              color: white,
              style:
                  IconButton.styleFrom(backgroundColor: black, elevation: 10),
              onPressed: () async {
                await AuthenticationRepository.instance.fetchUserDetails();
              },
              icon: const Icon(LineAwesomeIcons.shopping_cart_solid, size: 30),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.searchResults),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: textFieldFillColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LineAwesomeIcons.search_solid,
                        color: black,
                        size: 50.sp,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Search',
                        style: GoogleFonts.poppins(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 20.h),
                  SuggestedRestaurants(
                    restaurants: restaurants,
                  ),
                  SizedBox(height: 20.h),
                  PopularFastFoods(
                    foods: foods,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
