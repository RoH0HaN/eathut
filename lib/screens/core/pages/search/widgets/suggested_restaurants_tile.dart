import 'package:eathut/constants/colors.dart';
import 'package:eathut/constants/images.dart';
import 'package:eathut/screens/core/models/restaurant_model.dart';
import 'package:eathut/screens/core/models/suggestion_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/routes/routes.dart';

class SuggestedRestaurantsTile extends StatelessWidget {
  const SuggestedRestaurantsTile({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final RestaurantModel suggestedRestaurant =
            RestaurantModel.fromJson(restaurant.toJson());
        Get.toNamed(AppRoutes.restaurantDetails,
            arguments: suggestedRestaurant);
      },
      child: Container(
        height: 250.h,
        margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 200.h,
              width: 250.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(
                      restaurant.logoUrl ?? AppImages.demoImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 30.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    restaurant.restaurantName ?? "Restaurant",
                    style: GoogleFonts.poppins(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '★ ${restaurant.rating}',
                          style: TextStyle(
                            fontSize: 40.h,
                            fontWeight: FontWeight.bold,
                            color: baseColor,
                          ),
                        ),
                        TextSpan(
                          text: ' Total ${restaurant.ratingCount} reviews',
                          style: TextStyle(
                            fontSize: 35.h,
                            color: grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
