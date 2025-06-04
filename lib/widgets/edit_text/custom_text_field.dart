import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType keyboardType; // Changed from inputType
  final bool enabled;
  final int? maxLines;
  final String? hintText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    this.validator,
    this.keyboardType = TextInputType.text, // Changed from inputType
    this.enabled = true,
    this.maxLines = 1,
    this.hintText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  String? _errorText; // Store error message

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    // Listen to controller changes to validate in real-time
    widget.controller.addListener(_validate);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validate);
    super.dispose();
  }

  void _validate() {
    if (widget.validator != null) {
      final error = widget.validator!(widget.controller.text);
      if (error != _errorText) {
        setState(() {
          _errorText = error;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: kDark.withValues(alpha: 0.1),
                blurRadius: 8.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword ? _obscureText : false,
            validator: widget.validator,
            keyboardType: widget.keyboardType, // Changed from inputType
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            style: appStyle(14.sp, kDark, FontWeight.w400),
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              labelStyle: appStyle(14.sp, kDark.withValues(alpha: 0.6), FontWeight.w400),
              hintStyle: appStyle(14.sp, kDark.withValues(alpha: 0.4), FontWeight.w400),
              prefixIcon: Icon(
                widget.icon,
                color: kPrimary,
                size: 20.sp,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: kPrimary.withValues(alpha: 0.6),
                  size: 20.sp,
                ),
              ) : null,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: kPrimary, width: 1.5.w),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: kRed, width: 1.5.w),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: kRed, width: 1.5.w),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              errorStyle: TextStyle(height: 0, fontSize: 0), // Hide built-in error text
            ),
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: EdgeInsets.only(left: 16.w,right: 16.w, top: 4.h),
            child: Text(
              _errorText!,
              style: appStyle(12.sp, kRed, FontWeight.w400),
              maxLines: 3, // Allow wrapping for long error messages
              overflow: TextOverflow.visible, // Ensure full text is visible
            ),
          ),
      ],
    );
  }
}