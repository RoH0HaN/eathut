import 'package:eathut/constants/colors.dart';
import 'package:eathut/constants/images.dart';
import 'package:eathut/utils/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  final Color kDarkBlueColor = const Color(0xFF053149);

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Register',
      onFinish: () {
        Get.toNamed(AppRoutes.signUp);
      },
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: baseColor,
      ),
      skipTextButton: Text(
        'Skip',
        style: GoogleFonts.poppins(
          color: black,
          fontSize: 40.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        'Login',
        style: GoogleFonts.poppins(
          color: black,
          fontSize: 40.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailingFunction: () {
        Get.toNamed(AppRoutes.login);
      },
      controllerColor: kDarkBlueColor,
      totalPage: 3,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      imageHorizontalOffset: 0,
      imageVerticalOffset: 0,
      background: [
        Image.asset(
          AppImages.dummyImage,
          height: 1000.h,
          width: 1100.w,
        ),
        Image.asset(
          AppImages.dummyImage,
          height: 1000.h,
          width: 1100.w,
        ),
        Image.asset(
          AppImages.dummyImage,
          height: 1000.h,
          width: 1100.w,
        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 1300.h,
              ),
              Text(
                'Make your business online',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: baseColor,
                  fontSize: 60.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Get all your loved foods in one once place, you just place the orer we do the rest',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: grey,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 1300.h,
              ),
              Text(
                'You’ve reached your destination.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: baseColor,
                  fontSize: 60.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Get all your loved foods in one once place, you just place the orer we do the rest',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: grey,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 1300.h,
              ),
              Text(
                'Join with us in this new adventure',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: baseColor,
                  fontSize: 60.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Get all your loved foods in one once place, you just place the orer we do the rest',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: grey,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
