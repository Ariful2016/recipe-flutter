import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/screens/favorite/favorite_screen.dart';
import 'package:recipe_flutter/screens/food/food_screen.dart';
import 'package:recipe_flutter/screens/joke/joke_screen.dart';
import 'package:recipe_flutter/util/bottom_navigation.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
        backgroundColor: kOffWhite,
        appBar: AppBar(
          title: ReusableText(text: 'Foody', style: appStyle(14.sp, kPrimary, FontWeight.w600)),
          leading: Image.asset('assets/image-1.png', width: 50.w, height: 50.w,),
          backgroundColor: kWhite,
        ),
        drawer: ,
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
          onTap: _onItemTapped,
        )
      // your content
    );
  }
}
