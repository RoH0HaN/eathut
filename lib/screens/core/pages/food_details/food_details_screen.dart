import 'package:eathut/constants/colors.dart';
import 'package:eathut/constants/images.dart';
import 'package:eathut/screens/core/controllers/wishlist_controller.dart';
import 'package:eathut/screens/core/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class FoodDetailsScreen extends StatelessWidget {
  const FoodDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodModel food = Get.arguments;

    final WishlistController controller = Get.put(WishlistController());
    controller.checkWishlist(food.id!);
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
                            food.imageUrl ?? AppImages.demoImageUrl),
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
                  Positioned(
                    top: 100.h,
                    right: 20.w,
                    child: Obx(
                      () => IconButton.filled(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              white), // Set the desired fill color
                        ),
                        onPressed: () {
                          if (controller.isWishlist.value) {
                            controller.removeFromWishlist(food.id!);
                          } else {
                            controller.addToWishlist(food.id!);
                          }
                        },
                        icon: Icon(
                          controller.isWishlist.value
                              ? LineAwesomeIcons.heart_solid
                              : LineAwesomeIcons.heart,
                          color: baseColor,
                        ),
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
                    Text(
                      food.foodName ?? "Food Name",
                      style: GoogleFonts.poppins(
                        fontSize: 80.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Icon(
                          LineAwesomeIcons.utensils_solid,
                          size: 60.h,
                          color: baseColor,
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Text(
                            food.restaurantName ?? "Restaurant",
                            style: GoogleFonts.poppins(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Wrap(
                      children: List.generate(
                        food.foodTags?.length ?? 0,
                        (index) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          margin: EdgeInsets.only(right: 10.w),
                          decoration: BoxDecoration(
                            color: baseColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(food.foodTags![index],
                              style: GoogleFonts.poppins(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ),
                    const Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "₹${food.price?.discountPrice ?? 0.0}",
                          style: GoogleFonts.montserrat(
                            color: black,
                            fontSize: 60.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          "₹${food.price?.mrp ?? 0.0}",
                          style: GoogleFonts.montserrat(
                              color: grey.withOpacity(0.5),
                              fontSize: 45.sp,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough),
                        ),
                        const Spacer(),
                        Text(
                          "${food.price?.discount ?? 0.0}% off",
                          style: GoogleFonts.montserrat(
                            color: baseColor,
                            fontSize: 75.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMiniStats(
                            LineAwesomeIcons.star, "${food.rating}"),
                        _buildMiniStats(LineAwesomeIcons.truck_moving_solid,
                            "₹${food.price?.delCharge ?? 0.0}"),
                        _buildMiniStats(
                            LineAwesomeIcons.clock, "${food.preparationTime}"),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      food.description ?? "DESCRIPTION",
                      style: GoogleFonts.poppins(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.h),
        height: 400.h,
        decoration: BoxDecoration(
          color: textFieldFillColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "₹450.00",
                  style: GoogleFonts.poppins(
                    fontSize: 70.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 150.h,
                  width: 400.w,
                  decoration: BoxDecoration(
                    color: black,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton.filled(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              grey), // Set the desired fill color
                        ),
                        onPressed: () {},
                        icon: const Icon(LineAwesomeIcons.minus_solid),
                      ),
                      Text(
                        "1",
                        style: GoogleFonts.poppins(
                          fontSize: 50.sp,
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton.filled(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              grey), // Set the desired fill color
                        ),
                        onPressed: () {},
                        icon: const Icon(LineAwesomeIcons.plus_solid),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Add to cart",
                  style: GoogleFonts.poppins(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildMiniStats(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 80.h,
          color: baseColor,
        ),
        SizedBox(width: 20.w),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 50.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
