import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_style.dart';
import '../../core/constants/constants.dart';
import '../../data/models/recipes/food_recipes_state.dart';
import '../reusable_text.dart';

Widget recipeList(FoodRecipesState state) {
  if (state.recipes == null || state.recipes!.results == null) {
    return Center(
      child: ReusableText(
        text: 'No recipes available.',
        style: appStyle(14.sp, kDark, FontWeight.w400),
      ),
    );
  }

  if (state.recipes!.results!.isEmpty) {
    return Center(
      child: ReusableText(
        text: 'No recipes found.',
        style: appStyle(14.sp, kDark, FontWeight.w400),
      ),
    );
  }

  return ListView.builder(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
    itemCount: state.recipes!.results!.length,
    itemBuilder: (context, index) {
      final recipe = state.recipes!.results![index];
      print('Recipe: $recipe');
      return GestureDetector(
        onTap: () {
          // Future: Navigate to recipe details
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
                color: Colors.black.withValues(alpha: 0.1), width: 0.5.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 5.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                ),
                child: recipe.image != null
                    ? Image.network(
                        recipe.image!,
                        width: 120.w,
                        height: 120.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 120.w,
                          height: 120.h,
                          color: kLightWhite,
                          child: Icon(
                            Icons.broken_image,
                            size: 50.sp,
                            color: kDark.withValues(alpha: 0.5),
                          ),
                        ),
                      )
                    : Container(
                        width: 120.w,
                        height: 120.h,
                        color: kLightWhite,
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50.sp,
                          color: kDark.withValues(alpha: 0.5),
                        ),
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: recipe.title ?? 'Unknown',
                        style: appStyle(16.sp, kPrimary, FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      ReusableText(
                        text: recipe.summary ?? 'Unknown',
                        style: appStyle(16.sp, kDark, FontWeight.w400),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      ReusableText(
                        text:
                            'Ready in ${recipe.readyInMinutes ?? 0} min • ${recipe.servings ?? 0} servings',
                        style: appStyle(
                          12.sp,
                          kDark.withValues(alpha: 0.7),
                          FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16.sp,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 4.w),
                          ReusableText(
                            text: recipe.spoonacularScore?.toStringAsFixed(1) ??
                                'N/A',
                            style: appStyle(12.sp, kDark, FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
