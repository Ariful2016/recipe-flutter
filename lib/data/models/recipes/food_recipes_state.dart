import 'package:recipe_flutter/data/models/recipes/food_joke.dart';
import 'package:recipe_flutter/data/models/recipes/recipe_model.dart';

class FoodRecipesState {
  final bool isLoading;
  final Welcome? recipes;
  final FoodJoke? foodJoke;
  final String? error;

  FoodRecipesState({
    this.isLoading = false,
    this.recipes,
    this.foodJoke,
    this.error
  });

  FoodRecipesState copyWith({
    bool? isLoading,
    Welcome? recipes,
    FoodJoke? foodJoke,
    String? error
  }) {
    return FoodRecipesState(
        isLoading: isLoading ?? this.isLoading,
        recipes: recipes ?? this.recipes,
        foodJoke: foodJoke ?? this.foodJoke,
        error: error ?? this.error
    );
  }
}
