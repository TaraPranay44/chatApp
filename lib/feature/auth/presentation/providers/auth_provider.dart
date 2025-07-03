// features/auth/presentation/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../../../shared/providers/providers.dart';

part 'auth_provider.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(UserEntity user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message, StackTrace stackTrace) = _Error;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref; // 👈 Add this
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthNotifier(this._ref, this._loginUseCase, this._logoutUseCase)
      : super(const AuthState.unauthenticated());

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();

    final result =
        await _loginUseCase(LoginParams(email: email, password: password));

    result.fold(
      (failure) => state = AuthState.error(failure.message, StackTrace.current),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> logout() async {
    state = const AuthState.loading();

    final result = await _logoutUseCase();

    result.fold(
      (failure) => state = AuthState.error(failure.message, StackTrace.current),
      (_) => state = const AuthState.unauthenticated(),
    );
  }

  Future<void> checkAuthStatus() async {
    state = const AuthState.loading();

    final authRepository = _ref.read(authRepositoryProvider);
    final result = await authRepository.getCurrentUser();

    result.fold(
      (failure) => state = const AuthState.unauthenticated(),
      (user) => user != null
          ? state = AuthState.authenticated(user)
          : state = const AuthState.unauthenticated(),
    );
  }
}

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref,
    ref.read(loginUseCaseProvider),
    ref.read(logoutUseCaseProvider),
  );
});
