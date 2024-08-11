import 'package:eathut/constants/colors.dart';
import 'package:eathut/constants/images.dart';
import 'package:eathut/screens/core/models/restaurant_model.dart';
import 'package:eathut/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenRestaurantTile extends StatelessWidget {
  const OpenRestaurantTile({super.key, required this.restaurant});

  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.restaurantDetails, arguments: restaurant);
      },
      child: Container(
        height: 550.h,
        margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                          restaurant.logoUrl ?? AppImages.demoImageUrl),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.restaurantName ?? "Restaurant",
                    style: GoogleFonts.poppins(
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 20.h),
                  Text(
                    "${restaurant.restaurantType} cuisine",
                    style: GoogleFonts.poppins(
                      color: grey,
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 30.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '★ ${restaurant.rating ?? 0.0}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: baseColor,
                          ),
                        ),
                        TextSpan(
                          text: ' Total ${restaurant.ratingCount} reviews',
                          style: const TextStyle(
                            fontSize: 16,
                            color: grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
