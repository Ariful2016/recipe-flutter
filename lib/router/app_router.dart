import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/screens/home/home_screen.dart';
import 'package:recipe_flutter/screens/onboarding/onboarding_screen.dart';
import '../screens/card_swipe/tinder_swipe_screen.dart';


class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'onboarding',
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: '/tinderSwipe',
        name: 'tinderSwipe',
        builder: (context, state) => TinderSwipeScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => HomeScreen(),
      ),
      // Add more routes here...
    ],
  );
}
