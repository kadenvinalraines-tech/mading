import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/running_text_entity.dart';
import '../../domain/repositories/running_text_repository.dart';
import '../datasources/running_text_remote_data_source.dart';

@LazySingleton(as: RunningTextRepository)
class RunningTextRepositoryImpl implements RunningTextRepository {
  final RunningTextRemoteDataSource remoteDataSource;

  RunningTextRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<RunningTextEntity>>> getRunningTexts() async {
    try {
      final remoteData = await remoteDataSource.getRunningTexts();
      final entities = remoteData.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RunningTextEntity>> addRunningText(String text) async {
    try {
      final remoteData = await remoteDataSource.addRunningText(text);
      return Right(remoteData.toEntity());
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRunningText(String id) async {
    try {
      await remoteDataSource.deleteRunningText(id);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
