import 'package:flutter/material.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:go_router/go_router.dart';
import '../../data/datasources/onboarding/onboarding_data_source.dart';
import '../../widgets/onboarding/onboarding_item.dart';
import '../../widgets/screen_transition_wrapper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final GlobalKey<ScreenTransitionWrapperState> _animationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTransitionWrapper(
        key: _animationKey,
        child: ConcentricPageView(
          radius: 40,
          colors: data.map((e) => e.backgroundColor).toList(),
          itemCount: data.length,
          onFinish: () {
            _animationKey.currentState?.triggerExitAnimation(() {
              context.goNamed('tinderSwipe');
            });
          },
          itemBuilder: (int index) {
            return ItemWidget(data: data[index]);
          },
        ),
      ),
    );
  }
}
