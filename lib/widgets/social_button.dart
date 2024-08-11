import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'button_loading_widget.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.text,
    required this.image,
    required this.foreground,
    required this.background,
    required this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final String image;
  final Color foreground, background;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: foreground,
          backgroundColor: background,
          side: BorderSide.none,
        ),
        icon: isLoading
            ? const SizedBox()
            : Image(
                image: AssetImage(image),
                height: 24,
                width: 24,
              ),
        label: isLoading
            ? const ButtonLoadingWidget()
            : Text(
                text,
                style: GoogleFonts.poppins(
                  color: foreground,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
