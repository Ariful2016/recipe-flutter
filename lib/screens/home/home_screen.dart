import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/screens/favorite/favorite_screen.dart';
import 'package:recipe_flutter/screens/food/food_screen.dart';
import 'package:recipe_flutter/screens/joke/joke_screen.dart';
import 'package:recipe_flutter/util/bottom_navigation.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';

import '../../util/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Toggle this for testing Crashlytics in your app locally.
  static const _kTestingCrashlytics = true;
  late Future<void> _initializeFlutterFireFuture;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    FoodScreen(),
    FavoriteScreen(),
    FoodJokeScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _initializeFlutterFire() async {
    try {
      if (_kTestingCrashlytics) {
        await FirebaseCrashlytics.instance
            .setCrashlyticsCollectionEnabled(true);
      } else {
        await FirebaseCrashlytics.instance
            .setCrashlyticsCollectionEnabled(!kDebugMode);
      }
    } catch (e, stack) {
      FirebaseCrashlytics.instance
          .recordError(e, stack, reason: 'Crashlytics initialization failed');
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeFlutterFireFuture = _initializeFlutterFire();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeFlutterFireFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            FirebaseCrashlytics.instance.recordError(
                snapshot.error, snapshot.stackTrace,
                reason: 'FlutterFire initialization error');
            return const Scaffold(
              body: Center(child: Text('Error initializing app')),
            );
          }
          return Scaffold(
              backgroundColor: kOffWhite,
              appBar: AppBar(
                title: ReusableText(
                    text: 'Foody',
                    style: appStyle(14.sp, kPrimary, FontWeight.w600)),
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.menu, color: kPrimary, size: 24.sp),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Image.asset('assets/image-1.png',
                        width: 40.w, height: 40.w),
                  ),
                ],
                backgroundColor: kWhite,
              ),
              drawer: AppDrawer(),
              drawerEnableOpenDragGesture: true,
              body: Navigator(
                key: _navigatorKey,
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                      builder: (_) => _screens[_currentIndex]);
                },
              ),
              bottomNavigationBar: BottomNavigation(
                currentIndex: _currentIndex,
                onTap: _onItemTapped,
              )
              // your content
              );
        });
  }
}
