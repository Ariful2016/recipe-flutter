import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/screens/cart/cart_screen.dart';
import 'package:recipe_flutter/screens/favorite/favorite_screen.dart';
import 'package:recipe_flutter/screens/food/food_screen.dart';
import 'package:recipe_flutter/screens/history/order_history.dart';
import 'package:recipe_flutter/screens/home/home_screen.dart';
import 'package:recipe_flutter/screens/joke/joke_screen.dart';
import 'package:recipe_flutter/screens/login/login_screen.dart';
import 'package:recipe_flutter/screens/onboarding/onboarding_screen.dart';
import 'package:recipe_flutter/screens/order/order_screen.dart';
import 'package:recipe_flutter/screens/profile/profile_screen.dart';
import 'package:recipe_flutter/screens/register/register_screen.dart';
import 'package:recipe_flutter/screens/splash/splash_screen.dart';
import '../screens/card_swipe/tinder_swipe_screen.dart';
import '../viewmodels/auth/register_viewmodel.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => RegisterScreen(),
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
        builder: (context, state) => const FoodScreen(),
      ),
      GoRoute(
        path: '/favorite',
        name: 'favorite',
        builder: (context, state) => const FavoriteScreen(),
      ),
      GoRoute(
        path: '/joke',
        name: 'joke',
        builder: (context, state) => const FoodJokeScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/order',
        name: 'order',
        builder: (context, state) => const OrderScreen(),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/history',
        name: 'history',
        builder: (context, state) => const OrderHistory(),
      ),
    ],
  );

}