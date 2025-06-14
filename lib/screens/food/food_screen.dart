import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_flutter/core/constants/constants.dart';
import 'package:recipe_flutter/di/recipes/food_recipes_providers.dart';
import '../../widgets/dialog/custom_alert_dialog.dart';
import '../../widgets/recipe/recipe_list.dart';
import '../../widgets/shimmer_recipe_list.dart';

class FoodScreen extends ConsumerStatefulWidget {
  const FoodScreen({super.key});

  @override
  ConsumerState<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends ConsumerState<FoodScreen> {
  @override
  void initState() {
    super.initState();
// Fetch recipes after widget tree is built
    Future.microtask(() {
      ref.read(foodRecipesViewmodelProvider.notifier).fetchRecipes({
        'number': '10',
        'type': 'main course',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(foodRecipesViewmodelProvider);
    ref.listen(foodRecipesViewmodelProvider, (previous, next) {
      if (next.error != null) {
        showCustomAlertDialog(
          context,
          type: AlertType.error,
          title: 'Error',
          message: next.error!,
          primaryButtonText: 'Retry',
          primaryButtonAction: () {
            Navigator.of(context).pop();
            ref.read(foodRecipesViewmodelProvider.notifier).fetchRecipes({
              'number': '10',
              'type': 'main course',
            });
          },
          secondaryButtonText: 'Cancel',
          secondaryButtonAction: () => Navigator.of(context).pop(),
        );
      }
    });

    return Scaffold(
      backgroundColor: kWhite,
      body: Padding(
        padding: EdgeInsets.only(left:12.w, right: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: state.isLoading
                  ? ShimmerRecipeList()
                  :recipeList(state)
            ),
          ],
        ),
      ),
    );
  }
}
