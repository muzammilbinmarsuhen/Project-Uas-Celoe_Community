import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/auth_repository.dart';

class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // No initial state to load
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(authRepositoryProvider).login(email, password));
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(authRepositoryProvider).logout());
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(() {
  return AuthController();
});

final currentUserProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final authRepo = ref.watch(authRepositoryProvider);
  return await authRepo.getCurrentUser();
});
