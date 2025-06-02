import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _navigate(BuildContext context, String route){
    Navigator.pop(context);
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
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
            onTap: () => _navigate(context, '/logout')
          ),
        ],
      ),
    );
  }
}
