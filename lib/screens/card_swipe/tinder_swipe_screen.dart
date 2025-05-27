import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_flutter/core/app_style.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/widgets/button/custom_button.dart';
import 'package:recipe_flutter/widgets/reusable_text.dart';

import '../../data/models/swipe_card/swipe_card_model.dart';
import '../../widgets/screen_transition_wrapper.dart';
import '../../widgets/swipe_card/profile_card.dart';

class TinderSwipeScreen extends StatefulWidget {
  TinderSwipeScreen({super.key});

  @override
  _TinderSwipeScreenState createState() => _TinderSwipeScreenState();
}

class _TinderSwipeScreenState extends State<TinderSwipeScreen> {
  final CardSwiperController controller = CardSwiperController();
  final GlobalKey<ScreenTransitionWrapperState> _animationKey = GlobalKey();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTransitionWrapper(
          key: _animationKey,
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 500.h,
                      width: 350.w,
                      child: CardSwiper(
                        controller: controller,
                        cardsCount: profiles.length,
                        cardBuilder: (context, index, x, y) => ProfileCard(
                          profile: profiles[index],
                          swipeProgress: x.toDouble(),
                        ),
                        onSwipe: (previousIndex, currentIndex, direction) {
                          final profile = profiles[previousIndex];
                          print('${profile['name']} swiped: $direction');
                          if (direction == CardSwiperDirection.left) {
                            print('Disliked ${profile['name']}');
                          } else if (direction == CardSwiperDirection.right) {
                            print('Liked ${profile['name']}');
                          } else if (direction == CardSwiperDirection.top) {
                            print('Super Liked ${profile['name']}');
                          } else if (direction == CardSwiperDirection.bottom) {
                            print('Passed ${profile['name']}');
                          }
                          return true; // Allow swipe
                        },
                        allowedSwipeDirection: AllowedSwipeDirection.symmetric(
                          horizontal: true,
                          vertical: true,
                        ),
                        numberOfCardsDisplayed: 3,
                        scale: 0.9,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          heroTag: 'dislike',
                          onPressed: () =>
                              controller.swipe(CardSwiperDirection.left),
                          backgroundColor: Colors.white,
                          elevation: 4,
                          child: const Icon(Icons.close,
                              color: Colors.red, size: 30),
                        ),
                        const SizedBox(width: 30),
                        FloatingActionButton(
                          heroTag: 'superlike',
                          onPressed: () =>
                              controller.swipe(CardSwiperDirection.top),
                          backgroundColor: Colors.white,
                          elevation: 4,
                          child: const Icon(Icons.star,
                              color: Colors.blue, size: 30),
                        ),
                        const SizedBox(width: 30),
                        FloatingActionButton(
                          heroTag: 'like',
                          onPressed: () =>
                              controller.swipe(CardSwiperDirection.right),
                          backgroundColor: Colors.white,
                          elevation: 4,
                          child: const Icon(Icons.favorite,
                              color: Colors.green, size: 30),
                        ),
                      ],
                    ),
                    // Inside Stack's children
                  ],
                ),
                Positioned(
                  bottom: 20.h,
                  right: 20.w,
                  child: GestureDetector(
                    onTap: () {
                      _animationKey.currentState?.triggerExitAnimation(() {
                        context.push('/home');
                      });
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
