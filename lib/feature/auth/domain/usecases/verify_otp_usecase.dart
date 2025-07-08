import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/feature/auth/data/models/verify_otp_request.dart';
import 'package:chatapp/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:chatapp/feature/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyOtpUseCase {
  final AuthRepository _repository;

  VerifyOtpUseCase(this._repository);

  Future<Either<Failure, bool>> execute({required VerifyOtpRequest request}) {
    // if (emailOrPhone.trim().isEmpty) {
    //   return Future.value(
    //     const Left(InputFailure(message: 'Email/Phone cannot be empty')),
    //   );
    // }
    return _repository.verifyOtp(request: request);
  }
}

// Provider
// Provider
final verifOtpUseCaseProvider = Provider<VerifyOtpUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return VerifyOtpUseCase(repository);
});
