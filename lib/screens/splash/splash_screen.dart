import 'package:flutter/material.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/image-1.png', width: 150, height: 150,),
            const SizedBox(height: 20,),
            ReusableText(text: "Foody", style: appStyle(12, kLightWhite, FontWeight.w600),)
          ],
        ),
      ),
    );
  }


}
