import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';

import '../viewmodels/auth/login_viewmodel.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  void _navigate(BuildContext context, String route){
    Navigator.pop(context);
    context.go(route);
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: ReusableText(
          text: 'Logout',
          style: appStyle(18.sp, kDark, FontWeight.w600),
        ),
        content: ReusableText(
          text: 'Are you sure you want to logout?',
          style: appStyle(14.sp, kDark, FontWeight.w400),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: ReusableText(
              text: 'Cancel',
              style: appStyle(14.sp, kPrimary, FontWeight.w500),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: ReusableText(
              text: 'Logout',
              style: appStyle(14.sp, kPrimary, FontWeight.w500),
            ),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      try {
        final authRepository = ref.read(authRepositoryProvider);
        await authRepository.signOut();
        Navigator.pop(context); // Close the drawer
        context.go('/login'); // Navigate to login screen
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: ReusableText(
              text: 'Logout failed: $e',
              style: appStyle(14.sp, kWhite, FontWeight.w400),
            ),
            backgroundColor: kPrimary,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimary
            ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: kWhite,
                    child: Icon(Icons.person, size: 30.sp, color: kPrimary,),
                  ),
                  SizedBox(height: 10.h,),
                  ReusableText(text: 'Foody', style: appStyle(24.sp, kWhite, FontWeight.w500))
                ],
              )
          ),
          ListTile(
            leading: Icon(Icons.person, color: kPrimary, size: 24.sp,),
            title: ReusableText(text: 'Profile', style: appStyle(14.sp, kDark, FontWeight.w500)),
            onTap: () => _navigate(context, '/profile'),
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag, color: kPrimary, size: 24.sp),
            title: ReusableText(
              text: 'Order',
              style: appStyle(14.sp, kDark, FontWeight.w500),
            ),
            onTap: () => _navigate(context, '/order'),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart, color: kPrimary, size: 24.sp),
            title: ReusableText(
              text: 'Cart',
              style: appStyle(14.sp, kDark, FontWeight.w500),
            ),
            onTap: () => _navigate(context, '/cart'),
          ),
          ListTile(
            leading: Icon(Icons.history, color: kPrimary, size: 24.sp),
            title: ReusableText(
              text: 'Order History',
              style: appStyle(14.sp, kDark, FontWeight.w500),
            ),
            onTap: () => _navigate(context, '/history'),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: kPrimary, size: 24.sp),
            title: ReusableText(
              text: 'Logout',
              style: appStyle(14.sp, kDark, FontWeight.w500),
            ),
            onTap: () =>_logout(context, ref)
          ),
        ],
      ),
    );
  }
}
