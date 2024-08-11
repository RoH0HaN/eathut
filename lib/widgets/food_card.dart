import 'package:eathut/constants/colors.dart';
import 'package:eathut/constants/images.dart';
import 'package:eathut/repositories/cart_repository/cart_repository.dart';
import 'package:eathut/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../screens/core/models/food_model.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key, required this.food});

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.foodDetails, arguments: food);
      },
      child: Container(
        padding: EdgeInsets.all(20.h),
        height: 650.h,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 400.h,
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Container()),
                      Text(
                        food.foodName ?? 'Food',
                        style: GoogleFonts.poppins(
                          color: black,
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        food.restaurantName ?? 'Restaurant',
                        style: GoogleFonts.poppins(
                          color: black,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '₹ ${food.price?.discountPrice ?? 0.0}',
                              style: GoogleFonts.montserrat(
                                color: black,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton.filled(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  baseColor), // Set the desired fill color
                            ),
                            onPressed: () {
                              CartRepository.instance
                                  .addToCart(food.id!, 1, context);
                            },
                            icon:
                                const Icon(LineAwesomeIcons.plus_circle_solid),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 300.h,
                width: 400.w,
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image:
                          NetworkImage(food.imageUrl ?? AppImages.demoImageUrl),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
