import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/approval_entity.dart';
import '../repositories/approval_repository.dart';

@lazySingleton
class ApproveContentUseCase {
  final ApprovalRepository repository;

  ApproveContentUseCase(this.repository);

  Future<Either<Failure, ApprovalEntity>> call(String contentId) async {
    if (contentId.trim().isEmpty) {
      return const Left(ServerFailure('ID Konten tidak valid.'));
    }
    
    return repository.approveContent(contentId);
  }
}
