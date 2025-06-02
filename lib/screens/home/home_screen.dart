import 'package:flutter/material.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/screens/favorite/favorite_screen.dart';
import 'package:recipe_flutter/screens/food/food_screen.dart';
import 'package:recipe_flutter/screens/joke/joke_screen.dart';
import 'package:recipe_flutter/util/bottom_navigation.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';

import '../../widgets/screen_transition_wrapper.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScreenTransitionWrapperState> _animationKey = GlobalKey();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  int _currentIndex = 0;

  static const List<Widget> _screens =[
    FoodScreen(),
    FavoriteScreen(),
    FoodJokeScreen()
  ];

  void _onItemTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _animationKey.currentState?.triggerExitAnimation(() {
          Navigator.of(context).pop();
        });
        return false;
      },
      child: ScreenTransitionWrapper(
        key: _animationKey,
        child: Scaffold(
          backgroundColor: kOffWhite,
          appBar: AppBar(
            title: ReusableText(text: 'Foody', style: appStyle(12, kPrimary, FontWeight.w600)),
            backgroundColor: kWhite,
          ),
          body: Navigator(
            key: _navigatorKey,
            onGenerateRoute: (settings){
              return MaterialPageRoute(
                  builder: (_) => _screens[_currentIndex]
              );
            },
          ),
          bottomNavigationBar: BottomNavigation(
              currentIndex: _currentIndex,
              onTab: _onItemTapped,
              animationKey: _animationKey,
          )
          // your content
        ),
      ),
    );
  }
}
