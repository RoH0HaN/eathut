import 'package:eathut/constants/icons.dart';
import 'package:eathut/constants/images.dart';
import 'package:eathut/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/routes/routes.dart';
import '../../../../utils/validation.dart';
import '../../../../widgets/button_loading_widget.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/password_text_field.dart';
import '../../../../widgets/social_button.dart';
import '../../controllers/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());
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
                    AppTexts.signUp,
                    style: GoogleFonts.poppins(
                      color: white,
                      fontSize: 80.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    AppTexts.pleaseSignUpToYourAccount,
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
                        SizedBox(height: 20.h),
                        CustomTextField(
                          hintText: "John Doe",
                          labelText: "Name",
                          textEditingController: controller.nameCon,
                          prefixIcon: Icons.person_2_outlined,
                          validator: validateString,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          hintText: "example@domain.com",
                          labelText: "E-Mail",
                          textEditingController: controller.emailCon,
                          prefixIcon: Icons.email_outlined,
                          validator: validateEmail,
                        ),
                        SizedBox(height: 20.h),
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
                        SizedBox(height: 50.h),
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            height: 150.h,
                            child: ElevatedButton.icon(
                              onPressed: controller.isLoading.value
                                  ? () {}
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        controller.signUpUser(context);
                                      }
                                    },
                              label: controller.isLoading.value
                                  ? const ButtonLoadingWidget()
                                  : Text(
                                      AppTexts.signUp.toUpperCase(),
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
                        SizedBox(height: 10.h),
                        TextButton(
                          onPressed: () {
                            Get.offNamed(AppRoutes.login);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppTexts.alreadyHaveAnAccount,
                                  style: GoogleFonts.poppins(
                                    color: black,
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Log In now!',
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
                        const Text("OR"),
                        SizedBox(height: 10.h),
                        SocialButton(
                          text: AppTexts.continueWithGoogle.toUpperCase(),
                          image: AppIcons.googleIcon,
                          foreground: black,
                          background: socialButtonColor,
                          onPressed: () {},
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
