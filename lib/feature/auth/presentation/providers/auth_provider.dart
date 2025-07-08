import 'package:chatapp/feature/auth/data/models/request_models/send_otp_request.dart';
import 'package:chatapp/feature/auth/data/models/request_models/verify_otp_request.dart';
import 'package:chatapp/feature/auth/domain/entities/user_entity.dart';
import 'package:chatapp/feature/auth/domain/usecases/send_otp_usecase.dart';
import 'package:chatapp/feature/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final UserEntity? user;
  final String? errorMessage;
  final bool? sentOtp; // Store the OTP sent to user
  final bool? verifiedOtp;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.verifiedOtp = false,
    this.user,
    this.errorMessage,
    this.sentOtp,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    UserEntity? user,
    String? errorMessage,
    bool? sentOtp,
    bool? verifiedOtp,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage,
      sentOtp: sentOtp ?? this.sentOtp,
      verifiedOtp: verifiedOtp ?? this.verifiedOtp,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final SendOtpUseCase _sendOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;

  AuthNotifier(
      {
      required SendOtpUseCase sendOtpUseCase,
      required VerifyOtpUseCase verifyOtpUseCase})
      : 
        _sendOtpUseCase = sendOtpUseCase,
        _verifyOtpUseCase = verifyOtpUseCase,
        super(const AuthState());

  // Login
  // Future<void> login({required String email, required String password}) async {
  //   state = state.copyWith(isLoading: true, errorMessage: null);

  //   final result = await _loginUseCase.execute(
  //     email: email,
  //     password: password,
  //   );

  //   result.fold(
  //     (failure) => state = state.copyWith(
  //       isLoading: false,
  //       isAuthenticated: false,
  //       errorMessage: failure.message,
  //     ),
  //     (user) => state = state.copyWith(
  //       isLoading: false,
  //       isAuthenticated: true,
  //       user: user,
  //       errorMessage: null,
  //     ),
  //   );
  // }

  Future<bool> sendOtp({String email = "", String phone = ""}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    SendOtpRequest otpRequest = SendOtpRequest(email: email, phone: phone);
    final result = await _sendOtpUseCase.execute(request: otpRequest);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
        return false;
      },
      (otp) {
        state = state.copyWith(
          isLoading: false,
          sentOtp: otp, // Store the OTP for verification
          errorMessage: null,
        );
        return true;
      },
    );
  }

  Future<bool> verifyOtp({
    required String email,
    required String phone,
    required String enteredOtp,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    VerifyOtpRequest verifyOtpRequest =
        VerifyOtpRequest(email: email, phone: phone, code: enteredOtp);
    final result = await _verifyOtpUseCase.execute(request: verifyOtpRequest);
    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
        return false;
      },
      (otpVerified) {
        state = state.copyWith(
          isLoading: false,
          verifiedOtp: otpVerified, // Store the OTP for verification
          errorMessage: null,
          isAuthenticated: true,
        );
        return true;
      },
    );
  }

  Future<void> logout() {
    state = const AuthState();
    return Future.value();
  }
}

// Auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  
  final sendOtpUseCase = ref.watch(sendOtpUseCaseProvider);
  final verifyOtpUseCase = ref.watch(verifOtpUseCaseProvider);
  // final logoutUseCase = ref.watch(logoutUseCaseProvider);
  // final registerUseCase = ref.watch(registerUseCaseProvider);

  return AuthNotifier(
      
      sendOtpUseCase: sendOtpUseCase,
      verifyOtpUseCase: verifyOtpUseCase
      // logoutUseCase: logoutUseCase,
      // registerUseCase: registerUseCase,
      );
});
