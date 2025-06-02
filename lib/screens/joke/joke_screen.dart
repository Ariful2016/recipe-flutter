import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';

class FoodJokeScreen extends StatefulWidget {
  const FoodJokeScreen({super.key});

  @override
  State<FoodJokeScreen> createState() => _FoodJokeScreenState();
}

class _FoodJokeScreenState extends State<FoodJokeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kOffWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReusableText(
            text: 'Hello, I do not tell you joke',
            style: appStyle(12.sp, kPrimary, FontWeight.w600),
          )
        ],
      ),
    );
  }
}
