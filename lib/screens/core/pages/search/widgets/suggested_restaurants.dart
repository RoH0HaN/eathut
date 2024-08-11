import 'package:eathut/constants/colors.dart';
import 'package:eathut/constants/texts.dart';
import 'package:eathut/screens/core/pages/search/widgets/suggested_restaurants_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/suggestion_model.dart';

class SuggestedRestaurants extends StatelessWidget {
  const SuggestedRestaurants({super.key, required this.restaurants});

  final List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.suggestedRestaurants,
          style: GoogleFonts.poppins(
            fontSize: 50.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.h),
        restaurants.isEmpty
            ? Center(
                child: Text(
                  "No suggested restaurants",
                  style: GoogleFonts.poppins(
                      fontSize: 40.sp, fontWeight: FontWeight.w500),
                ),
              )
            : Column(
                children: List.generate(restaurants.length, (index) {
                  Restaurant restaurant = restaurants[index];
                  return SuggestedRestaurantsTile(restaurant: restaurant);
                }),
              )
      ],
    );
  }
}
