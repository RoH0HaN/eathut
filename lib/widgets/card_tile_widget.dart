import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class CardTileWidget extends StatelessWidget {
  const CardTileWidget(
      {super.key,
      required this.firstIconData,
      this.secondIconData,
      this.firstOnPressed,
      this.secondOnPressed,
      required this.firstTextInfo,
      this.secondTextInfo});

  final String firstIconData;
  final String? secondIconData;
  final String firstTextInfo;
  final String? secondTextInfo;
  final void Function()? firstOnPressed;
  final void Function()? secondOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: textFieldFillColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                firstIconData,
                height: 48,
                width: 48,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  firstTextInfo,
                  style: GoogleFonts.montserrat(
                    fontSize: 40.sp,
                    color: black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: firstOnPressed,
                icon: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
          if (secondIconData != null && secondTextInfo != null)
            const SizedBox(
              height: 10,
            ),
          if (secondIconData != null && secondTextInfo != null)
            Row(
              children: [
                SvgPicture.asset(
                  secondIconData ?? "",
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    secondTextInfo ?? "",
                    style: GoogleFonts.montserrat(
                      fontSize: 40.sp,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: secondOnPressed,
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
