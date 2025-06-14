import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_flutter/data/datasources/remote/food_recipe_api_service.dart';
import 'package:recipe_flutter/data/repositories/recipe/food_recipes_repository.dart';
import 'package:recipe_flutter/viewmodels/recipes/food_recipes_viewmodel.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final apiServiceProvider = Provider<FoodRecipeApiService>(
    (ref) => FoodRecipeApiService(dio: ref.watch(dioProvider)));

final repositoryProvider = Provider<FoodRecipesRepository>(
    (ref) => FoodRecipesRepository(ref.watch(apiServiceProvider)));

final viewmodelProvider = Provider<FoodRecipesViewModel>(
    (ref) => FoodRecipesViewModel(ref.watch(repositoryProvider)));
