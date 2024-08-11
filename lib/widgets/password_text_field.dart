import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final IconData? prefixIcon;
  final bool isPass;
  final VoidCallback showHidePass;

  const PasswordTextField({
    super.key,
    this.textEditingController,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.prefixIcon,
    required this.isPass,
    required this.showHidePass,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<PasswordTextField> {
  TextEditingController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController ?? _controller,
      validator: widget.validator,
      style: const TextStyle(color: black),
      obscureText: widget.isPass, // Set text color to white
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefixIcon),
        fillColor: textFieldFillColor.withOpacity(0.3),
        filled: true,
        suffixIcon: IconButton(
            onPressed: widget.showHidePass,
            icon: widget.isPass
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility)),
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: GoogleFonts.poppins(
          color: grey,
          fontSize: 40.sp,
          fontWeight: FontWeight.w500,
        ),
        labelStyle: GoogleFonts.poppins(
          color: black,
          fontSize: 40.sp,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: grey.withOpacity(0.2)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: grey.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: grey.withOpacity(0.2)),
        ),
      ),
    );
  }
}
