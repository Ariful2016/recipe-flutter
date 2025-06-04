import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_style.dart';
import '../../core/constants/constants.dart';
import '../../viewmodels/auth/register_viewmodel.dart';
import '../../widgets/reusable_text.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late final ProviderSubscription<AsyncValue<User?>> _authSubscription;

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    // Wait at least 2 seconds for splash screen display
    await Future.delayed(const Duration(seconds: 2));

    final completer = Completer<void>();
    Timer? timeoutTimer;

    try {
      _authSubscription = ref.listenManual<AsyncValue<User?>>(
        authStateProvider, (previous, next) async {
          if (!next.isLoading) {
            final user = next.value;
            try {
              final prefs = await SharedPreferences.getInstance();
              final isFirstLaunch = prefs.getBool('hasLaunched') ?? true;
              FlutterNativeSplash.remove();

              if (!mounted) return;

              if (isFirstLaunch) {
                await prefs.setBool('hasLaunched', false);
                context.pushReplacementNamed('onboarding');
              } else if (user != null) {
                context.pushReplacementNamed('home');
              } else {
                context.pushReplacementNamed('login');
              }

              if (!completer.isCompleted) completer.complete();
              timeoutTimer?.cancel();
              _authSubscription.close(); // ✅ Properly cancel the listener
            } catch (e) {
              FlutterNativeSplash.remove();
              if (mounted) {
                context.pushReplacementNamed('login');
              }
              if (!completer.isCompleted) completer.complete();
              _authSubscription.close();
            }
          }
        },
      );

      // Timeout fallback (e.g., network issue or delay)
      timeoutTimer = Timer(const Duration(seconds: 5), () {
        if (!completer.isCompleted) {
          FlutterNativeSplash.remove();
          if (mounted) context.pushReplacementNamed('login');
          completer.complete();
          _authSubscription.close();
        }
      });

      await completer.future;
    } catch (e) {
      FlutterNativeSplash.remove();
      if (mounted) context.pushReplacementNamed('login');
      completer.complete();
    } finally {
      timeoutTimer?.cancel();
    }
  }

  @override
  void dispose() {
    _authSubscription.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image-1.png',
              width: 150.w,
              height: 150.w,
            ),
            SizedBox(height: 20.h),
            ReusableText(
              text: "Foody",
              style: appStyle(12.sp, kLightWhite, FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
