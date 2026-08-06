import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/approval_entity.dart';
import '../repositories/approval_repository.dart';

@lazySingleton
class RejectContentUseCase {
  final ApprovalRepository repository;

  RejectContentUseCase(this.repository);

  Future<Either<Failure, ApprovalEntity>> call(String contentId, String reason) async {
    if (contentId.trim().isEmpty) {
      return const Left(ServerFailure('ID Konten tidak valid.'));
    }
    
    if (reason.trim().isEmpty) {
      return const Left(ServerFailure('Alasan penolakan wajib diisi.'));
    }
    
    return repository.rejectContent(contentId, reason);
  }
}
