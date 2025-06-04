import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_flutter/data/models/users/app_user.dart';
import 'package:recipe_flutter/data/models/users/register_state.dart';
import 'package:recipe_flutter/data/repositories/auth/auth_repository.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository());

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChange;
});

final userDataProvider =
    FutureProvider.family<AppUser?, String>((ref, uid) async {
  final repository = ref.watch(authRepositoryProvider);
  return await repository.getUserData(uid);
});

class RegisterViewModel extends StateNotifier<RegisterState> {
  final AuthRepository _repository;

  RegisterViewModel(this._repository) : super(RegisterState());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String contactNo,
    required String address,
    String? photoUrl,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = AppUser(
        uid: '',
        name: name,
        email: email,
        contactNo: contactNo,
        address: address,
        photoUrl: photoUrl,
      );
      await _repository.registerUser(name: name,
        email: email,
        password: password,
        contactNo: contactNo,
        address: address,
        photoUrl: photoUrl,
      );
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final registerProvider =
    StateNotifierProvider<RegisterViewModel, RegisterState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterViewModel(repository);
});
