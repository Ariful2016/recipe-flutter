import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/users/app_user.dart';
import '../../data/models/users/register_state.dart';
import '../../data/repositories/auth/auth_repository.dart';
import '../../viewmodels/auth/login_viewmodel.dart';
import '../../viewmodels/auth/register_viewmodel.dart';

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

final registerProvider =
    StateNotifierProvider<RegisterViewModel, RegisterState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterViewModel(repository);
});

final loginProvider =
    StateNotifierProvider<LoginViewModel, RegisterState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginViewModel(repository);
});
