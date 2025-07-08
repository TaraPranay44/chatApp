// import 'package:chatapp/core/utils/app_utils/app_utils.dart';
// import 'package:chatapp/feature/auth/domain/usecases/send_otp_usecase.dart';
// import 'package:chatapp/feature/auth/presentation/providers/auth_provider.dart';
// import 'package:chatapp/feature/auth/presentation/providers/login_ui_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class LoginScreen extends ConsumerStatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends ConsumerState<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _inputController = TextEditingController();
//   final _otpController = TextEditingController();

//   @override
//   void dispose() {
//     _inputController.dispose();
//     _otpController.dispose();
//     super.dispose();
//   }

//   void _toggleInputMethod() {
//     ref.read(loginUiProvider.notifier).toggleInputMethod();
//     _inputController.clear();
//   }

//   void _handleNext() async {
//     if (!_formKey.currentState!.validate()) return;

//     FocusScope.of(context).unfocus();
//     final loginUi = ref.read(loginUiProvider);
//     String email = "";
//     String phone = "";

//     loginUi.isEmail
//         ? email = _inputController.text
//         : phone = _inputController.text;

//     if (!loginUi.showOtpField) {
//       // Step 1: Send OTP
//       final success = await ref
//           .read(authProvider.notifier)
//           .sendOtp(email: email, phone: phone);

//       if (!mounted) return;

//       if (success) {
//         ref.read(loginUiProvider.notifier).showOtpField();

//         AppUtils.showSnackBar(
//           context,
//           message: 'OTP sent to ${loginUi.isEmail ? 'email' : 'mobile number'}',
//           backgroundColor: Colors.green,
//         );
//       } else {
//         final errorMessage = ref.read(authProvider).errorMessage;
//         AppUtils.showSnackBar(
//           context,
//           message: errorMessage ?? 'Failed to send OTP. Please try again.',
//           backgroundColor: Theme.of(context).colorScheme.error,
//         );
//       }
//     } else {
//       // Step 2: Verify OTP
//       final otp = _otpController.text.trim();
//       await _verifyOtpAndLogin(email, phone, otp);
//     }
//   }

//   Future<void> _verifyOtpAndLogin(
//       String email, String phone, String otp) async {
//     final success = await ref.read(authProvider.notifier).verifyOtp(
//           email: email,
//           phone: phone,
//           enteredOtp: otp,
//         );

//     if (!mounted) return;

//     if (success) {
//       AppUtils.showSnackBar(
//         context,
//         message: 'Login successful!',
//         backgroundColor: Colors.green,
//       );
//       // Router will automatically redirect to home due to isAuthenticated = true
//     } else {
//       final errorMessage = ref.read(authProvider).errorMessage;
//       AppUtils.showSnackBar(
//         context,
//         message: errorMessage ?? 'Invalid OTP. Please try again.',
//         backgroundColor: Theme.of(context).colorScheme.error,
//       );
//     }
//   }

//   String? _validateOtp(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter the OTP';
//     }
//     if (value.length != 6) {
//       return 'OTP must be 6 digits';
//     }
//     return null;
//   }

//   String? _validateInput(String? value, bool isEmail) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your ${isEmail ? 'email' : 'mobile number'}';
//     }

//     if (isEmail) {
//       if (!AppUtils.isValidEmail(value)) {
//         return 'Please enter a valid email';
//       }
//     } else {
//       if (!RegExp(r'^[+]?[\d\s-()]{10,}$').hasMatch(value)) {
//         return 'Please enter a valid mobile number';
//       }
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final uiState = ref.watch(loginUiProvider);
//     final authState = ref.watch(authProvider);

//     return Scaffold(
//       backgroundColor: const Color(0xFF0A1410),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Help icon top-right
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         icon:
//                             const Icon(Icons.help_outline, color: Colors.white),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 40),

//                   // Title
//                   const Text(
//                     'Enter your phone or email',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   ),

//                   const SizedBox(height: 32),

//                   // Input Field
//                   TextFormField(
//                     controller: _inputController,
//                     keyboardType: uiState.isEmail
//                         ? TextInputType.emailAddress
//                         : TextInputType.phone,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: const Color(0xFF1B2B25),
//                       hintText: uiState.isEmail ? 'Email' : 'Mobile number',
//                       hintStyle: const TextStyle(color: Colors.white60),
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 18),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     validator: (value) =>
//                         _validateInput(value, uiState.isEmail),
//                   ),

