import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_style.dart';
import '../../core/constants/constants.dart';
import '../reusable_text.dart';

/*
 * Created on 12/03/2025
 * Created by Ariful Islam
 * Updated on 06/04/2025
 */
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.btnWidth,
    this.btnHeight,
    this.btnColor,
    this.gradient,
    this.border,
    this.radius,
    required this.text,
    this.textColor,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.isLoading = false,
    this.isDisabled = false,
    this.style = ButtonStyle.filled,
    this.elevation = 0.0,
  });

  final void Function()? onTap;
  final double? btnWidth;
  final double? btnHeight;
  final Color? btnColor;
  final Gradient? gradient;
  final BorderSide? border;
  final double? radius;
  final String text;
  final Color? textColor;
  final Widget? icon;
  final IconPosition? iconPosition;
  final bool isLoading;
  final bool isDisabled;
  final ButtonStyle style;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = isDisabled
        ? kDark.withValues(alpha: 0.3)
        : btnColor ?? kPrimary;
    final effectiveTextColor = isDisabled
        ? kLightWhite.withValues(alpha: 0.5)
        : textColor ?? kLightWhite;
    final effectiveBorder = style == ButtonStyle.outlined
        ? Border.all(
      color: border?.color ?? kPrimary,
      width: border?.width ?? 1.w,
      style: border?.style ?? BorderStyle.solid,
    )
        : null;

    return Semantics(
      button: true,
      label: text,
      enabled: !isDisabled && !isLoading,
      child: GestureDetector(
        onTap: isDisabled || isLoading ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: btnWidth ?? width,
          height: btnHeight ?? 35.h,
          decoration: BoxDecoration(
            color: style == ButtonStyle.filled && gradient == null
                ? effectiveColor
                : null,
            gradient: gradient,
            border: effectiveBorder, // Fixed: Now a Border?
            borderRadius: BorderRadius.circular(radius ?? 9.r),
            boxShadow: elevation > 0
                ? [
              BoxShadow(
                color: kDark.withValues(alpha: 0.2),
                blurRadius: 4.r,
                offset: Offset(0, 2.h),
              ),
            ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isDisabled || isLoading ? null : onTap,
              borderRadius: BorderRadius.circular(radius ?? 9.r),
              child: Center(
                child: isLoading
                    ? SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: CircularProgressIndicator(
                    color: effectiveTextColor,
                    strokeWidth: 2.w,
                  ),
                )
                    : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null && iconPosition == IconPosition.leading)
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: icon,
                      ),
                    Flexible(
                      child: ReusableText(
                        text: text,
                        style: appStyle(12.sp, effectiveTextColor, FontWeight.w600),
                      ),
                    ),
                    if (icon != null && iconPosition == IconPosition.trailing)
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: icon,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum ButtonStyle { filled, outlined, text }

enum IconPosition { leading, trailing }