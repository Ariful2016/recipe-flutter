import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRecipeList extends StatelessWidget {
  const ShimmerRecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8, // Shimmer placeholders
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            child: ListTile(
              leading: Container(
                width: 120.w,
                height: 120.w,
                color: Colors.white,
              ),
              title: Container(
                width: double.infinity,
                height: 16.h,
                color: Colors.white,
              ),
              subtitle: Container(
                width: double.infinity,
                height: 12.h,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
