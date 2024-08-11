import 'package:eathut/constants/texts.dart';
import 'package:eathut/screens/core/models/suggestion_model.dart';
import 'package:eathut/screens/core/pages/search/widgets/popular_fast_food_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularFastFoods extends StatelessWidget {
  const PopularFastFoods({super.key, required this.foods});

  final List<Food> foods;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.popularFastFoods,
          style: GoogleFonts.poppins(
            fontSize: 50.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.h),
        foods.isEmpty
            ? Center(
                child: Text(
                  "No suggested foods",
                  style: GoogleFonts.poppins(
                      fontSize: 40.sp, fontWeight: FontWeight.w500),
                ),
              )
            : GridView.builder(
                itemCount: foods.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemBuilder: (context, index) {
                  Food food = foods[index];
                  return PopularFastFoodCard(food: food);
                },
              )
      ],
    );
  }
}
