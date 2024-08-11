import 'package:eathut/screens/core/models/food_model.dart';
import 'package:eathut/widgets/food_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../constants/colors.dart';
import '../../hooks/fetch_foods_by_category.dart';

class CategoryScreen extends HookWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String categoryName = Get.arguments;

    //Using foods by category hooks
    final hookResult = useFetchFoodsByCategory(categoryName);
    final foods = hookResult.data;
    final isLoading = hookResult.isLoading;

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
          categoryName,
          style: GoogleFonts.rubik(fontSize: 50.sp),
        ),
        actions: [
          Container(
            width: 400.w,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : foods!.isEmpty
              ? const Center(child: Text("No food found"))
              : Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: GridView.builder(
                    itemCount: foods.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        mainAxisExtent: 650.h),
                    itemBuilder: (context, index) {
                      final FoodModel food = foods![index];
                      return FoodCard(food: food);
                    },
                  ),
                ),
    );
  }
}
