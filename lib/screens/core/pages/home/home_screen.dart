import 'package:carousel_slider/carousel_slider.dart';
import 'package:eathut/constants/images.dart';
import 'package:eathut/constants/texts.dart';
import 'package:eathut/screens/core/hooks/fetch_all_banners.dart';
import 'package:eathut/screens/core/hooks/fetch_all_categories.dart';
import 'package:eathut/screens/core/models/banner_model.dart';
import 'package:eathut/screens/core/models/category_model.dart';
import 'package:eathut/screens/core/pages/home/widgets/category_widget.dart';
import 'package:eathut/utils/helper.dart';
import 'package:eathut/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../repositories/authentication_repository/authentication_repository.dart';
import 'widgets/home_bottom_navigation_bar.dart';
import 'widgets/open_restaurents.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Using Banner Hook
    final bannerHookResult = useFetchAllBanners();
    List<BannerModel>? banners = bannerHookResult.data;
    bool bannerIsLoading = bannerHookResult.isLoading;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        leading: IconButton.filled(
          color: white,
          style:
              IconButton.styleFrom(backgroundColor: baseColor, elevation: 10),
          onPressed: () {},
          icon: const Icon(Icons.pin_drop_outlined),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.location,
              style: GoogleFonts.poppins(
                color: baseColor,
                fontSize: 35.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AuthenticationRepository.instance.address?.address ??
                  "My home address",
              style: GoogleFonts.poppins(
                color: grey,
                fontSize: 25.sp,
              ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton.filled(
              color: white,
              style:
                  IconButton.styleFrom(backgroundColor: black, elevation: 10),
              onPressed: () {
                Get.toNamed(AppRoutes.cart);
              },
              icon: const Icon(LineAwesomeIcons.shopping_cart_solid, size: 30),
            ),
          ),
        ],
      ),
      bottomNavigationBar: HomeBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hey ${AuthenticationRepository.instance.name}, ',
                      style: GoogleFonts.poppins(
                        color: black,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: getGreeting(),
                      style: GoogleFonts.poppins(
                        color: baseColor,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              bannerIsLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 500.h,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemCount: banners?.length ?? 0,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        BannerModel banner = banners![itemIndex];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  banner.imageUrl ?? AppImages.demoImageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(
                height: 40.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.search);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: baseColorBlended.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        LineAwesomeIcons.search_solid,
                        color: grey,
                      ),
                      SizedBox(
                        width: 40.w,
                      ),
                      Expanded(
                        child: Text(
                          AppTexts.searchText,
                          style: GoogleFonts.poppins(
                            color: grey,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              const CategoryWidget(),
              SizedBox(
                height: 40.h,
              ),
              const OpenRestaurants(),
            ],
          ),
        ),
      ),
    );
  }
}
