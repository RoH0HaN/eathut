import 'package:eathut/constants/colors.dart';
import 'package:eathut/screens/core/pages/home/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../hooks/fetch_all_categories.dart';
import '../../../models/category_model.dart';

class CategoryWidget extends HookWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //Using Banner Hook
    final categoryHookResult = useFetchAllCategories();
    List<CategoryModel>? categories = categoryHookResult.data;
    bool categoryIsLoading = categoryHookResult.isLoading;

    return categoryIsLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Categories",
                    style: GoogleFonts.poppins(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See all",
                      style: GoogleFonts.poppins(
                        color: baseColor,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories?.length ?? 0,
                  itemBuilder: (context, index) {
                    CategoryModel category = categories![index];
                    return CategoryTile(
                      category: category,
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 20.w),
                ),
              )
            ],
          );
  }
}
