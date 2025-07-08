import 'package:chatapp/core/constants/app_constants.dart';
import 'package:chatapp/core/constants/color_constants.dart';
import 'package:chatapp/core/constants/spacing_constants.dart';
import 'package:chatapp/core/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatapp/core/utils/app_utils/app_utils.dart';
import 'package:chatapp/feature/auth/presentation/providers/auth_provider.dart';
import 'package:chatapp/feature/auth/presentation/providers/login_ui_provider.dart';

// Updated State class for login UI state
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
}

// Updated Provider for login UI state
final loginUiProvider =
    StateNotifierProvider<LoginUiNotifier, LoginUiState>((ref) {
  return LoginUiNotifier();
});

// Updated Login Screen
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uiState = ref.watch(loginUiProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(SpacingConstants.screenPadding),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeader(),
                  const SizedBox(height: SpacingConstants.huge),
                  _buildTitle(),
                  const SizedBox(height: SpacingConstants.sectionMargin),
                  _buildEmailField(),
                  const SizedBox(height: SpacingConstants.md),
                  _buildPhoneField(),
                  const SizedBox(height: SpacingConstants.xl),
                  if (uiState.showOtpField) ...[
                    _buildOtpField(),
                    const SizedBox(height: SpacingConstants.xl),
                  ],
                  _buildNextButton(uiState, authState),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(
            Icons.help_outline,
            color: ColorConstants.textPrimary,
            size: AppConstants.iconSize,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      AppConstants.loginTitle,
      textAlign: TextAlign.center,
      style: StyleConstants.titleMedium,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: StyleConstants.bodyLarge,
      decoration: StyleConstants.inputDecoration(
        hintText: AppConstants.emailHint,
      ),
      validator: (value) =>
          AppUtils.validateInput(value, true), // true for email validation
      onFieldSubmitted: (_) => _handleNext(),
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      style: StyleConstants.bodyLarge,
      decoration: StyleConstants.inputDecoration(
        hintText: AppConstants.phoneHint,
      ),
      validator: (value) =>
          AppUtils.validateInput(value, false), // false for phone validation
      onFieldSubmitted: (_) => _handleNext(),
    );
  }

  Widget _buildOtpField() {
    return TextFormField(
      controller: _otpController,
      keyboardType: TextInputType.number,
      maxLength: AppConstants.otpLength,
      style: StyleConstants.bodyLarge,
      decoration: StyleConstants.inputDecoration(
        hintText: AppConstants.otpHint,
      ),
      validator: AppUtils.validateOtp,
      onFieldSubmitted: (_) => _handleNext(),
    );
  }

  Widget _buildNextButton(LoginUiState uiState, authState) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: authState.isLoading ? () {} : _handleNext,
        style: StyleConstants.primaryButtonStyle,
        child: authState.isLoading
            ? StyleConstants.loadingIndicator
            : const Text(AppConstants.nextButton),
      ),
    );
  }

  Future<void> _handleNext() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    final loginUi = ref.read(loginUiProvider);
    final emailValue = _emailController.text.trim();
    final phoneValue = _phoneController.text.trim();

    if (!loginUi.showOtpField) {
      // First click: Send OTP to both email and phone
      await _sendOtp(emailValue, phoneValue);
    } else {
      // Second click: Verify OTP and login
      await _verifyOtp(emailValue, phoneValue);
    }
  }

  Future<void> _sendOtp(String email, String phone) async {
    final success = await ref.read(authProvider.notifier).sendOtp(
          email: email,
          phone: phone,
        );

    if (!mounted) return;

    if (success) {
      ref.read(loginUiProvider.notifier).showOtpField();
      _showSuccessMessage(AppConstants.otpSentToBoth);
    } else {
      _showErrorMessage(
        ref.read(authProvider).errorMessage ?? AppConstants.defaultSendOtpError,
      );
    }
  }

  Future<void> _verifyOtp(String email, String phone) async {
    final otp = _otpController.text.trim();
    final success = await ref.read(authProvider.notifier).verifyOtp(
          email: email,
          phone: phone,
          enteredOtp: otp,
        );

    if (!mounted) return;

    if (success) {
      _showSuccessMessage(AppConstants.loginSuccess);
      // Navigation will be handled by the router based on authentication state
    } else {
      _showErrorMessage(
        ref.read(authProvider).errorMessage ??
            AppConstants.defaultVerifyOtpError,
      );
    }
  }

  void _showSuccessMessage(String message) {
    AppUtils.showSnackBar(
      context,
      message: message,
      backgroundColor: ColorConstants.success,
    );
  }

  void _showErrorMessage(String message) {
    AppUtils.showSnackBar(
      context,
      message: message,
      backgroundColor: ColorConstants.error,
    );
  }
}
