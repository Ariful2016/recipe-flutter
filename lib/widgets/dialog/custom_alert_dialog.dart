import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_style.dart';
import '../../core/constants/constants.dart';
import '../../widgets/button/custom_button.dart' as CustomWidgets; // Prefixed import
import '../reusable_text.dart';

/*
 * Created on 06/06/2023
 * Created by Ariful Islam
 * Updated on 06/06/2023
 */
class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    required this.icon,
    this.imagePath,
    this.titleColor,
    this.messageColor,
    this.backgroundColor,
    this.primaryButtonText = 'OK',
    this.secondaryButtonText,
    this.primaryButtonAction,
    this.secondaryButtonAction,
    this.primaryButtonColor,
    this.secondaryButtonColor,
    this.radius = 16.0,
  });

  final AlertType type;
  final String title;
  final String message;
  final IconData? icon;
  final String? imagePath;
  final Color? titleColor;
  final Color? messageColor;
  final Color? backgroundColor;
  final String primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? primaryButtonAction;
  final VoidCallback? secondaryButtonAction;
  final Color? primaryButtonColor;
  final Color? secondaryButtonColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final effectiveIcon = icon ??
        (type == AlertType.error
            ? Icons.error_outline
            : type == AlertType.success
                ? Icons.check_circle_outline
                : null);
    final effectiveIconColor = type == AlertType.error
        ? kRed
        : type == AlertType.success
            ? Colors.green
            : kPrimary;
    final effectiveTitleColor = titleColor ?? kDark;
    final effectiveMessageColor = messageColor ?? kDark.withValues(alpha: 0.7);
    final effectiveBackgroundColor = backgroundColor ?? kWhite;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: ModalRoute.of(context)!.animation!,
          curve: Curves.easeOutBack,
        ),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: ModalRoute.of(context)!.animation!,
            curve: Curves.easeIn,
          ),
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: effectiveBackgroundColor,
              borderRadius: BorderRadius.circular(radius.r),
              boxShadow: [
                BoxShadow(
                  color: kDark.withValues(alpha: 0.1),
                  blurRadius: 8.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (effectiveIcon != null || imagePath != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: imagePath != null
                        ? Image.asset(
                            imagePath!,
                            width: 48.w,
                            height: 48.w,
                            fit: BoxFit.contain,
                          )
                        : Icon(
                            effectiveIcon,
                            size: 48.sp,
                            color: effectiveIconColor,
                          ),
                  ),
                ReusableText(
                  text: title,
                  style: appStyle(18.sp, effectiveTitleColor, FontWeight.w600),
                ),
                SizedBox(height: 8.h),
                ReusableText(
                  text: message,
                  style:
                      appStyle(14.sp, effectiveMessageColor, FontWeight.w400),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: secondaryButtonText != null
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    if (secondaryButtonText != null)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: CustomWidgets.CustomButton(
                            text: secondaryButtonText!,
                            style: CustomWidgets.ButtonStyle.outlined,
                            // Prefixed
                            border: BorderSide(color: kDark, width: 1.w),
                            textColor: kDark,
                            btnHeight: 40.h,
                            radius: 8.r,
                            onTap: secondaryButtonAction ??
                                () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                    Expanded(
                      child: CustomWidgets.CustomButton(
                        text: primaryButtonText,
                        btnColor: primaryButtonColor ?? kPrimary,
                        btnHeight: 40.h,
                        radius: 8.r,
                        onTap: primaryButtonAction ??
                            () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum AlertType { error, success, custom }

// Helper method to show the dialog
Future<void> showCustomAlertDialog(
  BuildContext context, {
  required AlertType type,
  required String title,
  required String message,
  IconData? icon,
  String? imagePath,
  Color? titleColor,
  Color? messageColor,
  Color? backgroundColor,
  String primaryButtonText = 'OK',
  String? secondaryButtonText,
  VoidCallback? primaryButtonAction,
  VoidCallback? secondaryButtonAction,
  Color? primaryButtonColor,
  Color? secondaryButtonColor,
  double radius = 16.0,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        type: type,
        title: title,
        message: message,
        icon: icon,
        imagePath: imagePath,
        titleColor: titleColor,
        messageColor: messageColor,
        backgroundColor: backgroundColor,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        primaryButtonAction: primaryButtonAction,
        secondaryButtonAction: secondaryButtonAction,
        primaryButtonColor: primaryButtonColor,
        secondaryButtonColor: secondaryButtonColor,
        radius: radius,
      );
    },
  );
}
