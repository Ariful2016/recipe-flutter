import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/screens/cart/cart_screen.dart';
import 'package:recipe_flutter/screens/favorite/favorite_screen.dart';
import 'package:recipe_flutter/screens/food/food_screen.dart';
import 'package:recipe_flutter/screens/history/order_history.dart';
import 'package:recipe_flutter/screens/home/home_screen.dart';
import 'package:recipe_flutter/screens/joke/joke_screen.dart';
import 'package:recipe_flutter/screens/login/login_screen.dart';
import 'package:recipe_flutter/screens/logout/logout_screen.dart';
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
      GoRoute(
        path: '/logout',
        name: 'logout',
        builder: (context, state) => const LogoutScreen(),
      ),
    ],
  );

  /*static Future<String?> _authRedirect(BuildContext context, GoRouterState state) async {
    final container = ProviderContainer();
    try {
      final authState = container.read(authStateProvider);
      if (authState.isLoading) {
        await Future.delayed(const Duration(milliseconds: 500)); // Wait briefly for auth state
        final updatedUser = container.read(authStateProvider).value;
        if (updatedUser == null) {
          return '/login';
        }
      } else if (authState.value == null) {
        return '/login';
      }
      return null;
    } catch (e) {
      return '/login';
    } finally {
      container.dispose();
    }
  }*/
  static String? _authRedirect(BuildContext context, GoRouterState state) {
    final user = FirebaseAuth.instance.currentUser;
    final isLoggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';

    if (user == null && !isLoggingIn) return '/login';
    if (user != null && isLoggingIn) return '/home';
    return null;
  }

}