import 'package:eathut/repositories/authentication_repository/authentication_repository.dart';
import 'package:eathut/screens/core/hooks/fetch_all_nearby_restaurants.dart';
import 'package:eathut/screens/core/models/restaurant_model.dart';
import 'package:eathut/screens/core/pages/home/widgets/open_restaurant_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenRestaurants extends HookWidget {
  const OpenRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    //Using Restaurant Hook
    final restaurantHookResult = useFetchAllNearbyRestaurants();
    List<RestaurantModel>? restaurants = restaurantHookResult.data;
    bool restaurantIsLoading = restaurantHookResult.isLoading;

    return restaurantIsLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Open restaurants nearby you",
                style: GoogleFonts.poppins(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: restaurants?.length ?? 0,
                itemBuilder: (context, index) {
                  RestaurantModel restaurant = restaurants![index];
                  return OpenRestaurantTile(restaurant: restaurant);
                },
                separatorBuilder: (context, index) => SizedBox(height: 20.h),
              )
            ],
          );
  }
}
