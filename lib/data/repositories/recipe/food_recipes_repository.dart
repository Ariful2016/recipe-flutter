import 'package:recipe_flutter/data/datasources/remote/food_recipe_api_service.dart';
import 'package:recipe_flutter/data/models/recipes/food_joke.dart';
import 'package:recipe_flutter/data/models/recipes/recipe_model.dart';

class FoodRecipesRepository{
  final FoodRecipeApiService _apiService;
  FoodRecipesRepository(this._apiService);

  Future<Welcome> getRecipes(Map<String, String> queries) async{
    try{
      return await _apiService.getRecipes(queries);
    }catch(e){
      throw Exception('Repository error: $e');
    }
  }

  Future<Welcome> getSearchRecipes(Map<String, String> searchQuery) async{
    try{
      return await _apiService.getSearchRecipes(searchQuery);
    }catch(e){
      throw Exception('Repository error: $e');
    }
  }

  Future<FoodJoke> getFoodJoke() async{
    try{
      return await _apiService.getFoodJoke();
    }catch(e){
      throw Exception('Repository error: $e');
    }
  }
}