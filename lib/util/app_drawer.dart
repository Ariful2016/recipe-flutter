import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';
import '../di/auth/auth_provider.dart';
import '../widgets/dialog/custom_alert_dialog.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  void _navigate(BuildContext context, String route) {
    Navigator.pop(context);
    context.go(route);
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    showCustomAlertDialog(
      context,
      type: AlertType.custom,
      icon: Icons.logout,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      primaryButtonText: 'Yes',
      secondaryButtonText: 'No',
      primaryButtonAction: () async {
        final authRepository = ref.read(authRepositoryProvider);
        await authRepository.signOut();
        Navigator.pop(context); // Close the dialog
        context.go('/login');
      },
      secondaryButtonAction: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Colors.transparent, // Transparent for glass effect
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Frosted glass blur
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1), // Semi-transparent white
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.2),
                  Colors.white.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.w),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10.r,
                  offset: Offset(0, 5.h),
                ),
              ],
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        kPrimary.withValues(alpha: 0.8),
                        kPrimary.withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: Colors.white.withValues(alpha: 0.3),
                        child: Icon(
                          Icons.person,
                          size: 30.sp,
                          color: kPrimary,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ReusableText(
                        text: 'Foody',
                        style: appStyle(24.sp, kWhite, FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                ..._buildDrawerItems(context, ref),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDrawerItems(BuildContext context, WidgetRef ref) {
    final items = [
      {'icon': Icons.person, 'text': 'Profile', 'route': '/profile'},
      {'icon': Icons.shopping_bag, 'text': 'Order', 'route': '/order'},
      {'icon': Icons.shopping_cart, 'text': 'Cart', 'route': '/cart'},
      {'icon': Icons.history, 'text': 'Order History', 'route': '/history'},
      {'icon': Icons.logout, 'text': 'Logout', 'route': null},
    ];

    return items.map((item) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: GestureDetector(
          onTap: () => item['route'] != null
              ? _navigate(context, item['route'] as String)
              : _logout(context, ref),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 0.5.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 5.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: ListTile(
              leading: Icon(
                item['icon'] as IconData,
                color: kPrimary,
                size: 24.sp,
              ),
              title: ReusableText(
                text: item['text'] as String,
                style: appStyle(14.sp, kWhite, FontWeight.w500),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}