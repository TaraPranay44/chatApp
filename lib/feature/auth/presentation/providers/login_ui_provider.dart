// State class for login UI state
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginUiState {
  final bool showOtpField;
  final bool isOtpSent;

  const LoginUiState({
    this.showOtpField = false,
    this.isOtpSent = false,
  });

  LoginUiState copyWith({
    bool? showOtpField,
    bool? isOtpSent,
  }) {
    return LoginUiState(
      showOtpField: showOtpField ?? this.showOtpField,
      isOtpSent: isOtpSent ?? this.isOtpSent,
    );
  }
}

// Updated Notifier for login UI state
class LoginUiNotifier extends StateNotifier<LoginUiState> {
  LoginUiNotifier() : super(const LoginUiState());

  void showOtpField() {
    state = state.copyWith(
      showOtpField: true,
      isOtpSent: true,
    );
  }

  void reset() {
    state = const LoginUiState();
  }

  void hideOtpField() {
    state = state.copyWith(showOtpField: false, isOtpSent: false);
  }
}

// Updated Provider for login UI state
final loginUiProvider =
    StateNotifierProvider<LoginUiNotifier, LoginUiState>((ref) {
  return LoginUiNotifier();
});
