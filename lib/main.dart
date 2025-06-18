import 'dart:ui';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_flutter/router/app_router.dart';
import 'package:recipe_flutter/services/notification_service.dart';
import 'di/notification/notification_provider.dart';
import 'firebase_options.dart';
import 'core/constants/constants.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  } catch (e, stack) {
    await FirebaseCrashlytics.instance
        .recordError(e, stack, reason: 'Firebase initialization failed');
  }

  const bool fatalError = kDebugMode;
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

  FlutterNativeSplash.remove();

  runApp(
    ProviderScope(
      overrides: [
        notificationServiceProvider.overrideWith(
          (ref) {
            final navigatorKey = ref.watch(navigatorKeyProvider);
            return NotificationService(navigatorKey: navigatorKey);
          },
        ),
      ],
      child: const MainApp(),
    ),
  );
}

// Global navigator key provider
final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  late final GlobalKey<NavigatorState> _navigatorKey;

  @override
  void initState() {
    super.initState();
    _navigatorKey = ref.read(navigatorKeyProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notificationService = ref.read(notificationServiceProvider);
      notificationService
          .initialize(context); // Use the context from the widget
    });
  }

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
          theme: ThemeData(
            primaryColor: kPrimary,
            scaffoldBackgroundColor: kOffWhite,
            textTheme: TextTheme(
              bodyMedium: TextStyle(fontSize: 14.sp, color: kDark),
            ),
          ),
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
