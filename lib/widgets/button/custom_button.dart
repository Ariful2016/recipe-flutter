import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_style.dart';
import '../../core/constants/constants.dart';
import '../reusable_text.dart';

/*
 * Created on 12/03/2025
 * Created by Ariful Islam
 */
class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.onTap,
      this.btnWidth,
      this.btnHeight,
      this.btnColor,
      this.radius,
      required this.text, this.textcolor});

  final void Function()? onTap;
  final double? btnWidth;
  final double? btnHeight;
  final Color? btnColor;
  final double? radius;
  final String text;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: btnWidth ?? width,
          height: btnHeight ?? 28.h,
          decoration: BoxDecoration(
              color: btnColor ?? kPrimary,
              borderRadius: BorderRadius.circular(radius ?? 9.r)),
          child: Center(
              child: ReusableText(
                  text: text,
                  style: appStyle(12, textcolor ?? kLightWhite, FontWeight.w600))),
        ));
  }
}
