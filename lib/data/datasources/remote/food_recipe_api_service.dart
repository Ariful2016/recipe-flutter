import 'package:dio/dio.dart';
import 'package:recipe_flutter/data/models/recipes/food_joke.dart';
import 'package:recipe_flutter/data/models/recipes/recipe_model.dart';

import '../../../core/constants/constants.dart';

class FoodRecipeApiService {
  final Dio _dio;

  FoodRecipeApiService({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler){
        options.queryParameters['apiKey'] = apiKey;
        return handler.next(options);
      }
    ));
  }
  
  Future<Welcome> getRecipes (Map<String, String> queries) async{
    try{
      final response = await _dio.get(
          '/recipes/complexSearch',
          queryParameters: queries
      );
      return Welcome.fromJson(response.data);
    }catch(e){
      throw Exception('Failed to fetch recipes: $e');
    }
  }

  Future<Welcome> getSearchRecipes(Map<String,String> searchQuery) async{
    try{
      final response = await _dio.get(
        '/recipes/complexSearch',
        queryParameters: searchQuery
      );
      return Welcome.fromJson(response.data);
    }catch(e){
      throw Exception('Failed to search: $e');
    }
  }

  Future<FoodJoke> getFoodJoke() async{
    try{
      final response = await _dio.get(
          '/recipes/complexSearch'
      );
      return FoodJoke.fromJson(response.data);
    }catch(e){
      throw Exception('Failed to fetch food joke: $e');
    }
  }
}
