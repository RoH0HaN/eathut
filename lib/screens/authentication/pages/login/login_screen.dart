import 'package:eathut/constants/icons.dart';
import 'package:eathut/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/texts.dart';
import '../../../../utils/routes/routes.dart';
import '../../../../utils/validation.dart';
import '../../../../widgets/button_loading_widget.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/password_text_field.dart';
import '../../../../widgets/social_button.dart';
import '../../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
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
              top: 400.h,
              left: 20.w,
              right: 20.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppTexts.login,
                    style: GoogleFonts.poppins(
                      color: white,
                      fontSize: 80.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    AppTexts.pleaseSignInToYourAccount,
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
                  height: ScreenUtil().screenHeight * 0.6,
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
                        const SizedBox(
                          height: 20.0,
                        ),
                        Obx(
                          () => PasswordTextField(
                            hintText: "**********",
                            labelText: "Password",
                            textEditingController: controller.passCon,
                            prefixIcon: Icons.password_outlined,
                            validator: validatePassword,
                            isPass: controller.hidePassword.value,
                            showHidePass: controller.togglePasswordVisibility,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.forgetPassword);
                              },
                              child: Text(
                                AppTexts.forgotPassword,
                                style: GoogleFonts.poppins(
                                  color: baseColor,
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        SizedBox(height: 10.h),
                        Obx(
                          () => SizedBox(
                            height: 150.h,
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: controller.isLoading.value
                                  ? () {}
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        controller.loginUser(context);
                                      }
                                    },
                              label: controller.isLoading.value
                                  ? const ButtonLoadingWidget()
                                  : Text(
                                      AppTexts.login.toUpperCase(),
                                      style: GoogleFonts.poppins(
                                        color: white,
                                        fontSize: 40.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                              icon: controller.isLoading.value
                                  ? const SizedBox()
                                  : const Icon(Icons.login_outlined),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offNamed(AppRoutes.signUp);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppTexts.dontHaveAnAccount,
                                  style: GoogleFonts.poppins(
                                    color: black,
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Sign Up now!',
                                  style: GoogleFonts.poppins(
                                    color: baseColor,
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10.0,
                        // ),
                        Text(
                          "OR",
                          style: GoogleFonts.poppins(
                            color: black,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SocialButton(
                            text: AppTexts.continueWithGoogle.toUpperCase(),
                            image: AppIcons.googleIcon,
                            foreground: black,
                            background: socialButtonColor,
                            onPressed: () {}),
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