//                   const SizedBox(height: 20),

//                   if (uiState.showOtpField) ...[
//                     // const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _otpController,
//                       keyboardType: TextInputType.number,
//                       maxLength: 6,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: const Color(0xFF1B2B25),
//                         hintText: 'Enter OTP',
//                         hintStyle: const TextStyle(color: Colors.white60),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 18),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: _validateOtp,
//                     ),
//                   ],
//                   const SizedBox(height: 20),

//                   // Buttons
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: _toggleInputMethod,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF1B2B25),
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                           ),
//                           child: Text(
//                               uiState.isEmail ? 'Use Mobile' : 'Use Email'),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: authState.isLoading ? null : _handleNext,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF1ED760),
//                             foregroundColor: Colors.black,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                           ),
//                           child: authState.isLoading
//                               ? const SizedBox(
//                                   height: 20,
//                                   width: 20,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     color: Colors.black,
//                                   ),
//                                 )
//                               : const Text('Next'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:chatapp/core/constants/app_constants.dart';
import 'package:chatapp/core/constants/color_constants.dart';
import 'package:chatapp/core/constants/spacing_constants.dart';
import 'package:chatapp/core/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatapp/core/utils/app_utils/app_utils.dart';
import 'package:chatapp/feature/auth/presentation/providers/auth_provider.dart';
import 'package:chatapp/feature/auth/presentation/providers/login_ui_provider.dart';

// Import the constant files

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _toggleInputMethod() {
    ref.read(loginUiProvider.notifier).toggleInputMethod();
    _inputController.clear();
    _otpController.clear();
  }

  Future<void> _handleNext() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    final loginUi = ref.read(loginUiProvider);
    final inputValue = _inputController.text.trim();

    if (!loginUi.showOtpField) {
      await _sendOtp(inputValue, loginUi.isEmail);
    } else {
      await _verifyOtp(inputValue, loginUi.isEmail);
    }
  }

  Future<void> _sendOtp(String inputValue, bool isEmail) async {
    final success = await ref.read(authProvider.notifier).sendOtp(
          email: isEmail ? inputValue : "",
          phone: isEmail ? "" : inputValue,
        );

    if (!mounted) return;

    if (success) {
      ref.read(loginUiProvider.notifier).showOtpField();
      _showSuccessMessage(
        isEmail ? AppConstants.otpSentToEmail : AppConstants.otpSentToPhone,
      );
    } else {
      _showErrorMessage(
        ref.read(authProvider).errorMessage ?? AppConstants.defaultSendOtpError,
      );
    }
  }

  Future<void> _verifyOtp(String inputValue, bool isEmail) async {
    final otp = _otpController.text.trim();
    final success = await ref.read(authProvider.notifier).verifyOtp(
          email: isEmail ? inputValue : "",
          phone: isEmail ? "" : inputValue,
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
                  _buildInputField(uiState),
                  const SizedBox(height: SpacingConstants.xl),
                  if (uiState.showOtpField) ...[
                    _buildOtpField(),
                    const SizedBox(height: SpacingConstants.xl),
                  ],
                  _buildActionButtons(uiState, authState),
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

  Widget _buildInputField(loginUiState) {
    return TextFormField(
      controller: _inputController,
      keyboardType: loginUiState.isEmail
          ? TextInputType.emailAddress
          : TextInputType.phone,
      style: StyleConstants.bodyLarge,
      decoration: StyleConstants.inputDecoration(
        hintText: loginUiState.isEmail
            ? AppConstants.emailHint
            : AppConstants.phoneHint,
      ),
      validator: (value) => AppUtils.validateInput(value, loginUiState.isEmail),
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

  Widget _buildActionButtons(loginUiState, authState) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: authState.isLoading ? null : _toggleInputMethod,
            style: StyleConstants.secondaryButtonStyle,
            child: Text(
              loginUiState.isEmail
                  ? AppConstants.useMobileButton
                  : AppConstants.useEmailButton,
            ),
          ),
        ),
        const SizedBox(width: SpacingConstants.md),
        Expanded(
          child: ElevatedButton(
            onPressed: authState.isLoading ? null : _handleNext,
            style: StyleConstants.primaryButtonStyle,
            child: authState.isLoading
                ? StyleConstants.loadingIndicator
                : const Text(AppConstants.nextButton),
          ),
        ),
      ],
    );
  }
}
