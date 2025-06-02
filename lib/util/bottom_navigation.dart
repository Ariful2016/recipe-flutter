import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/widgets/screen_transition_wrapper.dart';

class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final GlobalKey<ScreenTransitionWrapperState>? animationKey;

  const BottomNavigation(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      this.animationKey});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  static const List<String> _routes = ['/food', '/favorite', '/joke'];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu), label: 'Recipe'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions), label: 'Joke')
      ],
      currentIndex: widget.currentIndex,
      selectedItemColor: kPrimary,
      unselectedItemColor: Colors.grey,
      backgroundColor: kOffWhite,
      selectedLabelStyle: appStyle(12.sp, kPrimary, FontWeight.w500),
      unselectedLabelStyle: appStyle(12.sp, Colors.grey, FontWeight.w500),
      onTap: (index) {
        if (widget.animationKey?.currentState != null) {
          widget.animationKey?.currentState!.triggerExitAnimation(() {
            widget.onTap(index);
          });
        } else {
          widget.onTap(index);
        }
      },
      type: BottomNavigationBarType.fixed,
    );
  }
}
