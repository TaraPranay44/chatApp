import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/feature/auth/data/models/request_models/send_otp_request.dart';
import 'package:chatapp/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:chatapp/feature/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendOtpUseCase {
  final AuthRepository _repository;

  SendOtpUseCase(this._repository);

  Future<Either<Failure, bool>> execute({required SendOtpRequest request}) {

    return _repository.sendOtp(request: request);
  }
}

// Provider
// Provider
final sendOtpUseCaseProvider = Provider<SendOtpUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SendOtpUseCase(repository);
});
