import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_flutter/data/models/users/register_state.dart';
import '../../data/repositories/auth/auth_repository.dart';



class LoginViewModel extends StateNotifier<RegisterState> {
  final AuthRepository _repository;

  LoginViewModel(this._repository) : super(RegisterState());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.loginUser(email, password);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}


