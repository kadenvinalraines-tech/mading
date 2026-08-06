import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/slider_entity.dart';
import '../../domain/repositories/slider_repository.dart';
import '../datasources/slider_remote_data_source.dart';

@LazySingleton(as: SliderRepository)
class SliderRepositoryImpl implements SliderRepository {
  final SliderRemoteDataSource remoteDataSource;

  SliderRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<SliderEntity>>> getSliders() async {
    try {
      final models = await remoteDataSource.getSliders();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SliderEntity>> uploadSlider({
    required String title,
    required String filePath,
    required String mediaType,
    required int durationSeconds,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        'media_type': mediaType,
        'duration_seconds': durationSeconds,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'file': await MultipartFile.fromFile(filePath),
      });

      final model = await remoteDataSource.uploadSlider(formData);
      return Right(model.toEntity());
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSlider(String id) async {
    try {
      await remoteDataSource.deleteSlider(id);
      return const Right(null);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
