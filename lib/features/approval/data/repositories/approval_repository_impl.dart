import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/approval_entity.dart';
import '../../domain/repositories/approval_repository.dart';
import '../datasources/approval_remote_data_source.dart';

@LazySingleton(as: ApprovalRepository)
class ApprovalRepositoryImpl implements ApprovalRepository {
  final ApprovalRemoteDataSource _remoteDataSource;

  ApprovalRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<ApprovalEntity>>> getPendingApprovals() async {
    try {
      final models = await _remoteDataSource.getPendingApprovals();
      final entities = models.map((e) => e.toEntity()).toList();
      return Right(entities);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApprovalEntity>> approveContent(String contentId) async {
    try {
      final model = await _remoteDataSource.approveContent(contentId);
      return Right(model.toEntity());
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApprovalEntity>> rejectContent(String contentId, String reason) async {
    try {
      final model = await _remoteDataSource.rejectContent(contentId, reason);
      return Right(model.toEntity());
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
