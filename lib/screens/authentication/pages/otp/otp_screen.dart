import 'package:eathut/constants/images.dart';
import 'package:eathut/constants/texts.dart';
import 'package:eathut/widgets/button_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants/colors.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../widgets/resend_otp_button.dart';
import '../../controllers/otp_controller.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'];
    final otp = Get.parameters['otp'];
    final fromForgetPass = Get.parameters['fromForgetPass'];

    OtpFieldController otpController = OtpFieldController();
    final OTPController controller = Get.put(OTPController());

    controller.serverOtp.value = otp!;
    controller.email.value = email!;
    return Scaffold(
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
                    AppTexts.verification,
                    style: GoogleFonts.poppins(
                      color: white,
                      fontSize: 80.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    AppTexts.verificationSubtitle,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppTexts.code,
                            style: GoogleFonts.poppins(
                              color: black,
                              fontSize: 35.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ResendOTPButton(
                            fromForgetPass: fromForgetPass!,
                          ),
                        ],
                      ),
                      OTPTextField(
                          controller: otpController,
                          length: 4,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: 45,
                          fieldStyle: FieldStyle.box,
                          outlineBorderRadius: 15,
                          style: const TextStyle(fontSize: 17),
                          onChanged: (pin) {},
                          onCompleted: (pin) {
                            controller.otp.value = pin;
                          }),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: controller.isLoading.value
                                ? () {}
                                : () {
                                    if (fromForgetPass == "true") {
                                      controller
                                          .verifyForgetPasswordOTP(context);
                                    } else {
                                      controller.verifyOTP(context);
                                    }
                                  },
                            label: controller.isLoading.value
                                ? const ButtonLoadingWidget()
                                : Text(
                                    AppTexts.verifyOTP,
                                    style: GoogleFonts.poppins(
                                      color: white,
                                      fontSize: 40.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            icon: controller.isLoading.value
                                ? const SizedBox()
                                : const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),
                    ],
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
