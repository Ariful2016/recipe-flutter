import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/screens/cart/cart_screen.dart';
import 'package:recipe_flutter/screens/favorite/favorite_screen.dart';
import 'package:recipe_flutter/screens/food/food_screen.dart';
import 'package:recipe_flutter/screens/history/order_history.dart';
import 'package:recipe_flutter/screens/home/home_screen.dart';
import 'package:recipe_flutter/screens/joke/joke_screen.dart';
import 'package:recipe_flutter/screens/logout/logout_screen.dart';
import 'package:recipe_flutter/screens/onboarding/onboarding_screen.dart';
import 'package:recipe_flutter/screens/order/order_screen.dart';
import 'package:recipe_flutter/screens/profile/profile_screen.dart';
import '../screens/card_swipe/tinder_swipe_screen.dart';
import '../screens/splash/splash_screen.dart';


class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
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
      GoRoute(
        path: '/food',
        name: 'food',
        builder: (context, state) => FoodScreen(),
      ),
      GoRoute(
        path: '/favorite',
        name: 'favorite',
        builder: (context, state) => FavoriteScreen(),
      ),
      GoRoute(
        path: '/joke',
        name: 'joke',
        builder: (context, state) => FoodJokeScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        path: '/order',
        name: 'order',
        builder: (context, state) => OrderScreen(),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => CartScreen(),
      ),
      GoRoute(
        path: '/history',
        name: 'history',
        builder: (context, state) => OrderHistory(),
      ),
      GoRoute(
        path: '/logout',
        name: 'logout',
        builder: (context, state) => LogoutScreen(),
      ),
      // Add more routes here...
    ],
  );
}
