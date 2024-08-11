import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/texts.dart';
import '../screens/authentication/controllers/otp_controller.dart';

class ResendOTPButton extends StatelessWidget {
  const ResendOTPButton({
    super.key,
    required this.fromForgetPass,
  });

  final String fromForgetPass;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OTPController());
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton.icon(
            onPressed: () {
              if (fromForgetPass == "true") {
                // controller.resendForgetPasswordOTP(context);
              } else {
                // controller.resendOTP(context);
              }
            },
            label: const Text(AppTexts.resend, style: TextStyle(color: black)),
            icon: const Icon(Icons.replay, color: black)),
        Obx(
          () => controller.otpTimer.value == 60
              ? const Text("")
              : Text(
                  "in ${controller.otpTimer.value}s",
                  style: const TextStyle(color: baseColor),
                ),
        )
      ],
    );
  }
}
