import 'package:eathut/constants/colors.dart';
import 'package:eathut/screens/core/hooks/fetch_restaurant_foods.dart';
import 'package:eathut/screens/core/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/images.dart';
import '../../../../widgets/food_card.dart';
import '../../models/restaurant_model.dart';

class RestaurantDetailsScreen extends HookWidget {
  const RestaurantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RestaurantModel restaurant = Get.arguments;
    //Using Banner Hook
    final foodsHookResult =
        useFetchAllRestaurantFoods(restaurant.id ?? '123456');
    List<FoodModel>? foods = foodsHookResult.data;
    bool foodsIsLoading = foodsHookResult.isLoading;

    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 850.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100.r),
                        bottomRight: Radius.circular(100.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(
                            restaurant.logoUrl ?? AppImages.demoImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100.h,
                    left: 20.w,
                    child: IconButton.filled(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            white), // Set the desired fill color
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        LineAwesomeIcons.angle_left_solid,
                        color: black,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(50.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          LineAwesomeIcons.utensils_solid,
                          size: 80.h,
                          color: baseColor,
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Text(
                            restaurant.restaurantName ?? "Restaurant",
                            style: GoogleFonts.poppins(
                              fontSize: 70.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMiniStats(
                            LineAwesomeIcons.star, "${restaurant.rating}"),
                        _buildMiniStats(LineAwesomeIcons.truck_pickup_solid,
                            restaurant.pickup ?? false ? "YES" : "NO"),
                        _buildMiniStats(LineAwesomeIcons.box_open_solid,
                            restaurant.delivery ?? false ? "YES" : "NO"),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    const Divider(),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Restaurant location: ',
                            style: TextStyle(
                              fontSize: 40.sp,
                              color: grey,
                            ),
                          ),
                          TextSpan(
                            text: restaurant.restaurantPlace ?? 'ISLAMPUR',
                            style: TextStyle(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                              color: baseColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      "RATING",
                      style: GoogleFonts.poppins(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return const Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return const Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return const Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return const Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );

                          default:
                            return Container();
                        }
                      },
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      "Foods",
                      style: GoogleFonts.poppins(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    foodsIsLoading
                        ? const Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            itemCount: foods?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.w,
                                    mainAxisSpacing: 10.h,
                                    mainAxisExtent: 650.h),
                            itemBuilder: (context, index) {
                              FoodModel food = foods![index];
                              return FoodCard(food: food);
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildMiniStats(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 60.h,
          color: baseColor,
        ),
        SizedBox(width: 20.w),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 40.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
