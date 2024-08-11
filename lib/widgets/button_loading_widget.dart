import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonLoadingWidget extends StatelessWidget {
  const ButtonLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          "Loading...",
          style: GoogleFonts.poppins(
            fontSize: 40.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
