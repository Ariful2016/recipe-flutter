import 'dart:ui';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_flutter/router/app_router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Initialize Analytics
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  } catch (e, stack) {
    FirebaseCrashlytics.instance
        .recordError(e, stack, reason: 'Firebase initialization failed');
    // Optionally show an error screen or fallback
  }

  // Configure Crashlytics
  const bool fatalError = kDebugMode; // Fatal errors only in debug mode
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    } else {
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    } else {
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(384, 805.33),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Recipe',
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
