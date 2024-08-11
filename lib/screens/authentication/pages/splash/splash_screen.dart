import 'package:eathut/constants/images.dart';
import 'package:eathut/repositories/authentication_repository/authentication_repository.dart';
import 'package:eathut/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (AuthenticationRepository.instance.onBoarding == 0) {
        Get.offAllNamed(AppRoutes.onBoarding);
      } else {
        AuthenticationRepository.instance.setInitialScreen(context);
        // Get.offAllNamed(AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Image.asset(
                AppImages.splashImage,
                height: 1000.h,
              ),
            ),
            // Text("EatHut Chef's", style: GoogleFonts.lobster(fontSize: 150.sp)),
            SizedBox(
              height: 500.h,
              width: double.infinity,
              child: Lottie.asset(
                'assets/splash_loading.json',
              ),
            )
          ],
        ),
      ),
    );
  }
}
