import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onFieldSubmitted;
  final int maxLines;
  final bool readOnly;
  final String? initialValue;
  final List<String>? autofillHints;
  final IconData? prefixIcon;

  const CustomTextField({
    super.key,
    this.textEditingController,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.maxLines = 1,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.initialValue,
    this.autofillHints,
    this.prefixIcon,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.textEditingController == null) {
      _controller = TextEditingController(text: widget.initialValue);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: widget.autofillHints,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      controller: widget.textEditingController ?? _controller,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      style: const TextStyle(color: black), // Set text color to white
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefixIcon),
        fillColor: textFieldFillColor.withOpacity(0.3),
        filled: true,
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
