import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_flutter/data/models/recipes/food_recipes_state.dart';
import 'package:recipe_flutter/data/repositories/recipe/food_recipes_repository.dart';

class FoodRecipesViewModel extends StateNotifier<FoodRecipesState>{
  final FoodRecipesRepository _repository;

  FoodRecipesViewModel(this._repository) : super(FoodRecipesState());

  Future<void> fetchRecipes(Map<String, String> query) async{
    state = state.copyWith(isLoading: true, error: null);
    try{
      final recipes = await _repository.getRecipes(query);
      state = state.copyWith(isLoading: false, recipes: recipes);
    }catch(e){
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> fetchSearchRecipes(Map<String, String> searchQuery) async{
    state = state.copyWith(isLoading: true, error: null);
    try{
      final recipes = await _repository.getSearchRecipes(searchQuery);
      state = state.copyWith(isLoading: false, recipes: recipes);
    }catch(e){
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> getFoodJoke() async{
    state = state.copyWith(isLoading: true, error: null);
    try{
      final joke = await _repository.getFoodJoke();
      state = state.copyWith(isLoading: false, foodJoke: joke);
    }catch(e){
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}