import 'package:eathut/constants/images.dart';
import 'package:eathut/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/validation.dart';
import '../../../../widgets/button_loading_widget.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../controllers/forget_password_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgetPasswordController controller =
        Get.put(ForgetPasswordController());
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // backgroundColor: black,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              child: SvgPicture.asset(AppImages.loginSignUpBackground,
                  fit: BoxFit.cover),
            ),
            Positioned(
              top: 600.h,
              left: 20.w,
              right: 20.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppTexts.forgotPasswordTitle,
                    style: GoogleFonts.poppins(
                      color: white,
                      fontSize: 80.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    AppTexts.forgotPasswordSubtitle,
                    style: GoogleFonts.poppins(
                      color: white,
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.only(left: 50.w, right: 50.w, top: 50.h),
                  height: ScreenUtil().screenHeight * 0.3,
                  width: ScreenUtil().screenWidth,
                  decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        CustomTextField(
                          hintText: "example@domain.com",
                          labelText: "E-Mail",
                          textEditingController: controller.emailCon,
                          prefixIcon: Icons.email_outlined,
                          validator: validateEmail,
                        ),
                        SizedBox(height: 50.h),
                        Obx(
                          () => SizedBox(
                            height: 150.h,
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: controller.isLoading.value
                                  ? () {}
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        controller
                                            .sendForgetPasswordOTP(context);
                                      }
                                    },
                              label: controller.isLoading.value
                                  ? const ButtonLoadingWidget()
                                  : Text(
                                      AppTexts.sendOTP.toUpperCase(),
                                      style: GoogleFonts.poppins(
                                        color: white,
                                        fontSize: 40.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                              icon: controller.isLoading.value
                                  ? const SizedBox()
                                  : const Icon(Icons.numbers),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
