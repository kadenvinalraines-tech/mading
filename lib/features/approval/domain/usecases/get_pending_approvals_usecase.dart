import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/approval_entity.dart';
import '../repositories/approval_repository.dart';

@lazySingleton
class GetPendingApprovalsUseCase {
  final ApprovalRepository repository;

  GetPendingApprovalsUseCase(this.repository);

  Future<Either<Failure, List<ApprovalEntity>>> call() {
    return repository.getPendingApprovals();
  }
}
