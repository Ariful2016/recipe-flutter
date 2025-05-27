import 'package:flutter/material.dart';
import 'package:recipe_flutter/core/constants/constants.dart';

import '../../widgets/screen_transition_wrapper.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScreenTransitionWrapperState> _animationKey = GlobalKey();
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
          backgroundColor: kPrimary,
          // your content
        ),
      ),
    );
  }
}
