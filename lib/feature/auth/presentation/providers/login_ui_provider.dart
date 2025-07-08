// State class for login UI state
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginUiState {
  final bool isEmail;
  final bool showOtpField;
  final bool isOtpSent;

  const LoginUiState({
    this.isEmail = false,
    this.showOtpField = false,
    this.isOtpSent = false,
  });

  LoginUiState copyWith({
    bool? isEmail,
    bool? showOtpField,
    bool? isOtpSent,
  }) {
    return LoginUiState(
      isEmail: isEmail ?? this.isEmail,
      showOtpField: showOtpField ?? this.showOtpField,
      isOtpSent: isOtpSent ?? this.isOtpSent,
    );
  }
}

// Notifier for login UI state
class LoginUiNotifier extends StateNotifier<LoginUiState> {
  LoginUiNotifier() : super(const LoginUiState());

  void toggleInputMethod() {
    state = state.copyWith(
      isEmail: !state.isEmail,
      showOtpField: false,
      isOtpSent: false,
    );
  }

  void showOtpField() {
    state = state.copyWith(
      showOtpField: true,
      isOtpSent: true,
    );
  }

  void reset() {
    state = const LoginUiState();
  }
}

// Provider for login UI state
final loginUiProvider = StateNotifierProvider<LoginUiNotifier, LoginUiState>((ref) {
  return LoginUiNotifier();
});
