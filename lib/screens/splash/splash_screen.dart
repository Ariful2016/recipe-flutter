import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/router/app_router.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> _navigate() async{
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('hasLaunched') ?? true;
    FlutterNativeSplash.remove();
    if(isFirstLaunch){
      await prefs.setBool("hasLaunched", false);
      if(mounted){
        context.pushReplacementNamed('onboarding');
      }
    }else{
      if(mounted){
        context.pushReplacementNamed('home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image-1.png', width: 150.w, height: 150.w,),
            SizedBox(height: 20.h,),
            ReusableText(text: "Foody", style: appStyle(12.sp, kLightWhite, FontWeight.w600),)
          ],
        ),
      ),
    );
  }


}
