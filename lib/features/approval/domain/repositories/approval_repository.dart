import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/approval_entity.dart';

abstract class ApprovalRepository {
  Future<Either<Failure, List<ApprovalEntity>>> getPendingApprovals();
  Future<Either<Failure, ApprovalEntity>> approveContent(String contentId);
  Future<Either<Failure, ApprovalEntity>> rejectContent(String contentId, String reason);
}
